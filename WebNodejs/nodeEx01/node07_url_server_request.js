var http = require('http');
var url = require('url');

var server = http.createServer(function(request, response){
	console.log("request.url" + request.url);
	//var parsingUrl = url.parse(request.url);
	//console.log("parsingUrl.url " + parsingUrl);
	
	//url 주소 뒤에 매핑주소 선언시 해당영역 실행
	if(request.url=="/name"){
		response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
		response.end("이름은 홍길동입니다.");
	}else if(request.url =="/address"){
		response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
		response.end("주소는 서울시 마포구 백범로 입니다.");
	}else if(request.url =="/tel"){
		response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
		response.end("연락처는 010-1234-1234입니다.");
	}else{
		//404 page
		response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
		response.end("<h1>404 Page Not Found....</h1>");
	}
});

server.listen(12007, function(){
	console.log("server start...        http://127.0.0.1:12007");
});