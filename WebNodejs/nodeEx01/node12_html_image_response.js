/**
 * 	html문서를 파일읽기를 하여 웹페이지 쓰기
 */

var http = require('http');
var fs = require('fs');
var mime = require('Mime');

var server = http.createServer((request,response)=>{
	console.log("request.url====>"+request.url);
	var pathname = request.url;
	if(pathname=='/hello'){
		//비동기식으로 node12_hello.html을 파일읽기하여 response에 쓰기 한다.
		fs.readFile(__dirname+"\\node12_hello.html", "utf-8", (err, data)=>{
			if(err){
				console.log("html읽기 실패..");
			}else{
				response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
				response.write(data);
				response.end();
			}
		});
		//					 /images/1.jpg
	}else if(pathname.indexOf("/images")==0){ // /images/이미지파일명으로 접속했을때
		
		//Mime --> getType(경로와 파일명),	mime --> lookup(경로와 파일명)
		var imgPath = pathname.substring(1);//	/images/1.jpg
		var mimeType = mime.getType(imgPath); 
		console.log(imgPath + "===>" + mimeType);
		fs.readFile("../"+imgPath,(error, imgData)=>{
			if(error){
				console.log(imgPath+"읽기 실패...");
			}else{
				response.writeHead(200,{"Content-Type":mimeType});
				response.end(imgData);
			}
		});
		
	}else if(pathname=='/nextpage'){
		fs.readFile(__dirname+"\\node12_nextpage.html","utf-8", (err, data)=>{
			if(err){
				console.log("nextpage 읽기 실패");
			}else{
				response.writeHead(200, {"Content-type":"text/html; charset=utf-8"});
				response.write(data);
				response.end();
			}
		})
	}else{
		response.writeHead(200,{"Context-Type":"text/html; charset=utf-8"});
		response.end("<h1>404 Error Page....</h1>");
	}
});
server.listen(13003, ()=>{
	console.log("server start....   http://127.0.0.1:13003");
	
});