using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;

namespace Thinkify
{

    //A little class to hold Tag read data. It can be constructed from a tag read string (a line of text 
    //sent during an inventory) from the reader.
    public class ThinkifyTag : IComparable<ThinkifyTag>
    {

        public string[] XRData;
        public string[] XWData; //Value of Xwrite descriptor return.

        public ThinkifyTag()
        {
            //Make an empty tag
            ConstructFromString("TAG=000000000000000000000000000 000000 00 0 0 Q 0000");
        }

        public ThinkifyTag(string stringFromReader)
        {
            //Build a tag from a "TAG=" string from the reader.
            ConstructFromString(stringFromReader);
        }

        public int CompareTo(ThinkifyTag other)
        {
            // If other is not a valid object reference, this instance is greater.
            if (other == null) return 1;
            // Use the EPC as our key.
            return EPC.CompareTo(other.EPC);
        }


        public string EPC
        {
            get;
            set;
        }

        public float Frequency
        {
            get;
            set;
        }

        public Int16 Antenna
        {
            get;
            set;
        }

        public Int32 ReadCount
        {
            get;
            set;
        }

        public DateTime ReadTime
        {
            get;
            set;
        }

        public float RSSI
        {
            get;
            set;
        }

        public bool Updated
        {
            get;
            set;
        }

        public bool Reported
        {
            get;
            set;
        }

        private float CalcRSSI(Int16 iSig, Int16 qSig)
        {
         //Calculate the RSSI from the I/Q signals...
            float hiRSSI;
            float deltaRSSI;

            float f1 = (float)(iSig);
            float f2 = (float)(qSig);

            deltaRSSI = Math.Abs(f2 - f1);

            if (f1 > f2) { hiRSSI = f1; } else { hiRSSI = f2; }
            return  2 * hiRSSI + 10 * (float)Math.Log(1 + Math.Pow(10, (-deltaRSSI / 10)));
        }


        //Update this tag with the contents of another tag. Merge Count and Time. Assign Xdata from new tag if it exists.
        public void Update(ThinkifyTag t) 
        {
            if (this.EPC == t.EPC)
            { 
                this.RSSI = t.RSSI; 
                this.ReadCount += t.ReadCount; 
                this.Frequency = t.Frequency; 
                this.ReadTime = t.ReadTime;
                this.Reported = t.Reported;

                int i;


                for (i=0;i<this.XRData.Length;i++)
                {
                    if (t.XRData[i] != null)
                    {
                        this.XRData[i] = t.XRData[i];
                    }
                }
            }
        }


        /*Populate the elements of this class from a tag read event string from the reader. 
         * Data is of the form:
         * 
            STARTINVENTORY
            TAG=3000111122223333444455556666 923750 03 0 3 Q B2F8
            TAG=3000111122223333444455556666 923750 03 0 3 Q B30A
            TAG=3000111122223333444455556666 923750 00 0 3 Q B31E
            ...
            TAG=3000111122223333444455556666 925250 03 0 3 Q B49C
            STOPINVENTORY=0x0015 0x01C8

            READY>
         * 
         * the fields are: 
         * epc, frequency, slot counter, isig, qsig, read channel, timestamp
         * 
         */
        public bool ConstructFromString(string stringFromReader)
        {
            bool retValue;
            retValue = false;

            string delimString;
            delimString = "= ";

            char[] delimiter = delimString.ToCharArray();

            string[] split =null;
            split = stringFromReader.Split(delimiter);

            //If the data split correctly, let's just use it.
            if (split.Length == 8 )
            {
                this.EPC = split[1];
                this.ReadCount = 1;
                this.Antenna = 1;
                this.ReadTime = DateTime.Now;

                Int16  num1 = Convert.ToInt16(split[4], 16);
                Int16  num2 = Convert.ToInt16(split[5], 16);

                this.RSSI = CalcRSSI(num1, num2);

                XRData = new string[4];  //Holder for any XRead data that comes in.
                XWData = new string[4];  //Holder for the result of XWrite operation
                retValue = true;

                
            }
            
            return retValue;
       
        }

        public bool UpdateXWRData(string stringFromReader)
        {

            if (stringFromReader.IndexOf("SUCCESS") >=0)
            {
                string[] data;
                char[] delimiter = { '=' };

                data = stringFromReader.Split(delimiter);

                if (stringFromReader.IndexOf("XWR0") == 0)
                {
                    XWData[0] = data[1];
                }
                if (stringFromReader.IndexOf("XWR1") == 0)
                {
                    XWData[1] = data[1];
                }
                if (stringFromReader.IndexOf("XWR2") == 0)
                {
                    XWData[2] = data[1];
                }
                if (stringFromReader.IndexOf("XWR3") == 0)
                {
                    XWData[3] = data[1];
                }

                return true;

            }

            return false;
        }

        public bool UpdateXRDData(string stringFromReader)
        { 
           
            if ((stringFromReader.IndexOf("RESPONSE FAILURE")==-1) && (stringFromReader.IndexOf("ERROR") ==-1))
            {
              string[] data;
              char[] delimiter = { '=' };

              data = stringFromReader.Split(delimiter);

              if (stringFromReader.IndexOf("XRD0")==0)
              {
                  XRData[0] =data[1];
              }
              if (stringFromReader.IndexOf("XRD1") == 0)
              {
                  XRData[1] = data[1];
              }
              if (stringFromReader.IndexOf("XRD2") == 0)
              {
                  XRData[2] = data[1];
              }
              if (stringFromReader.IndexOf("XRD3") == 0)
              {
                  XRData[3] = data[1];
              }

              return true;
  
            }

            return false;
        }
            
    }
}
