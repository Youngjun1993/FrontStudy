/**
 * http://127.0.0.1:14003/chat
 */
var http = require('http');
var fs = require('fs');
var socketio = require('socket.io');

var server = http.createServer((request, response)=>{
	var path = request.url;
	if(path == "/chatBroad"){
		fs.readFile(__dirname + "\\chatingForm1.html", 'utf-8', function(error, data){
			response.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
			if(error){
				response.end("파일읽기 에러~~");
			}else{
				response.end(data);
			}
		});
	}else{
		response.writeHead(200, {"Content-type":"text/html; charset=utf-8"});
		response.end("404 page error");
	}
});

server.listen(14004, ()=>{
	console.log("server start ....         http://127.0.0.1:14004/chatBroad")
});

// ***********************************
var io = socketio.listen(server);

//연결 이벤트
io.sockets.on('connection', function(socket){
	console.log("클라이언트가 접속함...");
	
	//클라이언트가 보낸 문자를 받을 이벤트
	socket.on('hello', function(data){
		console.log("서버가 받은 문자 -->" + data);
		// [3] 나를 제외한 모든 접속자에게 서버가 데이터 보내기
		socket.broadcast.emit('echo', 'broadcast-->'+data);
	});
});
