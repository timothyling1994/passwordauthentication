=begin rdoc
=Example Program
==test_thinkifyreader.rb	

This program shows how to open a connection to the reader, show the firmware 
version, read tags, and play with the LEDs...
 
Copyright 2011, Thinkify LLC. All rights reserved.
=end

#append the current directory to the search path
$: << File.dirname(__FILE__)


#Add the default relative library location to the search path
$: << File.join(File.dirname(__FILE__),"..","thinkify_api")

#require our library
require 'thinkifyreader'

# Create a reader to work with. 
# On windows you can just call .new and the class will scan for the first reader it can find (upto com20)
# Under linux, you must specify the /dev/ttyXX file descriptor to use:

  #r = ThinkifyReader.new('/dev/ttyACM0') #Linux Ubuntu

  r = ThinkifyReader.new #Windows

# Query the reader's firmware version
  puts 
	puts "Reader's Firmware Version: "
	puts r.version

# Show the inventory parameters
	puts
	puts "Inventory Parameters:"
  puts r.inventory_params


# Our API supports a callback mechanism. Simply tie a block to the .tag_added or .tag_updated to perform a set of tasks whenever these events occur. 
	puts 
	puts "Setting up a 'tag_added' callback..."
	r.tag_list.tag_added do |tag|
			#puts "A new tag was seen!  #{tag.epc}"
	end


# Turn the reader on (start reading tags using default parameters)
  puts  
  puts "Reading Tags:"
  r.reading_active=true
   
	begin
	  
			# Read for a few seconds...
			sleep(3)
			
			# The reader will put the tags it finds into its tag_list... An array of tags.
			puts "Total Tags: #{r.tag_list.length}"
			
			# Report what it found...
			r.tag_list.each do |tag|
				puts "EPC: #{tag.epc}  Count: #{tag.count}"
			end
			
			# Clear its tag list.
			r.tag_list.clear
		 
	rescue Exception
		
	  puts "Exception Thrown."
	  
	ensure
	
		# Turn off reading.
		r.reading_active=false 
		
	end

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
  
    
