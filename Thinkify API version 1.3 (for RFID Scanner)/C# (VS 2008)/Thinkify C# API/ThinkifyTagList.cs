using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.IO;


//Placeholder. -- Will expand.
namespace Thinkify
{
    public class ThinkifyTagList:List<ThinkifyTag> 
    {
        //private List<ThinkifyTag> TagList;
        private ThinkifyTag latestTag;

        public ThinkifyTagList()
        {      
            
        }

        ~ThinkifyTagList()
        {
        }


        public bool ProcessReaderMessage(string rdrMessage)
        {
            using (StringReader strReader = new StringReader(rdrMessage))
            {
                string line;
                while ((line = strReader.ReadLine()) != null)
                {
                    ProcessLine(line);
                }
            }

            return true;

        }


        public bool ProcessLine(string msgLine){

            //Console.WriteLine("Line: {0}", msgLine);
            
            if (msgLine.IndexOf("TAG=") == 0)
            {
                ThinkifyTag t = new ThinkifyTag(msgLine);

                ThinkifyTag thisTag = base.Find(o => o.EPC == t.EPC);

                if (thisTag == null )
                {
                    base.Add(t);
                    latestTag = t;
                }
                else
                {
                    thisTag.Update(t);
                    latestTag = thisTag;

                }

            }

            //Extended reads are enabled. -- update the data for the last tag seen.
            if (msgLine.IndexOf("XRD") == 0)
            {

                if (latestTag != null)
                {
                   bool goodResult = latestTag.UpdateXRDData(msgLine);
                }

            }

            //Writes are enabled. -- update the data for the last tag seen.
            if (msgLine.IndexOf("XWR") == 0)
            {
                if (latestTag != null)
                {
                    bool goodResult = latestTag.UpdateXWRData(msgLine);
                }
            }

            return true;
        
        }



    }
}
