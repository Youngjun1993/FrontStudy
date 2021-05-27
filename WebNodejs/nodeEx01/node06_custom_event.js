/**
 * 이벤트를 발생시키는 객체는 events모듈을 이용하여 생성할 수 있다.
 * 
 */
//1. 이벤트 모듈 만들기
var events = require("events");

//2. 이벤트를 사용하기 위해서는 모듈을 담은 객체 (EventEmitter)를 초기화하여야한다.
var customEvent = new events.EventEmitter();

//3. 이벤트가 발생하면 실행할 실행문을 작성한다.
//			  이벤트종류
//customEvent.on('call',function(){ //아래와 같다
customEvent.addListener('call', function(){
	console.log('call 이벤트가 발생함....');
});

//--------------------------------------------
var http = require('http')

var server = http.createServer(function(request, response){
	//강제로 call 이벤트 발생시키기 (emit함수)
	customEvent.emit('call');
	
	response.writeHead(200,{"Content-type":"text/html; charset=UTF-8"});
	response.end("EventEmitter객체 테스트 중.....");
});
server.listen(12005, function(){
	console.log("server start....... http://localhost:12005");
});