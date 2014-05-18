=begin rdoc
=Using Sinatra with a Thinkify Reader
==readerserver.rb	

This program shows how to use a Thinkify RFID reader with the Sinatra web framework to build a little web-based data acquisition and control program. 
 
Copyright 2012, Thinkify LLC. All rights reserved.
=end


#Add the default relative library location to the search path
$:.unshift File.join(File.dirname(__FILE__),"..","thinkify_api")

  require 'rubygems'
  require 'sinatra'
  require 'haml'
  require 'thinkifyreader'

  
  # Create a reader to work with 
  #com = '/dev/ttyACM0' #I use /dev/ttyACM0 under Ubuntu... for windows you can just call .new() without parameters and the reader will be found on the COM port. 
 #com = 'com6'  
  r = ThinkifyReader.new() #Use the appropriate port for your os
  
  r.reading_active=false
  
  #main page for the reader.
  get '/' do
    @time = Time.now
    @version = r.version
    @reading = r.reading_active
    r.raise_errors = false
    haml :index
  end
  
  #show the current tag list.
  get '/taglist' do
    @reading_active = r.reading_active   
    #copy anything that the reader has seen since we last asked. (.filter makes
    #a new taglist and copies in the result.)
    @tag_list = r.tag_list.filter(/.*/).sort   
    #reset the reader's list.
    r.tag_list.clear  
    haml :taglist 
  end
  
 # Return the current taglist without any HTML template. Just return a string that an app might use to parse the response. 
  get '/rawtaglist' do
    #copy anything that the reader has seen since we last asked. (.filter makes a new taglist and copies in the result.)
    @tag_list = r.tag_list.filter(/.*/).sort    
    #reset the reader's list.
    r.tag_list.clear   
    reply =''   
    @tag_list.each do |tag|
      reply << tag.epc << "\r\n"
    end   
    reply
  end
  
  get '/program_epc' do
    haml :program_epc
  end
  
  post '/program_epc' do 
    p params
    @increment_epc = params["increment_epc"]
    @target_epc = params["target_epc"].upcase
    @reader_response = r.program_epc(@target_epc).to_s  
    if @reader_response == "true" and @increment_epc == "on" 
      @target_epc = increment_epc(@target_epc)
    end  
    haml :program_epc
  end
  
  get '/execute' do
    haml :execute
  end
  
  post '/execute' do
    command = (params["reader_command"].downcase) #
    @reader_response = r.execute(command).gsub("\r","<br>")
    haml :execute
  end
  
  get '/reading' do 
    @reading_active = r.reading_active
    haml :reading
  end
  
  post '/reading' do
    @reading_active = (params["reading_active"].downcase =='true') #
    r.reading_active = (@reading_active)
    haml :reading
  end
  

