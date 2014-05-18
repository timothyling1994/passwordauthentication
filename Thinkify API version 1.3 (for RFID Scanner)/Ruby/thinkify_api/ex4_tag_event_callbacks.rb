=begin rdoc
=Example Program
==ex4_tag_event_callbacks.rb	

This program shows how to open a connection to the reader, show the firmware 
version, read tags, and learn about the available callback mechanisms...
 
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

  r = ThinkifyReader.new() #Windows/Ubuntu

# Query the reader's firmware version 
	puts "Reader's Firmware Version: "
	puts r.version
	puts

# Show the inventory parameters
	puts "Inventory Parameters:"
  puts r.inventory_params
	puts

# Our API supports a callback mechanism. Simply tie a block to the 
# .tag_added or .tag_updated to perform a set of tasks whenever these events 
# occur. 

	puts "Setting up a 'tag_added' callback..."	
	puts 
	
	r.tag_list.tag_added do |tag|
		puts "A new tag was seen!  #{tag.epc}"
	end

	num_read_events = 0
	
	puts "Setting up a 'tag_updated' callback..."
	puts
	
	r.tag_list.tag_updated do |tag|
		num_read_events +=1  #keep track of a read-event counter
	end  
  
	begin
    while true do 
    # Turn the reader on (start reading tags using default parameters)
    puts "Reading Tags:"
    puts 	  
    
    r.reading_active=true
  
    # Read for a few seconds...
    sleep(2)

    # The reader will put the tags it finds into its tag_list... An array of tags.
    puts "Total Tags: #{r.tag_list.length}"
    puts "Total Read Events: #{num_read_events}" #from callback above

    # Report
    r.tag_list.each do |tag|
	    puts "EPC: #{tag.epc}  Count: #{tag.count}"

    end
    end

    # Clear its tag list.
    r.tag_list.clear
		   
	rescue Exception
		
	  puts "Exception Thrown: #{$!}"
	  
	ensure
	
		# Turn off reading.
		r.reading_active=false 
		
	end

