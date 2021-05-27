var http = require('http');

var server = http.createServer(function(request, response){
	response.writeHead(200, {"Content-Type":"text/html; charset=UTF-8"});
	response.write("<h1>폼을 이용한 Post데이터 전송</h1>");
	response.write("<form method='post' action='http://localhost:10004'>");
	response.write("이름 : <input type='text' name='username'/><br/>");
	response.write("연락처 : <input type='text' name='tel'/><br/>");
	response.write("<input type='submit' value='서버에 접속하기'/>");
	response.end("</form>");
});

server.listen(10003, function(){
	console.log("server start.....     http://localhost:10003");
});