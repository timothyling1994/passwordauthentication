=begin rdoc
=Example Program
==rssi_filtering.rb	

This program shows how to open a connection to the reader, show the firmware 
version, read tags, and filter the tag list using the rssi values...
 
Copyright 2011, Thinkify LLC. All rights reserved.
=end

#append the current directory to the search path
$: << File.dirname(__FILE__)

#Add the default relative library location to the search path
$: << File.join(File.dirname(__FILE__),"..","thinkify_api")

#require our library
require 'thinkifyreader'


# A helper function to dump a tag_list to the screen. (Sorts the results before 
# displaying.)
def show_tag_list(t) 
  puts "Number of Tags: #{t.length}"
  t.sort!
  t.each do |tag|
	  puts "EPC: #{tag.epc}  Count: #{tag.count} RSSI: #{tag.rssi}"
  end
end


# Create a reader to work with. 
# On windows / ubuntu linux you can just call .new and the class will scan for 
# the first reader it can find (upto com20 on windows.) Under other linux, 
# flavors you must specify the /dev/ttyXX file descriptor to use:

  r = ThinkifyReader.new('') #Windows/ubuntu

# Query the reader's firmware version
  puts 
	puts "Reader's Firmware Version: "
	puts r.version

# Show the inventory parameters
	puts
	puts "Inventory Parameters:"
  puts r.inventory_params
   
	begin

    # Turn the reader on (start reading tags using default parameters)
    puts  
    puts "Reading Tags..."
    r.reading_active=true
  
		# Read for a few seconds...
		sleep(3)
		
		# The reader will put the tags it finds into its tag_list... 
		# (An array of tags.)
		
		# Report what it found...
		show_tag_list(r.tag_list)
		
		# Let's filter this list to only show the strongest tags...
		rssi_min = 22
		rssi_max = 100
		
		puts
		puts "Running RSSI filter..."
		puts "Filter Min: #{rssi_min}, Filter Max: #{rssi_max}"
		
		filtered_tag_list = r.tag_list.rssi_filter(rssi_min, rssi_max)
		
		# Show the filtered list
		show_tag_list(filtered_tag_list)
		 
	rescue Exception
		
	  puts "Exception Thrown. #{$!}"
	  
	ensure
	
		# Turn off reading.
		r.reading_active=false 
		
	end

  
    
