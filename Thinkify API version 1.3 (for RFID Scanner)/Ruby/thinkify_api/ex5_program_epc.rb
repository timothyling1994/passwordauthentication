=begin rdoc
=Example Program
==ex5_program_epc.rb	

This program shows how to open a connection to the reader, show the firmware 
version, and program an EPC.
 
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

  r = ThinkifyReader.new() 

# Query the reader's firmware version
  puts 
	puts "Reader's Firmware Version: "
	puts r.version
	puts 
	
  begin
	
	  puts "Taglist before programming..."
  	p r.acquire
  	puts
  	
  	epc = "111122223333444455556666"
  	
  	puts "Programming... #{epc}"
    puts r.program_epc(epc)
    puts
    
    puts "Taglist after programming"
    p r.acquire
    
	rescue Exception
		
	  puts "Exception Thrown. #{$!}"
	  
	ensure
		
	end

    
