var http = require('http')
var querystring = require('querystring');

var hapModule = require("./node05Ex_hap");

var server = http.createServer(function(request, response){
	var postData = "";
	request.on('data', function(data) {
		postData += data;
	})
	
	request.on('end', function(){
		var parseQuery = querystring.parse(postData);
		response.writeHead(200,{"Content-type":"text/html; charset=UTF-8"});
		
		response.write("<p>"+hapModule.oddHap(parseQuery.odd)+"</p>");
		response.write("<p>"+hapModule.evenHap(parseQuery.even)+"</p>");
		response.write("<p>"+hapModule.hap(parseQuery.hap)+"</p>");
	})
});

server.listen(13000,function(){
	console.log("server start .... http://localhost:13000");
})