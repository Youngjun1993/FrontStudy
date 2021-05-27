
var http = require('http');
//1. 사용자 정의 모듈 사용하기
var myModule = require("./node04_custom_module_create");

var server = http.createServer(function(request, response){
	response.writeHead(200,{"Content-type":"text/html; charset=UTF-8"});
	
	//	모듈명.변수명
	response.write("<ol><li>번호 : " + myModule.num+"</li>");
	response.write("<li>아이디 : " + myModule.userid + "</li>");
	response.write("<li>주소 : " + myModule.addr + "</li>");
	
	//	모듈명.함수명()
	response.write("<li>msg() : " + myModule.msg() + "</li>");
	response.write("<li>hap(6, 7) : " + myModule.hap(6,7)+"</li>");
	response.write("<li>zerojunee(7)<br/> : " + myModule.zerojunee(7) + "</li></ol>");
	
});

server.listen(12000,function(){
	console.log("server start ....     http://127.0.0.1:12000");
});
