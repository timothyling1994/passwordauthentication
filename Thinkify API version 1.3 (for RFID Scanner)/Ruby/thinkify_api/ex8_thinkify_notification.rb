=begin rdoc
=A little server application that hooks up to a reader, starts reading and then 
populates a network listener with reader/ tagevent data. 
==ex_8thinkify_notification.rb	

Copyright 2012, Thinkify LLC. All rights reserved.
=end

#append the current directory to the search path
$: << File.dirname(__FILE__)


#Add the default relative library location to the search path
$: << File.join(File.dirname(__FILE__),"../","thinkify_api")

#require our libraries
require 'thinkifyreader'
require 'thinkifyconfig'

require 'macaddr'
require 'socket'


class NotifierApp
  
  #****************************************************************************
  #Send a TCP message to a server running at an IP address on a particular port.
  #****************************************************************************
  def notify (msg)
    #grab parameters out of a configuration file
    
    ipaddress = @config[:tcp_listener_address]
    port = @config[:tcp_listener_port]
    
    begin
      sock = TCPSocket.new(ipaddress,port)
      sock.write msg+"\0"
      sleep 1
      sock.close
    rescue 
      puts $!
    end
  end
  

  #****************************************************************************
  #Grab our local IP Address.
  #****************************************************************************
  def local_ip
    # turn off reverse DNS resolution temporarily
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  
       
    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
      Socket.do_not_reverse_lookup = orig
  end  
  
  
  #****************************************************************************
  #Construct a notification message in an approximation of Alien Text format
  #****************************************************************************
  def build_text_notification_message(reason, taglist)
    term = "\r\n"
    strNotification = ""
    strNotification += "#Thinkify RFID Reader Auto Notification Message" + term 
    strNotification += "#Readername: #{@config[:readername]}" + term 
    strNotification += "#ReaderType: Thinkify TR-200 Desktop RFID Reader (Class 1 / 915MHz)" + term 
    strNotification += "#IPAddress: #{local_ip}" + term 
    strNotification += "#CommandPort: 23" + term 
    strNotification += "#MACAddress: #{Mac.addr.gsub("-",":")}" + term 
    strNotification += "#Time: #{DateTime.now.strftime("%Y/%m/%d %H:%M:%S.%L")}" + term 
    strNotification += "#Reason: #{reason}" + term 
    
    taglist.each do |tag|   
      
      #We're only going to put tags in our notification that we haven't reaported before.
      unless tag.reported == true
        
        strNotification += "Tag:#{tag.epc}, Disc:#{tag.disc.strftime("%Y/%m/%d %H:%M:%S.%L")}, Last:#{tag.last.strftime("%Y/%m/%d %H:%M:%S.%L")}, Count:#{tag.count}, Ant:#{tag.ant}" + term       
        
        tag.reported = true 
        
      end     
      
    end
    
    strNotification += "#End of Notification Message" + term  
    
    return strNotification
  end
  
  
  #****************************************************************************
  #Create a reader grab our configuraiton and get ready to run
  #****************************************************************************
  def initialize 
    # The PC this code is running on provides the networking / mac address we use
    #in the DB. Let's make a "reader" in the DB using these paramters. 
     
    #We can specify parameters in a config file for easier deployment. 
    @config = ThinkifyConfig.new("config.dat")
    
    p @config
    @tag_added = false
    
    # Create a thinkify reader to work with. 
    # On windows you can just call .new and the class will scan for the first reader 
    # it can find (upto com20)
    @r = ThinkifyReader.new
    
    # Our API supports a callback mechanism. Simply tie a block to the .tag_added or
    # .tag_updated or .tag_removed to perform a set of tasks whenever these events 
    # occur.  
    #puts "setting up tag added callback"
    # When we first observe a tag, add it to the db if it doesn't exist and then add
    # an 'added' event.
    @r.tag_list.tag_added do |tag|
      puts "A new tag was seen!  #{tag.epc}"
      @tag_added = true #We just set a flag...
    end
    
    #puts "Setting up a 'tag_removed' callback..."
    @r.tag_list.tag_removed do |tag|
      puts "Deleting stale tag: #{tag.epc}"
    end
    
  end
  
  
  #****************************************************************************
  #Do one cycle to do notification.
  #****************************************************************************
  def run_cycle
    
      # Read for a few seconds...
        sleep(3)
        
        # The reader will put the tags it finds into its tag_list... An array of tags.
        puts "Total Tags: #{@r.tag_list.length}"
        
        if @tag_added
          #We've got at least one new tag on the list. -- Report the new Tags...
          puts 
          msg =  build_text_notification_message("TAG ADDED", @r.tag_list)
          print msg
          puts
          @tag_added = false  
          notify(msg)
        end
        
        #Clean out Stale tags.
        @r.tag_list.delete_stale_tags!()
    
  end
  
  
  
  #****************************************************************************
  #Start Reading and Notifying on Add.
  #****************************************************************************
  def run 
    
    puts  
    puts "Reading Tags:"
    @r.reading_active=true
    @r.tag_list.tag_lifetime = @config[:tag_lifetime].to_i
    
    puts "lifetime"
    p @r.tag_list.tag_lifetime
    
    begin
    
      if ENV.has_key?('OCRA_EXECUTABLE') == true #will only run on the OCRA compiled build
    
        while(1)
          
          run_cycle
          
        end
        
      else
        run_cycle
      end
      
  
    rescue Exception
      
      puts "Exception Thrown."
      p $!
      
    ensure
    
      # Turn off reading.
      @r.reading_active=false 
      
    end
  
  end
  
end


#***********************************************************
# Make an instance and Go!

rn = NotifierApp.new()
rn.run
