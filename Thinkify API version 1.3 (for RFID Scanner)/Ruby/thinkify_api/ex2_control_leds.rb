=begin rdoc
=Example Program
==control_leds.rb	

This program shows how to open a connection to the reader, show the firmware 
version and play with the LEDs...
 
Copyright 2011, Thinkify LLC. All rights reserved.
=end

#append the current directory to the search path
$: << File.dirname(__FILE__)


#Add the default relative library location to the search path
$: << File.join(File.dirname(__FILE__),"..","thinkify_api")

#require our library
require 'thinkifyreader'

# Create a reader to work with. 
# On windows / ubuntu linux you can just call .new and the class will scan for 
# the first reader it can find (upto com20 on windows.) Under other linux, 
# flavors you must specify the /dev/ttyXX file descriptor to use:

  r = ThinkifyReader.new #Windows

# Query the reader's firmware version
	puts "Reader's Firmware Version: "
	puts r.version
	puts

# You can control the LEDs on the front of the reader.
	puts
	puts "Playing with the LEDs..."
  
	0.upto(15) do |x|	
		
		puts "Set LEDs to: #{x}"
		r.led = "%01x"%(x)
		sleep(0.5)
		
	end
	
	# Turn off the LEDs.
	r.led = "0"
  
    
