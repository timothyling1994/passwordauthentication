using System;
using System.IO;
using System.Threading;
using System.Diagnostics;
using Thinkify;

/*
A little console-based program that you can use to test your RFID reader. 
*/

    public class Runner
    {

        /* We set up an event handler to deal with the TagReadEvent from the reader. 
         * For now, let's just show what we've received.
         */
        public void ProcessTagReadEvent(object sender, TagReadEventArgs e)
        {
            //The TagReadEventsArgs includes a ThinkifyTag as an element. (See: ThinkifyReader.cs)
            ThinkifyTag tag;
            tag = e.tag;
            //Uncomment if you want to watch every read come in...
            Console.WriteLine("HEY! We saw a tag! ID: {0}  RSSI: {1}", tag.EPC, tag.RSSI);
        
        }

        public void ProcessTagXReadEvent(object sender, TagReadEventArgs e)
        {
            //Console.WriteLine(" XRD{0}:  {1}", e.XReadIndex, e.tag.XRData[e.XReadIndex]);
        }


        public void ReadTags(ThinkifyReader Reader)
        {
            
            string s = Reader.Execute("T62");
           // Console.WriteLine(s);

            Reader.TagList.ProcessReaderMessage(s);

        }

        public void DumpTaglist(ThinkifyReader Reader)
        {

            foreach (ThinkifyTag T in Reader.TagList)
            {
                Console.WriteLine(T.EPC + " " + T.ReadCount.ToString()  );
            }

            Reader.TagList.Clear();

        }
       
        public void Run()
        {
            //Set the COM port to the appropriate one for your reader. 
            ThinkifyReader Reader = new ThinkifyReader("COM3");

            //Connect the reader's TagReadEvent to our Event Handler.
            Reader.TagReadEvent  += new TagReadEventHandler(ProcessTagReadEvent);

            //Connect the reader's extended read event to our Event Handler. 
            Reader.TagXReadEvent += new TagXReadEventHandler(ProcessTagXReadEvent);


            //Say Hello.
            Console.WriteLine("-------------------------------------------");
            Console.WriteLine(" Welcome to The Thinkify TR200 RFID Reader ");
            Console.WriteLine("-------------------------------------------");
            Console.WriteLine("");
            
            //Put the reader back to factory default state. 
            Reader.Reset();

            //We've got a couple of methods for common commands. 
            Console.WriteLine("Firmware version is: \n{0}", Reader.Version);
            Console.WriteLine("RF Attenuation is: \n{0}", Reader.Attenuation);
            Console.WriteLine("");

            //You can also use a synchronous call (Reader.Execute) to get data from the reader. 
            //You can send any command in the protocol spec. 
            Console.WriteLine("Inventory Parameters are: \n{0}", Reader.Execute("i"));
            Console.WriteLine("");

            //Let's program a tag. -- Hold one up and It'll try to put this ID in it...
            Console.WriteLine("Program EPC Result: {0}", Reader.ProgramEPC("3333 4444 5555 5555 2222 2222"));
            Console.WriteLine("");

            //Reading uses asynchronous calls. We turn the reader on and wait for read events to come in 
            //that we deal with in our event handler.
            Console.WriteLine("Let's Read for a bit...");
            Console.WriteLine();
            //Setting ReadingActive=True starts continuous polling. Whenever a tag is read, the assigned
            //TagReadEventHandler (In our case, ProcessTagReadEvent) will be called.

            Reader.ReadingActive = true;

            Thread.Sleep(1000);

            //Turn off continuous polling. -- Reader is now ready to accept synchronous commands again.
            Reader.ReadingActive = false;

            Console.WriteLine();
            Console.WriteLine("What did we see?");
            DumpTaglist(Reader);
            Console.WriteLine();

            Console.WriteLine("Try to Read the Tag's user memory...");
            Console.WriteLine(Reader.ReadUserMemory());
            Console.WriteLine();
    
            Console.WriteLine("Done!");

            
            Reader.Dispose();

            Console.ReadLine();

        }


        public static void Main()
        {
            Runner r = new Runner();
            r.Run();
        }
           
    }