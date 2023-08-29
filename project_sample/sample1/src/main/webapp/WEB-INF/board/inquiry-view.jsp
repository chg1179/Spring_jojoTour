<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/board/board-view.css" rel="stylesheet"/>
<link href="../../css/board/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>게시글 상세 페이지</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
	}
	
	.pwd {
	  position: relative;
	  width: 300px;
	  margin : 100px auto;
	  margin-bottom: 286px;
	}
	
	.pwd1 {
	  font-size: 15px;
	  color: #222222;
	  width: 300px;
	  border: none;
	  border-bottom: solid #aaaaaa 1px;
	  padding-bottom: 10px;
	  padding-left: 10px;
	  position: relative;
	  background: none;
	  z-index: 5;
	}
	
	.pwd1::placeholder { color: #aaaaaa; }
	.pwd1:focus { outline: none; }
	
	#free_board_container span {
	  display: block;
	  position: absolute;
	  bottom: 0;
	  left: 0%;  /* right로만 바꿔주면 오 - 왼 */
	  background-color: #666;
	  width: 0;
	  height: 2px;
	  border-radius: 2px;
	  transition: 0.5s;
	}
	
	.pwd2 {
	  position: absolute;
	  color: #aaa;
	  left: 10px;
	  font-size: 20px;
	  bottom: 8px;
	  transition: all .2s;
	}
	
	.pwd1:focus ~ .pwd2, .pwd1:valid ~ .pwd2 {
	  font-size: 16px;
	  bottom: 40px;
	  color: #666;
	  font-weight: bold;
	}
	
	.pwd1:focus ~ span, .pwd1:valid ~ span {
	  width: 100%;
	}
	.btnCheck{
		display:none;
	}
	.free_board_contents {
	    margin: 20px;
	    font-size: 18px;
	    margin-bottom: 200px;
	}
	.free_board_title, .free_board_wrap{
		width : 876px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="free_board_container">
			<div class="free_board_wrap">
			
			<div v-if="!showApp" class="pwd"><input class="pwd1" v-model="enteredPwd" @keyup.enter="fnPwd" type="password" required>
			<label class="pwd2">PASSWORD</label>
			<span></span></div>
			<button @click="fnPwd" class="btnCheck">확인</button>
			<div v-if="showApp">
			
				<div class="free_board_h2_wrap">
					<h2 class="con_title">1:1문의 게시판</h2>
					<a href="list.do" class="back_btn">목록</a>
				</div>
				
				<div class="free_board_title">제목 : {{info.iTitle}}</div>
				<div class="free_board_user">
					<div>작성자 : {{info.uId}}</div>
					<div class="free_board_user_num">
						<div>게시글 번호 : {{info.iNo}}</div>
						<div>작성날짜 : {{info.iWriteTime}}</div>
					</div>
				</div>
				
				<div class="free_board_contents"><p v-html="info.iContent"></p></div>
				<div>
					<button @click="fnEdit('U')" v-if="uId == info.uId && info.answerYn == 'N'" class="btn1">수정하기</button>
					<button @click="fnEdit('A')" v-if="status == 'A' && info.answerYn == 'N'" class="btn1">답변하기</button>
				</div> 
			</div>
			
			<hr v-if="showApp">
			</div>
			<hr>
		</div>
	
	
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		info : {},
		iNo : "${map.iNo}",
		status : "${sessionStatus}",
		uId : "${sessionId}",  
		enteredPwd: "",
        showApp: false
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {iNo : self.iNo, categoryNo : "UPDATE"};
			$.ajax({
                url : "view.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	console.log(self.info);
                	// 공개글이거나, 관리자거나 본인이 작성한 글 일 때 열람 가능
                	if (self.status === 'A' || (self.uId === self.info.uId) || self.info.iPassword == "") {
                        self.showApp = true;
                    }
                }
            }); 
		},
		fnBack : function(){
	        	location.href = "list.do";
	        },
		fnEdit : function(answer){
			// A(answer) : 관리자 답변, U(update) : 수정
			var self = this;
			$.pageChange("edit.do", {iNo : self.iNo, answer : answer});
	    },
	    fnAnswer : function(iNo,iTitle){
	    	var self = this;
	    	location.href = "answer.do?iNo=" + self.iNo + "&iTitle=" + self.info.iTitle;
	    },

	    //입력한 비밀번호가 같은지 체크
	    fnPwd: function() {
	    	var self = this;
	        if (self.enteredPwd === self.info.iPassword) {
	        	self.showApp = true;
	        	return;
	        } else {
	    		alert("비밀번호가 일치하지 않습니다.");
	        }
		}
	}, // methods

	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>