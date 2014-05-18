

import com.thinkify.rfid.*;

/**
 * Sample application to show how to connect to a Thinkify RFID reader
 * and perform basic communication tasks.
 * 	
 * @author David Krull
 */
public class TestThinkifyReader {

	public static void main(String[] args) {
		System.out.println("TestThinkifyReader sample appplication, v." + ThinkifyReader.VERSION);
		
		// Constructor takes the serial device name. Use SerialManager directly to determine available port names.
		ThinkifyReader r = new ThinkifyReader("usbmodem411");
		r.debugLevel = 0; // 0=none, 1=TX/RX, >1=Verbose

		// Do a sloppy catch of any exceptions
		try {
			r.open();
			
			System.out.println("\nReader's Firmware Version:");
			System.out.println(r.getVersion()); // some commands may have methods provided for you, like getVersion()
			
			System.out.println("\nInventory Parameters:");
			System.out.println(r.send_receive("i")); // others commands may not, so use send_receive(<readerCmd>) and you'll get the entire response
			
			System.out.println("\nStrongest Tag:");
			ThinkifyTag tag = r.find_strongest_tag(); // some methods may do a bunch of stuff for you
			System.out.println(tag.getEpc() + ", f=" + tag.getFrequecy() + ", count=" + tag.getReadCount()); // pick apart the ThinkifyTag
			
			System.out.println("\nReading Tags in Background...");
			r.setAutoMode(true); // This starts the reader reading continuously, and preps the class to start collecting async data
			Thread.sleep(2000);
			System.out.println("   ...but you can still ask other questions while reading tags:");
			System.out.println("      RF Attenuation = " + r.execute("ra")); // execute() is like send_receive(), but removes the "<param>=" part of response 
			System.out.println("   ...");
			Thread.sleep(2000);
			r.setAutoMode(false); // Stops the reader's background scanning

			// Background tag reads get collected in ThinkifyReader's public ThinkifyTaglist
			System.out.println("Total Tags: " + r.taglist.size());
			for (ThinkifyTag aTag : r.taglist) {
				System.out.println(aTag.toString());
			}
			r.taglist.clear();
			
			System.out.println("\nPlaying with the LEDs:");
			for (int i=0x0; i<=0xF; i++) {
				System.out.print(i + ", ");
				r.setLEDs(i);
				Thread.sleep(500);
			}
			System.out.println("0");
			r.setLEDs(0);
			
			System.out.println("\nClosing:");
			r.close();
			
			System.out.println("\nEnd of TestThinkifyReader sample app.\n");
			System.exit(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
