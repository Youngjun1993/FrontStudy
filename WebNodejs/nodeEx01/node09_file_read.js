/**
 *  파일입력, 출력 : fs(FileSystem)
 */

//1. 모듈객체 : file입력
var fs = require('fs');

//	1) 비동기식으로 파일의 내용을 읽어오는 방법 : 읽기, 쓰기를 바로 실행하지 않고 스레드로 처리한다.
//		fs.readFile(파일명,한글인코딩,콜백함수);				  에러정보, 파일에서 읽은 내용
fs.readFile(__dirname+"\\node01_server.js",'utf-8',function(error, data){
	//파일을 모두 읽은 후 실행되는 곳
	console.log("비동기식 파일 입력결과-->\n" + data);
});

//	2) 동기식으로 파일의 내용을 읽어 오는 방법 : 읽기, 쓰기가 명령어를 만나면 바로 처리된다.
//	fs.readFileSync(파일명, 한글인코딩)
var dataSync = fs.readFileSync(__dirname+"\\node02_request_get.js","utf-8");
console.log("2) 동기식 파일 입력 결과-->\n" + dataSync);