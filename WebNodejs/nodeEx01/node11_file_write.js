/**
 *	파일쓰기 : fs모듈을 이용한다.
 */
var fs = require('fs');
//1. 저장할 데이터
var txt = "리브부동산이 발표한\r\n 월간KB주택시장동향 시계열 자료에 따르면\r\n";
	txt +="4월 서울의 중소형 아파트\r\n 평균 매매가격은 9억8658만원이었다.\r\n";
	txt +="2년 전에 비해 2억9237만원 뛰었다.\r\n 상승률로 보면 42.1% 상승했다.\r\n";
	
	
//1. 비동기식으로 파일 쓰기 : 스레드 구현
//		writeFile(파일명, 쓸내용, 인코딩, 콜백함수)
fs.writeFile(__dirname+"\\fileWrite_async.txt", txt, 'utf-8', (error)=>{
	if(error){//에러메세지가 있으면 true 
		//쓰기 실패시
		console.log("비동기식으로 파일쓰기 실패~~");
	}else{//null이면 false
		//쓰기 성공시
		console.log("비동기식으로 파일쓰기 완료~~");
	}
});

//2. 동기식으로 파일 쓰기 : 명령어를 바로 실행
//						콜백함수가 없어서 예외처리를 한다.
//	writeFileSync(파일명, 내용, 인코딩)
try{
	fs.writeFileSync(__dirname+"\\fileWriteSync.txt", txt, 'utf-8');
	console.log("동기식 파일쓰기 완료~!!")
}catch(e){
	console.log("동기식 파일쓰기 에러~!!");
}
