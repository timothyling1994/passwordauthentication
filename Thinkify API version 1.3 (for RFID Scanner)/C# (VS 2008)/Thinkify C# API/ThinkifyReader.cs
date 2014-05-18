using System;
using System.IO.Ports;
using System.Threading;
using System.Diagnostics;
using Thinkify;

namespace Thinkify
{
    //Raw Serial Events
    public delegate void DataReceived(object sender, DataReceivedEventArgs e);

    //Event handler for Reading the Tag's EPC
    public delegate void TagReadEventHandler(object sender, TagReadEventArgs e);
    //Event handler for eXtended read data. e.g. User Memory...
    public delegate void TagXReadEventHandler(object sender, TagReadEventArgs e);

    public class TagReadEventArgs : EventArgs
    {
        public ThinkifyTag tag;

        public Int32 XReadIndex
        {
            get;
            set;
        }

        public TagReadEventArgs(ThinkifyTag atag)
        {
            tag = atag;
            this.XReadIndex = -1;   
        }
    }

    public class ThinkifyReader : IDisposable
    {
        private ThinkifySerialConnection sC;

        public ThinkifyTag latestTag; //The last tag we've seen. Update as we re-read it.

        public ThinkifyTagList TagList;
   
        bool ReadingActiveValue;

        public event TagReadEventHandler TagReadEvent;
        public event TagXReadEventHandler TagXReadEvent;
        public event DataReceivedEventHandler DataReceivedEvent;

        public ThinkifyReader(string port)
        {
            sC = new ThinkifySerialConnection(port);
            TagList = new ThinkifyTagList();

            //If a new line comes in 
            sC.LineReceivedEvent += new LineReceivedEventHandler(ProcessLine);
            sC.DataReceivedEvent += new DataReceivedEventHandler(ProcessData);

            ReadingActiveValue = false;
            latestTag = new ThinkifyTag();

        }

        ~ThinkifyReader()
        {
            if (sC != null)
            {
                ReadingActive = false;
                sC.Close();
                Dispose(false);
            }
            
        }

        public void DisconnectReader()
        {
            this.ReadingActive = false;
            if (this != null)
            {
                
                Dispose();
              
                System.Threading.Thread.Sleep(250);
            }
        }

        private bool disposed = false;

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public void Dispose(bool disposing)
        {
            if (this.disposed == false && disposing)
            {
                if (sC != null)
                {
                    sC.LineReceivedEvent -= new LineReceivedEventHandler(ProcessLine);
                    sC.DataReceivedEvent -= new DataReceivedEventHandler(ProcessData);
                    ReadingActive = false;
                    System.Threading.Thread.Sleep(250);  
                    sC.Close();
                }
            }
        }

        public bool ReadingActive
        {
            get
            {
                return ReadingActiveValue;
            }

            set
            {
                if (value)
                {
                    //Start continuously reading
                    sC.replyPending = false;
                    sC.Send("t6");
                    ReadingActiveValue = true;
                }
                else
                {
                    sC.SendReceive("", 500);
                    ReadingActiveValue = false;
                }
            }
        }

        //Find how many times a target substring occurs in source string.
        //What's up w/the lame string handling functions in this language?!
        private int count_occurences(string source, string target)
        {
            return (source.Length - source.Replace(target,"").Length);
        }

        public string Execute(string command)
        {
            string reply;

            //Check if the reader is Active. If so, stop it execute the command and restart.
            bool originalState = ReadingActive;
            if (ReadingActive) {ReadingActive = false;}

            reply = SendReceive(command);

            if (count_occurences(reply, "=")==1)
            {
                //This is a simple parameter reply. -- Just return the payload.
                reply = reply.Remove(0, reply.IndexOf("=")+1);
            }

            if (originalState != ReadingActive)
            {
                ReadingActive = originalState;
            }

            return reply; 
        }

        public void Send(string message)
        {
            sC.Send(message);
        }

        private string SendReceive(string message)
        {
            // Default timeout of 2 sec for sychronous commands.
            return sC.SendReceive(message,10000);
        }

        public string Reset() { 
           return Execute("brs");
        }

        public string Version
        {
            get
            {
                return Execute("v");
            }
        }

        public int Attenuation
        {
            get 
            {
                return System.Convert.ToInt32(Execute("RA"));
            }
            set 
            {
                Execute("RA" + System.Convert.ToString(value));
            }
       
        }

        //Takes a big string of hex data and tries to program it into user memory. 
        //Starting location 0. Ending location, fixed value. 
        //TODO: Parameterize this. 
        public bool WriteUserMemory(string data)
        {

            int pointer = 0; 
            string strPointer = "";
            string strData = "";

            //Currently fixed. Change to reflect length of the string. 
            for (int j = 0; j < 3; j++)
            {
                //Set up four write descriptors. Note that this thing'll blow up if the string is too small.
                //TODO: Fix.
                for (int i = 0; i < 4; i++)
                {
                    strPointer = String.Format("{0:x2}", (uint)System.Convert.ToUInt32(pointer));
                    strData = data.Substring(4 * pointer, 32);
                    //Console.WriteLine(strPointer);
                    //Console.WriteLine(strData);
                    EnableWrites(i, "3", "8", strPointer, strData);
                    pointer = pointer + 8;
                }

                //Write user memory block uses the four descriptors. It spins a while with a timeout. might want to implement more retries.
                //Console.WriteLine(WriteUserMemoryBlock());
            }
            DisableWrites();
            return true;
        
        }

        public string WriteUserMemoryBlock()
        {
            bool dataOK = false;

            TagList.Clear();

            ReadingActive = true;

            int i = 0;

            while (dataOK == false)
            {
                if (TagList.Count > 0)
                {
                    //If all the memory we asked for has been read, we are done.
                    if ((TagList[0].XWData[0] != null) & (TagList[0].XWData[1] != null) & (TagList[0].XWData[2] != null) & (TagList[0].XWData[3] != null))
                    {
                        dataOK = true;
                    }

                    i++;

                    //Give up after 20 tries...
                    if (i > 20)
                    {
                        dataOK = true;
                    }
                    
                }
                Thread.Sleep(50);
            }
            ReadingActive = false;
            //Return whatever we find.
            return (TagList[0].XWData[0] + "\n" + TagList[0].XWData[1] + "\n" + TagList[0].XWData[2] + "\n" + TagList[0].XWData[3]) + "\n";
        }

        public string ReadUserMemory()
        {
            string retValue = "";

            //Bank 3 = USER MEMORY. Use Four descriptors.
            EnableExtendedReads(0, "3", "8", "00");
            EnableExtendedReads(1, "3", "8", "08");
            EnableExtendedReads(2, "3", "8", "10");
            EnableExtendedReads(3, "3", "8", "18");

            retValue += ReadUserMemoryBlock();

            //Uncomment below if you want to look at tags with BIG memory...
            ////Bank 3 = USER MEMORY. Use Four descriptors.
            //EnableExtendedReads(0, "3", "8", "20");
            //EnableExtendedReads(1, "3", "8", "28");
            //EnableExtendedReads(2, "3", "8", "30");
            //EnableExtendedReads(3, "3", "8", "38");

            //retValue += ReadUserMemoryBlock();

            ////Bank 3 = USER MEMORY. Use Four descriptors.
            //EnableExtendedReads(0, "3", "8", "40");
            //EnableExtendedReads(1, "3", "8", "48");
            //EnableExtendedReads(2, "3", "8", "50");
            //EnableExtendedReads(3, "3", "8", "58");

            //retValue += ReadUserMemoryBlock();

            DisableExtendedReads();

            return retValue;

        }
                    
        //Special Purpose tool for grabbing a chunk of user memory...
        //XRead data descriptors must be set up prior to calling this function.
        //Here we make use of all four descriptors to get as much data as possible. 
        // -- See: ReadUserMemory
        public string ReadUserMemoryBlock() 
        {

            TagList.Clear();

            string readerReply = Execute("T63");

            TagList.ProcessReaderMessage(readerReply);

            //Return whatever we find.
            if (TagList.Count > 0)
            {
                return (TagList[0].XRData[0] + "\n" + TagList[0].XRData[1] + "\n" + TagList[0].XRData[2] + "\n" + TagList[0].XRData[3]) + "\n";
            }
            else 
            {
                return "";
            }
        }

        public bool ProgramTag(int bank, string pointer, string data)
        {
            //execute a synchronous programming operation. 
            bool retValue;

            //our reader has the option to do multiple write operations at once... 
            //kinda cool, but I'm going to limit it to one in this function...

            //Strip spaces...
            data = data.Replace(" ", "");

            int words;
            words = data.Length / 4;

            //Enable the write descriptor =2 to allow change of pc word.
            string reply;

            if (bank == 1) // Allow changing of the PC word for EPC programming
            {
                reply = Execute("xw03" + bank + System.Convert.ToString(words) + "02" + data);
            }
            else
            {
                reply = Execute("xw011" + System.Convert.ToString(words) + pointer + data);
            }
            //make up to three attempts
            reply = Execute("t63");

            if (reply.IndexOf("XWR0=SUCCESS") >= 0)
            {
                retValue = true;
            }
            else
            {
                retValue = false;
            }

            //Disable programming.
            reply = Execute("xw00");

            return retValue;

        }

        public bool ProgramEPC(string newEPC)
        { 
            bool retValue;

            retValue = ProgramTag(1, "02", newEPC);

            return retValue;     
        
        }

        //Clear the write descriptors
        public bool DisableWrites()
        {
            string strCommand = "";

            strCommand = "XWR"; //+ index.ToString() + "0";
            Execute(strCommand);
            return true;
        }

        public bool EnableWrites(int index, string bank, string numWords, string ebvPointer, string data)
        {
            string strCommand = "";

            strCommand = "XW" + index.ToString() + "1" + bank + numWords + ebvPointer + data;

            Execute(strCommand);

            return true;

        }

        //Clear the read descriptors
        public bool DisableExtendedReads() 
        {
            string strCommand = "";

            strCommand = "XRR"; //+ index.ToString() + "0";
            Execute(strCommand);
            return true;
        }

        public bool EnableExtendedReads(int index, string bank, string numWords, string ebvPointer) 
        {
            string strCommand = "";

            strCommand = "XR" + index.ToString() + "1" + bank + numWords + ebvPointer;

            Execute(strCommand);

            return true;

        }

        private void ProcessData(object sender, DataReceivedEventArgs e)
        {
            //a placeholder for later...
            RaiseDataReceivedEvent(e);

        }

        private void ProcessLine(object sender, LineReceivedEventArgs e)
        {

            TagList.ProcessReaderMessage(e.lineReceived);

            if (e.lineReceived.IndexOf("TAG=") == 0)
            {
                ThinkifyTag t = new ThinkifyTag(e.lineReceived);

                if (t.EPC != latestTag.EPC) // A new guy! Reset latest tag.
                {
                    latestTag = t;
                }
                else
                {   //It's the tag we've seen before. Just update the latestTag w/ the new data...

                    latestTag.Update(t);
                }

                TagReadEventArgs ev = new TagReadEventArgs(latestTag);
                RaiseTagReadEvent(ev);

            }


            //Extended reads are enabled. -- update the data for the last tag seen.

            if (e.lineReceived.IndexOf("XRD") == 0)
            {
                bool goodResult = latestTag.UpdateXRDData(e.lineReceived);
                
                //goodResult = true; //TODO: Look at if we want to use this...
                //OK, we'll only report a Xread event if we have a valid one... 
                if (goodResult) {
                    TagReadEventArgs ev = new TagReadEventArgs(latestTag);
                    //I can't _believe_ how poorly this language deals with moving from strings to other data types. REALLY?
                    ev.XReadIndex = int.Parse(e.lineReceived[3].ToString());  //Parse doesn't even deal w/Hex! How much "parse"ing is going on, then?
                    RaiseTagXReadEvent(ev);
                }

            }

        }

        private void RaiseTagXReadEvent(TagReadEventArgs e)
        {
            if (TagXReadEvent != null)
                TagXReadEvent(this, e);
        }

        private void RaiseTagReadEvent(TagReadEventArgs e)
        {
            if (TagReadEvent != null)
                TagReadEvent (this, e);
        }

        private void RaiseDataReceivedEvent(DataReceivedEventArgs e)
        {
            if (DataReceivedEvent != null)
                DataReceivedEvent(this, e);
        }

    }

}