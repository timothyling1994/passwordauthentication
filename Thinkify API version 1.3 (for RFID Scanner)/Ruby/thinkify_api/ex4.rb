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
require 'socket'      # Sockets are in standard library


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
    #client.puts tag.epc
	end

	num_read_events = 0
	
	puts "Setting up a 'tag_updated' callback..."
	puts
	
	r.tag_list.tag_updated do |tag|
		num_read_events +=1  #keep track of a read-event counter
	end  
  

  hostname = 'localhost'
  port = 3000

  #s = TCPSocket.open(hostname, port)

  #while line = s.gets   # Read lines from the socket
  #  puts line.chop      # And print with platform line terminator
  #end
  #s.close               # Close the socket when done
	#require 'socket'               # Get sockets from stdlib

  server = TCPServer.new 2000  # Socket to listen on port 2000
  loop {                         # Servers run forever
    puts "Ready for client to connect!"
    client = server.accept       # Wait for a client to connect
    puts "Client connected. Waiting for tag.."
    #client.puts "Scanning for tags.."
    r.reading_active=true
    #sleep(2)
   # while(!r.tag_list)do
     # sleep(2)
      #if r.tag_list.tag_added
    #end
    tagcount = 0
    tag = nil
    while true
    while(r.tag_list) do
      #sleep(2)
    r.tag_list.each do |tag|
      if tag.count > tagcount
        tagcount = tag.count
        tag = tag.epc
      end
      #client.puts tag.epc
      client.puts tag
      r.tag_list.clear
      abort 
      
    end
      #client.puts tag
      break
    end
    end
    r.reading_active = false
    client.close
    #client.puts(Time.now.ctime)  # Send the time to the client
    #puts "Client connected. Waiting for tag to be scanned.."
    #client.puts "Closing the connection. Bye!"
    #client.close                 # Disconnect from the client
  }
  
