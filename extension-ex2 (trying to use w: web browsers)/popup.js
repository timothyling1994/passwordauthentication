
emailKey = {
  "4000 626F 6273 6D69 7468 2020 2020 2020 2020":["bob@yahoo.com"],
  "3000 E200 4669 6915 0254 0780 C3B6":["jack@gmail.com"],
  "3000 3005 FB63 AC1F 3841 EC88 0467":["michelle@yahoo.com"],
  "3000 E200 4669 6918 0086 1140 9FD6":["john@gmail.com",]
};

passwordKey = {
  "4000 626F 6273 6D69 7468 2020 2020 2020 2020":["password"],
  "3000 E200 4669 6915 0254 0780 C3B6":["jackandjill"],
  "3000 3005 FB63 AC1F 3841 EC88 0467":["michelleobama"],
  "3000 E200 4669 6918 0086 1140 9FD6":["johnnyboy"]
};


function poll(){
    $.ajax({ url: "http://localhost:2000", success: function(data){
        //Update your dashboard gauge
        console.log(data);
        for(var key in emailKey) {
          var str = data.toString();

        	if(str.trim() === key.trim())
          { 
            str2 = emailKey[key];
            console.log('hi');
            document.getElementById("email").select();
            document.getElementById("username").value = emailKey[key];

            console.log(key);
            console.log(emailKey[key]);
            setTimeout(function() {document.getElementById("email").value=str2;}, 2000);

          }
    		else
    			1+1;
        
    	}
      


    }, dataType: "html", complete: poll, timeout: 30000 });
    
};
//poll;
function autoFill() {
  //var key = poll->get data of what key, make poll return what key it is
  console.log('hi12341234');

  var newURL = "http://www.facebook.com/";

  window.open(newURL);
  poll();
  
};


function clickHandler(e) {
  setTimeout(autoFill, 1000);
};

function main() {
};

document.addEventListener('DOMContentLoaded', function() {
  document.querySelector('button').addEventListener('click', clickHandler);
  main();
});
