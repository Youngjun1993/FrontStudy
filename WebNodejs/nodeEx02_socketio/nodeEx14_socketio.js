/**
 * http://127.0.0.1:14002/chatForm
 */
var http = require('http');
var fs = require('fs');

var server = http.createServer((request, response)=>{
	var pathname = request.url;
	if(pathname=="/chatForm"){
		fs.readFile(__dirname+"\\chatingForm1.html","utf-8",(error, data)=>{
			if(error){
				response.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
				response.end("chatForm 읽기 실패");
			}else{
				response.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
				response.end(data);
			}
		});
	}else{
		response.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
		response.end("404 Error Page");
	}
});

server.listen(14002, function(){
	console.log("server start~!!! http://127.0.0.1:14002");
});

//================= socket.io =====================
var socketio = require('socket.io')

// 1) 소켓서버를 생성 및 실행
var io = socketio.listen(server);

// 2) 클라이언트가 서버에 접속(connection이벤트)하면 접속을 받을 이벤트를 생성한다.
//			 이벤트 종류
io.sockets.on('connection', function(socket){ //매개변수가 접속자(html)의 script변수 socket과 연결된다.
	console.log('Client가 접속하였습니다!!');
	
	// 클라이언트와 통신할 이벤트를 생성
	socket.on('hello',function(data){
		console.log("Server가 받은 메세지 : ", data);
		
		// [1] 클라이언트에게 서버가 문자 보내기 이벤트 발생
		socket.emit('echo', data+'(클라이언트야 받았니?)');
	});
});
