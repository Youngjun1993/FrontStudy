/**
 *	웹브라우저에 이미지 표시
 */

var http = require('http');
var fs = require('fs');

var server = http.createServer((request, response)=>{
	//이미지 파일을 읽기를 하여 response 쓰기
	//					파일명				콜백함수
	fs.readFile("../images/1.jpg", function(error, data){
		response.writeHead(200, {"Content-Type":"image/jpg"});
		response.write(data);
		response.end();
		console.log("이미지 전송완료");
	});
});

server.listen(13001, ()=>{
	console.log("server start.....    http://127.0.0.1:13001");
});