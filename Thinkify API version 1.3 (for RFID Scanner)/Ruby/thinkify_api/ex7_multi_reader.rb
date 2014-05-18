=begin rdoc
=Example Program
==ex7_multi_reader.rb	

This more advanced example shows how to interact with multiple readers connected 
to your computer and aggregate data from them. 
 
Copyright 2011, Thinkify LLC. All rights reserved.
=end

#append the current directory to the search path
$: << File.dirname(__FILE__)


#Add the default relative library location to the search path
$: << File.join(File.dirname(__FILE__),"..","thinkify_api")

#require our library
require 'thinkifyreader'
require 'thinkifytaglist'


# Create a reader to work with. 
# On windows you can just call .new and the class will scan for the first reader 
# -- it can find (upto com20)
# Under linux, you must specify the /dev/ttyXX file descriptor to use:
  
  Create your readers on specific com ports
  r1 = ThinkifyReader.new(1) # 
  r2 = ThinkifyReader.new(2) # 
  
  readers = [r1, r2]

  #reset the readers so they have default parameters to start with...
  readers.each do |r|
    p r.execute("brs")
  end
  
	tag_list = ThinkifyTagList.new #one tag list we'll share between the readers.
  
	puts "Setting up a 'tag_added' callback..."

	read_counter = 0

	report = []
  
	r1.tag_list.tag_added do |tag|
		unless tag_list.include?(tag)
			tag_list.add_tag(tag)
			read_counter +=1
			t2 = Time.now
			report << t2
			#puts read_counter 
		end
	end
  
  r2.tag_list.tag_added do |tag|
		unless tag_list.include?(tag)
      tag_list.add_tag(tag)
      read_counter +=1
      t2=Time.now
      report << t2 
      #puts read_counter 
    end
	end

	puts "Setting Up Reader(s)..."
  
	readers.each do |r|
    r.clear_tag_list
    
    #There's two ways to interact with the reader. 'execute' command strings...
    
      #6.25 M2 256
      r.execute("p022")
      #read out of A state
      r.execute("it0")
      #reset  masks
      r.execute("mr")
      #make sure write descriptor is off
      r.execute("xwr")    
	  
    #...Or you can make use of the properties generated dynamically from the 
    #readermethods.dat file in the thinkify_api directory.
	  #set mask to limit stray reads
      r.epc_mask("aaaabbbb")
  
      #large population 
  	  r.q = 7
  	  r.innerloop = 3
  	  r.selectloop = 2
  	  r.atten =6
	  
	  print r.execute("i")
	end
	
  p r1.reading_active = true
  p r2.reading_active = true
			
# Turn the reader on (start reading tags using default parameters)
  puts  
  puts "Reading Tags:"
  t1= Time.now
  
	begin
	   
	   while (1)
			# Read until we breakout with ctl-c...
			last_count = tag_list.length
			sleep(0.05)
			if tag_list.length != last_count
  			puts "#{tag_list.length},  #{tag_list.read_count}"
  		end
	   end
		 
	rescue Exception
		
	   puts "Exception Thrown."
	  
	ensure

		# Turn off reading.
		readers.each do |r|
			r.reading_active=false 
		end
    
		# The reader will put the tags it finds into its tag_list... An array of tags.
		puts "Tag List:"			

		# Report what it found...
		i=0
		tag_list.each do |tag|
			#puts "EPC: #{tag.epc}  Count: #{tag.count}"
			puts "#{report[i]-report[0]},#{i+1},#{tag.epc},#{tag.count},#{tag.rssi}"
			i+=1
		end
		
		# The reader will put the tags it finds into its tag_list... An array of tags.
		puts "Total Tags: #{tag_list.length}  Total Time: #{Time.now - t1}  Total Reads: #{tag_list.read_count}"			
			
		# Clear its tag list.
		tag_list.clear
		
	end
