//node03_form 에서 submit 발생시 넘어오는 post방식의 데이터 처리
var http = require('http');
var querystring = require('querystring');
var server = http.createServer(function(request,response){
	
	//1. post방식의 데이터가 서버로 전송되면 data이벤트가 발생한다.
	var postData = "";
	request.on('data', function(data){
		postData += data;
	});
	
	//2. data이벤트가 끝나면 자동으로 end이벤트가 발생한다.
	request.on('end', function(){
		// post로 전송된 postData의 값을 json으로 변환하여 사용한다.
		var parseQuery = querystring.parse(postData);
		
		response.writeHead(200,{"Content-Type":"text/html; charset=UTF-8"});
		response.write("이름:"+parseQuery.username+"<br/>");
		response.end("연락처:"+parseQuery.tel+"<br/>");
	});
	
});
server.listen(10004, function(){
	console.log('server start .... http://localhost:10004');
});