=begin rdoc
=SAP DevEx rfid to HANA program with Thinkify API
==motion.rb	

This programs demonstrates how to use Thinkify Ruby API to read RFID sensor data and push it to SAP HANA database
=end

#append the current directory to the search path
$: << File.dirname(__FILE__)


#Add the default relative library location to the search path
#You have to download the Thinkify API from www.thinkifyit.com and put it inside your project folder
$: << File.join(File.dirname(__FILE__),"..","thinkify_api")

#require our library
require 'thinkifyreader'

#load ruby libs
require 'net/http'
require 'json'
require 'macaddr'
require 'time'
require 'eventmachine'
require 'em-http'
require 'fiber'
require 'logger'

$LOG = Logger.new('log_motion.log', 'daily') 

if RUBY_PLATFORM.include?("arm")
	require 'securerandom'
else
	require 'SecureRandom'
end

# URLs
url = ''

def async_fetch(url)
  f = Fiber.current
  http = EventMachine::HttpRequest.new(url).get :timeout => 10 
  http.callback { f.resume(http) }
  http.errback { f.resume(http) }

  return Fiber.yield
end

def async_post(url, body)
  f = Fiber.current
  request_options = {
          :redirects => 5,              # follow 3XX redirects up to depth 5
          :keepalive => true,           # enable keep-alive (don't send Connection:close header)
          # :file => 'path/to/file',      # stream data off disk through EM's fast file stream

          # :path => '/string',           # request path (will override one in host)
          # :query => '?string=a' || {},  # query string, can be passed as string or as a ruby hash
          # :body => 'string' || {},      # string, or ruby hash (which will be form encoded)
          :body => body,

          :head => {
              'authorization' => [''], # basic auth will be automatically encoded
              'content-type' => 'application/json; charset=UTF-8',   # list of request headers
              'accept' => 'application/json'                
          }
   }

  http = EventMachine::HttpRequest.new(url).post request_options
  http.callback { f.resume(http) }
  http.errback { f.resume(http) }

  return Fiber.yield
end

begin
	# Create a new reader instance and activate reading mode
	r = ThinkifyReader.new() #Linux Ubuntu
	r.reading_active=true

rescue Exception => ex
	# puts "Exception Thrown:" + ex.message
	$LOG.error "Error: #{ex.message}"
	raise "Reader is not connected"
end


begin
	while (r.tag_list)
		# Report what it found...
		r.tag_list.each do |tag|
			# puts "EPC: #{tag.epc}  Count: #{tag.count}"
			# JSON Object model
			# {
			# 	"uuid": "775254e275b44c7d99ca748461a64a73",
			# 	"reader_id": "22061633849077",
			# 	"epc_id": "4000626F62736D6974682020202020202020",
			# 	"frequency": 906750,
			# 	"slot": 33,
			# 	"i_magnitude": 15,
			# 	"q_magnitude": 14,
			# 	"iq_decoded": "Q",
			# 	"timestamp": 43,
			# 	"trunc_id": "4000626F62736D6974682020202020202020",
			# 	"signal_strength": "25.846307094"
			# }
			load = {:uuid => SecureRandom.hex ,
					:reader_id=> Mac.addr,
					:epc_id => tag.epc,
					:frequency => tag.freq.to_s,
					:count => tag.count,
					# :timestamp => "/Date("+Time.parse(tag.disc).to_i.to_s+")/",
					:timestamp => "/Date("+(Time.now.to_f*1000).to_s[0..12]+")/",
					:signal_strength => tag.rssi.to_s
				}

			EventMachine.run do
			  Fiber.new{
			    # puts "Setting up HTTP request #" + r.tag_list.count.to_s
			    # data = async_fetch('http://www.google.com/')
			    # puts "Fetched page #"+r.tag_list.count.to_s+"#{data.response_header.status}"

			    #puts "Posting DATA "+ JSON.pretty_generate(load)
			    data = async_post(url, JSON.pretty_generate(load))
			    $LOG.debug "DEBUG: #{data.response_header.status}"
			    # puts "Response: #{data.response_header.status}" 
			    # puts "Response body: #{data.response}"

			    EventMachine.stop
			  }.resume
			end
			# puts JSON.pretty_generate(load)
		end
		
		#clear screen
		# print "\e[2J"
		
		# Clear its tag list.
		r.tag_list.clear
	end
		
	rescue Exception => ex
		
	  # puts "Exception Thrown:" + ex.message
	  $LOG.error "Error: #{ex.message}"
  
ensure
	# Turn 	off reading.
	r.reading_active=false 
	
end
