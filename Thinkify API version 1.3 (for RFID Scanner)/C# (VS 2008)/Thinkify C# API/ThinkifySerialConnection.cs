using System;
using System.IO.Ports;
using System.Threading;
using SerialPortTester;

namespace Thinkify

{
    public delegate void LineReceivedEventHandler(object sender, LineReceivedEventArgs e);
    public class LineReceivedEventArgs : EventArgs
    {
        public LineReceivedEventArgs(string lineReceived)
        {
            this.lineReceived = lineReceived;
        }
        public string lineReceived;
    }	//end of class LineReceivedEventArgs

    public delegate void DataReceivedEventHandler(object sender, DataReceivedEventArgs e);
    public class DataReceivedEventArgs : EventArgs
    {
        public DataReceivedEventArgs(string dataReceived)
        {
            this.dataReceived = dataReceived;
        }
        public string dataReceived;
    }	//end of class DataReceivedEventArgs

    /*
     *SerialConnection: a threaded com port wrapper that allows messages to be sent to a com port and
     *replies to be processed. Commands may be either synchronous, or asynchronous. Events are used 
     *to notify subscribers of the arrival of data or lines of data.
     */
    public class ThinkifySerialConnection
    {
        SerialPort serialPort;

        string rxBuffer;
        public bool replyPending;

        public event LineReceivedEventHandler LineReceivedEvent;
        public event DataReceivedEventHandler DataReceivedEvent;

        const string msgTerminator = "READY>";

        public ThinkifySerialConnection(string comport)
        {
            // Create a new SerialPort object with default settings.
            serialPort = new SerialPort(comport, 115200, Parity.None, 8, StopBits.One);

            // Set the read/write timeouts
            serialPort.ReadTimeout = 2500;
            serialPort.WriteTimeout = 500;
            serialPort.ReceivedBytesThreshold = 1;

            serialPort.DataReceived += new SerialDataReceivedEventHandler(serialPort_DataReceived);

            SerialPortFixer.Execute(comport);

            if (serialPort.IsOpen == false)
            {
                serialPort.Open();
                serialPort.BaseStream.Flush();
            }

            rxBuffer = "";
            replyPending = false;

        }

        ~ThinkifySerialConnection()
        {
            serialPort.Close();
        }

        public void Close()
        {
            serialPort.Close();
        }

        /* Send a message to the reader. Terminate w/CRLF */
        public void Send(string message)
        {
            message += "\r\n";
            serialPort.Write(message);
        }

        /* Wait for a reply from the reader. Replies end with a terminator. 
         * Aborts after timeout_ms without a reply */
        public string Receive(string terminator, long timeout_ms)
        {

            string receivedData;
            Int32 termIndex;
 
            long delta_t;
            DateTime t1, t2;
            long timeout = timeout_ms * 10000; //timeout in nanoseconds

            receivedData = "";

            t1 = DateTime.Now;
            t2 = t1;

            delta_t = (t2.Ticks - t1.Ticks);

            while (replyPending && (delta_t < timeout))
            {
                delta_t = (t2.Ticks - t1.Ticks);

                t2 = DateTime.Now;
                
                termIndex = rxBuffer.IndexOf(terminator);

                if (termIndex > 0)
                {
                    receivedData = rxBuffer.Substring(0, termIndex);
                    rxBuffer = rxBuffer.Remove(0, termIndex + terminator.Length);
                    replyPending = false;
                }

            }

            return receivedData;

        }

        /*Execute a synchronous call. -- Execute a Send, Wait for a reader reply. */
        public string SendReceive(string message, long timeout_ms)
        {
            string readerReply;

            rxBuffer = "";
            replyPending = true;

            Send(message);

            readerReply = Receive(msgTerminator, timeout_ms);

            return readerReply;

        }

        protected virtual void RaiseDataReceivedEvent(DataReceivedEventArgs e)
        {
            if (DataReceivedEvent != null)
                DataReceivedEvent(this, e);
        }

        protected virtual void RaiseLineReceivedEvent(LineReceivedEventArgs e)
        {
            if (LineReceivedEvent != null)
                LineReceivedEvent(this, e);
        }

        void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string readData;
            string thisLine;
            Int32 newLineIndex;

            try
            {
                //Append the data to the receive buffer.
                readData = serialPort.ReadExisting();
                rxBuffer += readData;

                if (replyPending == false) //Streaming data coming in or idle...
                {
                    /* This is an asynch reply. -- We can raise an event here to let others deal with the data 
                     * coming in.  Once we have a complete line of text, fire off the event and trim off the buffer.
                    */
                    bool processing;

                    processing = true;

                    while (processing)
                    {

                        newLineIndex = rxBuffer.IndexOf("\n");

                        //no new line in here...
                        if (newLineIndex == -1)
                        {
                            processing = false;
                        }

                        //new line is 1st char
                        else if (newLineIndex == 0)
                        {
                            rxBuffer = rxBuffer.Remove(0, newLineIndex + 1);
                            processing = false;
                        }

                        //there's stuff before the new line
                        else if (newLineIndex > 0)
                        {
                            thisLine = rxBuffer.Substring(0, newLineIndex);
                            rxBuffer = rxBuffer.Remove(0, newLineIndex + 1);
                            RaiseLineReceivedEvent(new LineReceivedEventArgs(thisLine));
                        }
                    }
                }

                RaiseDataReceivedEvent(new DataReceivedEventArgs(readData));
            }
            catch (TimeoutException)
            {
                Console.WriteLine("Timeout!");
            }
 
        }

    }
}