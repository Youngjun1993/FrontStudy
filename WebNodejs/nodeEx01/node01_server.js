/*	=== 준비사항 ===
 *	1. nodejs.org에서 다운로드 후 설치
 *	2. 이클립스에서 help -> eclipseMarketplace -> 'node' 검색 후 Enide.p2f를 install

 */

//1. http모듈 --> http모듈을 객체로 만든 후 서버를 생성한다.
//				 	ㄴ require()함수는 모듈을 객체로 만드는 함수이다.

var http = require('http');

//2. 서버생성하기 http객체를 이용하여 생성한다.
//						 request, response
var server = http.createServer(function(request, response){
	//1.클라이언트가 서버에 접속하면 실행할 실행문을 기술하는 곳이다.
	
	//2. 서버에서 클라이언트에 데이터 또는 정보를 보내는 것은 response객체를 이용한다.
	
	//	1) Header셋팅 : html / 이미지
	//				200=정상접속이되면, html 정보 (이미지가 들어갈경우 해당 매개변수에는 이미지에 관련된 내용이 들어가야한다)
	response.writeHead(200, {'Content-Type' : 'text/html; charset=UTF-8'});
	//	2) 클라이언트에게 보낼 페이지 내용  : 내용 / 동영상
	response.write('<h1>노드js 서버에서 보낸 정보</h1>');
	response.write('<ul><li>첫번째 데이터</li>');
	response.write('<li>두번째 데이터</li></ul>');
	
	//	3) 마지막 전송데이터 표시
	response.end('<h2>마지막으로 보낸 문자</h2>')
});
//3. 클라이언트가 서버에 접속하기를 대기
//	 현재서버의 접속포트 -> 2^16 : 65500개의 객체, 
server.listen(10001, function(){
	console.log("server is runing	http://127.0.0.1:10001");
	console.log("server is runing	http://localhost:10001");
});


