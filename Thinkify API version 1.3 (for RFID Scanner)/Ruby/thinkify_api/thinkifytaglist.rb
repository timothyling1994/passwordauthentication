=begin rdoc
=Thinkify taglist class
==thinkifytaglist.rb	

A simple class to hold an array of taglist data elements.

Copyright 2011, Thinkify, LLC. All rights reserved.
=end

#Takes a string returned from a Taglist function call and builds an array of tags.

require 'thinkifytag'
require 'thinkifycallbacks'


class ThinkifyTagList < Array
  
  #Callback mechanism for event-driven programming
  extend Callbacks
  
  #"events"
  callback :tag_added
  callback :tag_updated
  callback :tag_programmed
    
  
  def initialize(taglist_string="")
    super()
    @last_tag = nil
    update(taglist_string)
  end
  

  #take a line from a taglist string and append to our list...
  def update_line(line)
    
    if line.include?("TAG=") 
    
      this_tag = ThinkifyTag.new(line)
    
      unless this_tag.epc==nil
    
        if self.include?(this_tag)
          #puts "I know this guy!"
          update_tag(this_tag)
        else
          #puts "He's a new guy!"
          add_tag(this_tag)
        end
    
        @last_tag = this_tag
              
      end
      
    else
      
      #TODO: This assumes only one write descriptor is being used. Will have to 
      #change if we add multiple write descriptors...
      if line.include?("XWR0=SUCCESS")
        #throw the programmed event...  
        tag_programmed @last_tag
      end
      
    end			
      
  end
  
  
  # Takes a taglist string from a reader and appends it to the array.
  def update(taglist_string)
     
    lines = taglist_string.split("\n") 
       
    lines.each do |line|    
      update_line(line)		              
    end
  
    return self
    
  end
  
  #Takes a Tag and updates the matching entry in our list with its data.
  def update_tag(t)
    self[self.index(t)].update(t)
    
    #throw the callback.
    tag_updated self[self.index(t)]
    
    return self  
  end
  
  
  # Adds a new Tag to the list.
  def add_tag(t)
    
    unless t.nil? 
      self.push(t)
      tag_added self[self.index(t)]
      return self
    else
      return nil  
    end
    
  end
  
  
  # A little regular expression scanner. Looks at the list of tags and returns a
  # new taglist containing those tag IDs that match a regular expression filter.
  def filter(filter)
    tl = ThinkifyTagList.new
    
    self.each do |ele|
      if ele.epc.to_s =~ filter 
        tl.add_tag(ele)
      end
    end
    
    return tl
  end
  
  
  # A self-modifying version of ThinkifyTagList.filter.
  # Excercise caution. Elements in the taglist array that do not match
  # the regular expression are deleted.
  def filter!(filter)
    self.delete_if { |ele| !(ele.epc =~ filter)}
    return self
  end
  
  
  # This filter looks at the rssi values of the tags in the list and returns a 
  # new list containing tags within the range of rssi_min and rssi_max.
  def rssi_filter(rssi_min, rssi_max)
    tl = ThinkifyTagList.new  
    self.each do |ele|
      if (ele.rssi > rssi_min and ele.rssi < rssi_max)
        tl.add_tag(ele)
      end
    end   
    
    return tl  
  end
  
  
  # A self-modifying version of ThinkifyTagList.rssi_filter. 
  # Excersise caution. Elements in the taglist array that do not fall within the 
  # range of RSSI values are deleted.
  def rssi_filter!(rssi_min, rssi_max)
    self.delete_if {|ele| !(ele.rssi > rssi_min and ele.rssi < rssi_max)}
    return self	
  end
    
  
  # Return the total number of reads from all the tags in the list. 
  def read_count 
    
    count = 0
    
    self.each do |tag|
      count += tag.count
    end
    
    return count
    
  end
  
end #class ThinkifyTagList
