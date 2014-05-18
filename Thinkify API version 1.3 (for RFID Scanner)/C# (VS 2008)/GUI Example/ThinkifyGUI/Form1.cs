using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
//using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using Thinkify;


namespace ThinkifyGUI
{
    public partial class Form1 : Form
    {
     
        ThinkifyReader Reader;

        Int32 readCount;

        /* Because C# can't be bothered to handle multi-threading in their controls, we have to make every 
         * call to a property thread safe ourselves... Why didn't they put this code in the control? */
        delegate void SetTextCallback(Control c, string text); 

        // Call this to safely set the text property of a control. See note above...
        private void SetText(Control c, string text) 
        {
            if (c.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(SetText);
                this.Invoke(d, new object[] {c, text });
            }
            else 
            {
                c.Text = text;
            }
            
        }

        // Call this to safely set the text property of a control. See note above...
        private void AppendText(Control c, string text)
        {
            if (c.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(AppendText);
                this.Invoke(d, new object[] { c, text });
            }
            else
            {
                c.Text = c.Text + text;
            }

 

        }


        public void ProcessTagReadEvent(object sender, TagReadEventArgs e)
        {
            //The TagReadEventsArgs includes a ThinkifyTag as an element. (See: ThinkifyReader.cs)
            //ThinkifyTag tag;
            //tag = e.tag;
            
            readCount += 1;

            // Look! We've taken an object oriented language and made it -- not!
            SetText(lblNumReads, readCount.ToString());

            string strTaglist;

            strTaglist = "";

            if (chkReading.Checked) 
            {
                foreach (ThinkifyTag T in Reader.TagList)
                {
                    strTaglist = strTaglist + T.EPC + " " + T.ReadCount.ToString() + "\r\n";  
                }

                SetText(txtReplys, strTaglist);
            }
        }


        public void ProcessTagXReadEvent(object sender, TagReadEventArgs e)
        {
            //Console.WriteLine(" XRD{0}:  {1}", e.XReadIndex, e.tag.XRData[e.XReadIndex]);
        }


        public void ProcessDataReceivedEvent(object sender, DataReceivedEventArgs e)
        {
            if (!chkReading.Checked)
            {
                AppendText(txtReplys, e.dataReceived);
            }
        }

        public Form1()
        {
            InitializeComponent();
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            Reader = new ThinkifyReader("COM3");

            //Connect the reader's TagReadEvent to our Event Handler.
            Reader.TagReadEvent += new TagReadEventHandler(ProcessTagReadEvent);

            //Connect the reader's extended read event to our Event Handler. 
            Reader.TagXReadEvent += new TagXReadEventHandler(ProcessTagXReadEvent);

            //Reader.DataReceivedEvent += new DataReceivedEventHandler(ProcessDataReceivedEvent);

            //Reader.Reset();

        }

        private void chkReading_CheckedChanged(object sender, EventArgs e)
        {
            chkReading.Enabled = false;
            Reader.ReadingActive = chkReading.Checked;
            chkReading.Enabled = true;

        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            Reader.Dispose();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Reader.TagList.Clear();
            txtReplys.Text = "";
            readCount = 0;
        }

        private void btnVersion_Click(object sender, EventArgs e)
        {
            SetText(txtReplys, Reader.Execute("v"));
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            Reader.Reset();

            //SetText(txtReplys, Reader.Reset());
        }

        private void btnReadUserMemory_Click(object sender, EventArgs e)
        {
            Reader.TagList.Clear();
            string strUserMemory = Reader.ReadUserMemory();
            SetText(txtReplys, strUserMemory );
        }

        private void btnResetXR_Click(object sender, EventArgs e)
        {
            SetText(txtReplys, Reader.Execute("XRR"));
        }

        private void btnSend_Click(object sender, EventArgs e)
        {
            txtReplys.Text = "";

            AppendText(txtReplys, Reader.Execute(txtSend.Text));
        }



    }
}
