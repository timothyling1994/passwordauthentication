11/9-11/10 Codeday SV


RFID User Auth

Ruby server backend, javascript client side.
Thinkify RFID sensor used to return RFID-tag
Ruby
-initialized server to wait for client connection to server, before executing any tasks
-IDLE until RFID-tag in range, return closest RFID-tag.
-Folder “thinkify API” for API usage. 
-file is /thinkify/Ruby/thinkify_api/ex4.rb

Javascript (Chrome extensions)
-POST requests made with query using “long polling”(concept of waiting for a response from the server (ruby in this case) within a certain timeout interval)
-Stores values of RFID-tags along with corresponding usernames/passwords
-Once RFID data returned, locate username/password corresponding to ID and submit data to HTML tags in browser
-folder ex1 for direct input into a sample HTML page (success)
-folder ex2 for input into any webpage (tested w/ Facebook, failed, maybe because of OAuth)







WON “Most useful”. GG.
