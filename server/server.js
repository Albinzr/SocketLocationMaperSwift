var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var users = [];

app.get('/', function(req, res){
  res.json({"location":"only on socket :p "});
});


http.listen(3000, function(){
  console.log('Listening on *:3000');
});


io.on('connection', function(socket){
	console.log("connected...Bro...")

   	socket.on('send', function(data){ //recive from client

   		console.log(data);

   		io.emit("new",{location:data}); //send to client

			console.log("data send");

   		})

 });



 



