/**
 * 동영상 스트리밍 처리하기
 */
var http = require('http');
var fs = require('fs');
var mime = require('Mime');

var server = http.createServer((request, response)=>{
	var mapping = request.url; // /html로 접속시 실행
	
	if(mapping=="/html"){//html페이지 요청이 들어왔을때
		fs.readFile(__dirname+'\\node13_video_image.html','utf-8',(error, data)=>{
			if(error){
				//읽기실패
				response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
				response.end("html문서 읽기 실패!!");
			}else{
				//읽기성공
				response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
				response.end(data);
			}
		});
		
	}else if(mapping.indexOf("/images")==0){//이미지 접속일 경우 /images/ffjff.png
		//마임 알아내기
		var imgMime = mime.getType(mapping.substring(1)); //image/png
		
		fs.readFile("../"+mapping.substring(1), function(error, imgData){
			if(!error){
				response.writeHead(200,{"Content-Type":imgMime});
				response.end(imgData);
			}
		});
	}else if(mapping.indexOf("/video")==0){//동영상 파일인 경우
		//1.스트리밍 처리
		//  1) Stream객체 생성
		var stream = fs.createReadStream(".."+mapping); // 한번에 65536바이트를 읽는다.
		//  2) 파일에서 데이터를 읽었을 때 호출되는 이벤트
		var cnt = 1;
		stream.on('data', function(videoData){
			console.log(cnt++, '-->', videoData.length);
			response.write(videoData);
		});
		
		//  3) 파일에서 마지막으로 데이터를 읽었을 때 호출되는 이벤트
		stream.on('end', function(){
			console.log('end streaming~!');
			response.end();
		});
		
		//  4) 파일을 읽는 과정에서 에러가 발생하면 호출되는 이벤트
		stream.on('error', function(error){
			console.log('Error!!');
			response.end();
		});
		
	}else{//url이 잘못접속 되었을 때
		response.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
		response.end("404 error Page!!");
	}
	
});

server.listen(14001, ()=>{
	console.log("server start....    http://127.0.0.1:14001/html");
});