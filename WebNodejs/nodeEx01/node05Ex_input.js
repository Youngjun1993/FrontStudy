var http = require('http')

var server = http.createServer(function(request, response){
	response.writeHead(200, {"Content-Type":"text/html; charset=UTF-8"});
	
	response.write("<form method='post' action='http://localhost:13000'>");
	response.write("짝수합 : <input type='text' name='odd'/><br/>");
	response.write("홀수합 : <input type='text' name='even'/><br/>");
	response.write("합 : <input type='text' name='hap'/><br/>");
	response.write("<input type='submit' value='서버에 접속하기'/>");
	response.end("</form>");
});

server.listen(11000,function(){
	console.log("server start .... http://localhost:11000");
})