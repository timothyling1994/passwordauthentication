using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO.Ports;
using System.Threading;
using Thinkify;

    //public delegate void TagReadEventHandler(object sender, TagReadEventArgs e);
    //public class TagReadEventArgs : EventArgs
    //{
    //    public TagData tag;

    //    public TagReadEventArgs(TagData atag)
    //    {
    //        tag = atag;
    //    }
    //}

    public class ThinkifyRFIDReader : GenericReader
    {

        public ThinkifyRFIDReader() 
        { 
            AntennaID = 1;
            connected = false;
            readerMutex = new Mutex(); 
        }


        private bool disposed = false;
        public override void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        public override void Dispose(bool disposing)
        {
            if (this.disposed == false && disposing)
            {
            }
        }

     
        ThinkifyReader rfid3;
        public ushort AntennaID { get; set; }
        List<string> tags = new List<string>();
        int totalReplyCount = 0;
        static Mutex readerMutex;
        bool connected;

        public override string Execute(string str)
        {
            return rfid3.Execute(str);
        }


        public override string ConnectReader_Probe()
        {
            string retStr = "not found";
            // 
            for (int i = 1; i < 20; i++)
            {
                try {
                    string comport = "COM" + i;
                    ConnectReader(comport);
                }
                catch {
                    continue;
                }
                retStr = "COM" + i;
                return retStr;
            }
            return retStr;
        }

        /// <summary>
        /// DoBlockingInventory
        /// </summary>
        public ThinkifyTagList DoBlockingInventory(int timeout)
        {
            if (!IsConnected())
            {
                return new ThinkifyTagList();
            }
            
            rfid3.TagList.Clear();
            DoInventory(timeout);
            try
            {
                ThinkifyTagList locatedTags = rfid3.TagList;    // GetReadTags(4);
                return locatedTags;
            }
            catch (Exception e)
            {
                Console.WriteLine("Error parsing tags: {0}", e.Message.ToString());
                return new ThinkifyTagList();

            }
        }


        public override string GetStrongestTag(int timeout)
        {
            if (!IsConnected())
            {
                return "";
            }
            ThinkifyTagList locatedTags = DoBlockingInventory(timeout);
            if (locatedTags != null)
            {
                ThinkifyTag bestTag = null;
                float bestRSSI = -200;
                foreach (ThinkifyTag tag in locatedTags)
                {
                    if (tag.RSSI > bestRSSI)
                    {
                        bestTag = tag;
                        bestRSSI = tag.RSSI;
                    }
                }

                rfid3.TagList.Clear();

                if (bestTag == null)
                {
                    return null;
                }
                return bestTag.EPC;
            }
            return null;
        }
 
        public override void printSummary()
        {
            if (!IsConnected())
            {
                return;
            }
            Console.WriteLine("");
            Console.WriteLine("");
            Console.WriteLine("Summary");
            Console.WriteLine("Total tag notifications: {0}", totalReplyCount);
            Console.WriteLine("Unique tags found: {0}", tags.Count);
            foreach (string tag in tags)
            {
                Console.WriteLine("     epc: {0}", tag);
            }
            Console.WriteLine("");
            Console.WriteLine("Press any key to continue...");
            Console.ReadKey(true);
        }

        /// <summary>
        /// DisconnectReader
        /// </summary>
        public override void DisconnectReader()
        {
            //rfid3.ReadingActive = false;
            if (rfid3 != null)
            {
                connected = false;
                rfid3.Dispose();
                rfid3 = null;
                System.Threading.Thread.Sleep(250);
            }
        }

        /// <summary>
        /// ConnectReader
        /// </summary>
        /// <param name="address"></param>
        public override bool ConnectReader(string address)
        {
            if (rfid3 == null)
            {
                rfid3 = new ThinkifyReader(address);
                rfid3.Execute("v");
                rfid3.Execute("iq0");
                rfid3.Execute("io3");
                rfid3.Execute("ii3");
                connected = true;
            }
            return true;
        }

        public override bool IsConnected()
        {
            return connected;
        }

        public override void RegisterCallbacks()
        {
            if (!IsConnected())
            {
                return;
            }
            readerMutex.WaitOne();
            readerMutex.ReleaseMutex();
        }


        public override void UnregisterCallbacks()
        {
            if (!IsConnected())
            {
                return;
            }
            readerMutex.WaitOne();
            readerMutex.ReleaseMutex();
        }

        /// <summary>
        /// DoInventory
        /// </summary>
        /// <param name="time"></param>
        public override void DoInventory(int time)
        {
            if (!IsConnected())
            {
                return;
            }
            readerMutex.WaitOne();
            if (time == 0)
            {
                time = 100;
            }
            try
            {
                rfid3.ReadingActive = true;
                Thread.Sleep(time);
                rfid3.ReadingActive = false;
            }
            catch (Exception e)
            {
                Console.WriteLine("Error doing inventory: {0}", e.Message.ToString());
                
            }
            readerMutex.ReleaseMutex();
        }


        /// <summary>
        /// DoTagRead
        /// </summary>
        /// <param name="tagId"></param>
        /// <param name="size"></param>
        /// <param name="offset"></param>
        /// <param name="bank"></param>
        /// <param name="access"></param>
        public override string DoTagRead(string tagId, uint size, uint offset, uint bank, uint access)
        {
            if (!IsConnected())
            {
                return "";
            }
            int numRetries = 3;
            readerMutex.WaitOne();

            do
            {
                try
                {
                    // Start the stopwatch
                    //Stopwatch sw = Stopwatch.StartNew();

                    rfid3.ReadingActive = false;
                    string tagData = rfid3.ReadUserMemory();
                    //sw.Stop();
                    //Console.WriteLine("READ: Time used (float): {0} ms", sw.Elapsed.TotalMilliseconds);

                    readerMutex.ReleaseMutex();
                    if (tagData[0] == '\n')
                    {
                        return "";
                    }
                    int indexTest = tagData.IndexOf("\n\n");
                    if (indexTest != -1)
                    {
                        return "";
                    }
                    tagData = tagData.Replace("\n", "");

                    string retStr = HexString2Ascii(tagData);
                    return retStr;
                }
                catch (Exception e)
                {
                    if (numRetries <= 0)
                    {
                        Console.WriteLine("Too many retries, giving up. {0}",e.ToString());
                        readerMutex.ReleaseMutex();
                        return "";
                    }
                }
            } while (numRetries-- > 0);
            readerMutex.ReleaseMutex();
            return "";
        }

 

        /// <summary>
        /// 
        /// </summary>
        /// <param name="tagId"></param>
        /// <param name="writeData"></param>
        /// <param name="size"></param>
        /// <param name="offset"></param>
        /// <param name="bank"></param>
        /// <param name="access"></param>
        public override void DoTagWrite(string tagId, string data, uint size, uint offset, uint bank, uint access)
        {
            if (!IsConnected())
            {
                return;
            }
            readerMutex.WaitOne();

            try
            {
                Console.WriteLine("Writing tag: {0}", tagId);
                // convert string to hex string
                string hex = "";
                foreach (char c in data)
                {
                    int tmp = c;
                    hex += String.Format("{0:x2}", (uint)System.Convert.ToUInt32(tmp.ToString()));
                }

                //Stopwatch sw = Stopwatch.StartNew();
                rfid3.WriteUserMemory(hex);
                //sw.Stop();
                //Console.WriteLine("WRITE: Time used (float): {0} ms",sw.Elapsed.TotalMilliseconds);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error writing tag: {0}", e.Message.ToString());
                readerMutex.ReleaseMutex();
                return;
            }
            
            readerMutex.ReleaseMutex();
        }





        ~ThinkifyRFIDReader()
        {
            //Dispose(false);
        }


        /// <summary>
        /// Events_ReadNotify
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //public void Events_ReadNotify(object sender, Events.ReadEventArgs e)
        //{
        //    totalReplyCount += 1;
        //    Console.WriteLine("Found tag: {0}", e.ReadEventData.TagData.TagID);
        //    if (tags.Contains(e.ReadEventData.TagData.TagID))
        //    {
        //        return;
        //    }

        //    tags.Add(e.ReadEventData.TagData.TagID);
        //}


        /// <summary>
        /// OnStatus
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //public void OnStatus(object sender, Events.StatusEventArgs e)
        //{
        //    Console.WriteLine("OnGotStatus");
        //}
    }
//}
