/**
 * 모듈 파일 생성하기
 * 
 * 모듈파일을 생성하기 위해서 필요한 모듈 -> exports(내장객체)
 * 변수 또는 함수를 생성할 수 있다.
 */
//1. 변수를 선언하는 방법
exports.num = 12345;
exports.userid = "zerojunee";
exports.addr = "서울시 마포구 백범로";

//2. 함수를 선언하는 방법
exports.msg = ()=>{
	return "노드모듈에서 전달받은 문자열..";
}

exports.hap = function(n1, n2){
	return n1 + n2;
}

exports.zerojunee = function(dan){
	var result = "";
	for(i=2;i<=9;i++){
		var data = dan*i;
		result += dan + "*" + i + "=" + data + "<br/>";
	}
	return result;
}