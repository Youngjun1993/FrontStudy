/**
 * http://127.0.0.1:15002/chat
 */

var http = require('http');
var fs = require('fs');

var server = http.createServer((req, res)=>{
   if(req.url=="/chat") {
      fs.readFile(__dirname+"\\chatingRoom.html", 'utf-8', (error, data)=>{
         if(error) {
            res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
            res.write("<h1>파일 읽던 중 실패했는디!</h1>");
            res.end(error);
         } else {
            res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
            res.end(data);
         }
      });
   } else {
      res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
      res.end("<h1>url에 해당없는걸 쓴거 같은디!!</h1>");
   }
});

server.listen(15002, function(){
   console.log("server Start! http://127.0.0.1:15002/chat");
});

// socket 부분 시작

var socketio = require('socket.io');

var io = socketio.listen(server);

// connection Event
io.sockets.on('connection', (socket)=>{
   console.log('클라이언트 접속');
   
   //방만들기(join)
   var roomName;
   socket.on('join', (data)=>{//data:방이름이 서버로 온다.
      roomName = data;
      socket.join(roomName);
      console.log(roomName+ " 이 만들어 졌습니다.");
   });
   
   socket.on('message', (msg)=>{
     //같은방에있는 접속자에게 받은 메세지 보내기
     io.sockets.in(roomName).emit('response',roomName+"-->"+ msg);
   });
});