/**
 * http://127.0.0.1:15005/home
 */
/* package.json에 ejs추가 */

var http = require('http');
var fs = require('fs');
var mime = require('Mime');

var express = require('express');
var requestip = require('request-ip');
var ejs = require('ejs');

//================JDBC================================
var oracledb = require('oracledb');

oracledb.autoCommit = true;//자동커밋이 되도록 설정한다.
//db연결정보 설정

var conn; //db연결정보를 보관할 전역변수
oracledb.getConnection({
   user : 'c##scott',
   password : 'tiger',
   connectString : 'localhost:1521/xe'},
   function(error, con){//연결이 완료되거나 에러가 발생하면 호출되는 콜백함수
         if(error){//연결실패시
            console.log("DB연결실패하였습니다.")
         }else{//연결 성공시
            conn = con;
         }
      }
   );
//========================================

//express 객체 생성
var app = express();
var server = http.createServer(app);

//============post 방식 전송시 데이터 pasrser 설정=====================================
var bodyParser = require('body-parser');
app.use(express.static(__dirname)); //express에 기본 디렉토리 설정
app.use(bodyParser.urlencoded({extended:true}));//한글인코딩 세팅

//서버에 접속시 get방식으로 접속하면 get(), post방식은 post() 메소드를 호출한다.
app.get('/home',(req,res)=>{
   fs.readFile(__dirname+"\\home.ejs","utf-8",(error,data)=>{
      if(error){
         res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
         res.end("File Read Error ~!!");
      }else{
    	 //로그인 여부 확인
    	 var val = session.user; //아이디, 이름, logStatus
    	 if(val){//로그인이 된 경우
    		 res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
    		 res.end(ejs.render(data, {user:val, logStatus:'Y'}));
    	 }else{//로그인 안된경우
    		 res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
             res.end(ejs.render(data, {logStatus:'N'}));
    	 }
      }
   });
});

//이미지 처리
app.get('/images/*', function(req, res){
   var path = req.url; // img/001.png
   var imgMime = mime.getType(path.substring(1));
   
   fs.readFile("../"+path, function(error, data){
      if(!error){
         res.writeHead(200, {"Content-Type":imgMime});
         res.end(data);
      }
   });
});

//게시판 목록
app.get('/list', (req,res)=>{
   //데이터베이스 조회
   var sql="select no, subject, userid, hit, to_char(writedate, 'MM-DD HH:MI') writedate from board order by no desc";
   
   //쿼리문 실행
   conn.execute(sql, function(error, result){
      if(error){
         //레코드 선택에러
         res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
         res.end("<script>location.href='/home';</script>");
      }else{
         //레코드 선택시
         console.log(result);
         var val = session.user; //아이디, 이름, logStatus
         fs.readFile('boardList.ejs', 'utf-8', function(error, data){
            if(error){
               res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
               res.writeHead("<script>location.href='/home';</script>");
            }else{
               //총 레코드 수
               var totalRecord = result.rows.length;
               console.log(totalRecord);
               
               res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
               //ejs페이지에서 사용할 데이터는 ejs페이지에 render하여 보낸다.
               
               if(session.user != null){ //로그인
//                 ejs소스코드
                   res.end(ejs.render(data, {
                      results : result,
                      totalrecord : totalRecord,
                      parsing:{
                         firstPage : 6,
                         lastPage : 10,
                         totalPage : 9,
                         currentPage: 7
                      },user:val, 
                      logStatus:'Y'
                   }));
               }else{//로그인 안함
            	   res.end(ejs.render(data, {
                       results : result,
                       totalrecord : totalRecord,
                       parsing:{
                          firstPage : 6,
                          lastPage : 10,
                          totalPage : 9,
                          currentPage: 7
                       },logStatus:'N'
                    }));
               }
            }
            
         });
      }
   });
   
   /*fs.readFile(__dirname+"\\boardList.ejs", (error,data)=>{
      if(!error){
         res.writeHead(200,{"Content-type":"text/html; charset=utf-8"});
         res.end(data);
      }
   });*/
});
//글쓰기 폼
app.get("/boardWrite", (req, res)=>{
	var sesUserid = session.user.userid; //아이디, 이름, logStatus
	fs.readFile(__dirname+"\\boardWrite.ejs", "utf-8" , function(error, data) {
      if(error){
         res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
         res.end("File Read Error ~!!");
      }else{
         res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
         res.end(ejs.render(data, {userid : sesUserid}));
      }
   })
});

//글쓰기 완료
app.post('/writeOk', function(req, res){
   //클라이언트 폼의 데이터를 서버로 request
   var userid = req.param('userid');
   var subject = req.param('subject');
   var content = req.param('content');
   
   //접속자의 ip를 구한다.
   var ip = requestip.getClientIp(req); // ::ffff:127.0.0.1로 구해짐
   console.log('writeOk data=> userid=%s, subject=%s, content=%s, ip=%s', userid, subject, content, ip);
   
   var sql = "insert into board(no, userid, subject, content, ip, hit, writedate) "+
      " values(boardsq.nextval, '"+userid+"','"+subject+"','"+content+"','"+ip+"', 0, sysdate)";
   console.log("writeOk sql => ", sql);
   
   //데이터 베이스에 글등록
   //            쿼리문, 콜백함수
   conn.execute(sql,function(error, result){
      if(error){//등록실패
         res.writeHead(200, {"Content-Type":"text/html; charset=urf-8"});
         res.write("<script>");
         res.write("alert('글등록이 실패하였습니다.')");
         res.write("location.href='/boardWrite'");
         res.end("</script>");
      }else{//등록성공
         res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
         res.write("<script>alert('글이 등록되었습니다.'); location.href='/list'");
         res.end("</script>");
      }
   });
   
});

//글내용 보기
app.get('/boardView', function(req, res){
	var sesUserid;
	if(session.user != null){
		sesUserid = session.user.userid; //아이디, 이름, logStatus
	}else{
		sesUserid = "";
	}
	console.log(sesUserid);
   //1. 글번호 request
   var no = req.param('no');
   //2. 조회수 증가
   var sql = "update board set hit = hit+1 where no="+ no;
   conn.execute(sql, function(error, result){
      if(error){
         console.log("조회수 증가 에러....");
      }else{
         console.log("조회수 증가됨");
      }
   });
   //3. 레코드 선택하여 ejs에다 랜더링해서 보내기
   //CLOB 데이터 형처럼 대용량 데이터인 경우 변수(DBMS_LOB.SUBSTR()함수를 이용하여 레코드를 선택해야한다.
   var sql2="select no, userid, subject, DBMS_LOB.SUBSTR(content, DBMS_LOB.GETLENGTH(content)) as content, hit, " +
         " to_char(writedate, 'YYYY-MM-DD MM:MI') as writedate " + 
           " from board where no="+no;
   //---------------------------------------
   conn.execute(sql2, function(error, result){
      if(error){
         console.log("레코드 글내용보기 에러")
      }else{
         fs.readFile("boardView.ejs","utf-8", function(error, data){
            if(error){
               console.log("boardView.ejs 파일 읽기 에러뜸");
            }else{
               console.log("===========boardView==========");
               console.log(result);
               res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
               res.end(ejs.render(data, {records:result, userid:sesUserid}));
            }
         });
      }
   });
   
});

//글내용수정 폼
app.get('/boardEdit', (req, res)=>{
   var no = req.param("no");
   
   var sql="select no, subject, DBMS_LOB.SUBSTR(content, DBMS_LOB.GETLENGTH(content)) content, userid from board where no="+no;
   
   conn.execute(sql, (error, result)=>{
      if(error){//레코드 선택에러 발생
         res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
         res.end("레코드 선택에러~~~~~~~~~~");
      }else{ //레코드 선택 성공
         fs.readFile("boardEdit.ejs", 'utf-8', (error, data)=>{
            if(error){
               res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
               res.end("수정 폼읽기 파일 읽기 에러");
            }else{
               res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
               res.end(ejs.render(data, {records:result}));
            }
         });
      }
   });
});

//글수정(update)
app.post("/editOk",(req, res)=>{
	var no = req.param("no");
	var userid = req.param("userid");
	var subject = req.param("subject");
	var content = req.param("content");
	
	var sql ="update board set subject='"+subject+"', content='"+content+"' where no="+no+" end userid='"+userid+"'";
	
	conn.execute(sql, (error, result)=>{
		if(result.rowsAffected<=0){//수정 실패일 경우(rowsAffected : 레코드 수)
			//글수정 폼으로 이동
			res.statusCode = 302; // 302 : url이 리다이렉트로 이동한다.
			res.setHeader('Location','/boardEdit?no='+no);
			res.end();
		}else{//수정 성공시
			//글내용보기
			res.statusCode = 302;
			res.setHeader('Location', '/boardView?no='+no);
			res.end();
		}
	});
});
//레코드 삭제
app.get('/boardDel',(req,res)=>{
	var no = req.param("no");
	var sql = "delete from board where no="+no;
	
	conn.execute(sql, (error, result)=>{
		if(error){
			res.statusCode = 302;
			res.setHeader("Location", "/boardView?no="+no);
			res.end();
		}else{
			res.statusCode = 302;
			res.setHeader("Location", "/list");
			res.end();
		}
	});
});
//==================================================
server.listen(15001, ()=>{
   console.log("서버시작 http://127.0.0.1:15001/home");
})
//===================로그인==========================
var session = require('express-session')
//로그인 폼
app.get('/login', (req, res)=>{
	fs.readFile("login.html", "utf-8", (error,data)=>{
		if(error){
			res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
			res.end("로그인 폼 읽기 실패");
		}else{
			res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
			res.end(data);
		}
	});
});

//로그인 완료
app.post('/loginOk', (req, res)=>{
	var userid = req.param("userid");
	var userpwd = req.param("userpwd");
	console.log(userid, userpwd);
	
	//아이디, 이름을 선택
	var sql = "select userid, username from registor "+
			  "where userid='"+userid+"' and userpwd='"+userpwd+"'";
	
	conn.execute(sql, (error, result)=>{
		if(result.rows.length==0){//로그인 실패
			fs.readFile("login.html","utf-8",function(error, data){
				res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
				res.end(data);
			});
		}else{//로그인 성공
			console.log(result);
			
			//세션 설정
			session.user = {
				userid : result.rows[0][0],
				username : result.rows[0][1],
				logStatus : 'Y'
			};
			console.log("==== session user ====");
			console.log(session.user);
			
			fs.readFile('home.ejs', 'utf-8', (error, data)=>{
				if(error){
					res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
					res.end("404 pages......");
				}else{
					res.writeHead(200, {"Content-Type":"text/html; charset=utf-8"});
					res.end(ejs.render(data, {user:session.user, logStatus:'Y'}));
				}
			});
		}
	});
});
//로그아웃
app.get('/logout', function(req, res){
	if(session.user){//로그인 상태일때
		//세션정보 제거
		session.user = null;
		
		fs.readFile('home.ejs','utf-8',function(error, data){
			res.writeHead(200,{"Content-Type":"text/html; charset=utf-8"});
			res.end(ejs.render(data,{logStatus:'N'}));
		});
		console.log(session.user);
	}
});
