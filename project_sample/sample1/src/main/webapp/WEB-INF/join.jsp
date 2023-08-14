<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
    #join_container{
        height: 100vh;
    }
    .join_inner_con{
        background-color: #FFA41B;
    }
    .join_inner_con input{
        width: 300px;
        height: 30px;
        margin: 5px 30px;
        outline: none;
        border: 1px solid;
        padding: 0 10px;
        border-radius: 10PX;
    }
    .join_inner_box{
        background-color: #F86F03;
        border-bottom: 1px solid;
        border-left: 1px solid;
        border-right: 1px solid;
    }
    .join_title{
        text-align: center;
        margin: 10px;
    }
    #join_container, .join_tab, .join_addr, .join_btn{
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
    .join_tab input{
        display: none;
    }
    .join_tab label{
        cursor: pointer;
        border-top: 1px solid;
        border-left: 1px solid;
        width: 33.333%;
        text-align: center;
        height: 30px;
        line-height: 30px;
        background-color: #FFA41B;
    }
    .join_tab input:checked + label{
        background-color: #F86F03;
    }
    .join_tab label[for="u"]{
        border-left: none;
    }
    .join_btn button{
        width: 200px;
        margin: 5px 0;
        outline: none;
        border: none;
        background-color: rgb(82, 82, 82);
        height: 30px;
        border-radius: 10px;
        color: #fff;
        font-weight: 700;
        cursor: pointer;
    }
    .join_btn button:hover{
        background-color: #FFA41B;
    }
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
	    <div id="join_container">
	        <div class="join_inner_con">
	            <h2 class="join_title">{{user.status}}</h2>
	            <div class="join_inner_box">
	                <div class="join_tab">
	                    <input type="radio" name="stat" v-model="user.status" value="U" id="u" checked>
	                    <label class="lBox" for="u">일반회원</label>
	                    <input type="radio" name="stat"  v-model="user.status" value="H" id="h">
	                    <label class="lBox" for="h">호스트</label>
	                    <input type="radio" name="stat"  v-model="user.status" value="R" id="r">
	                    <label class="lBox" for="r">렌터카</label>
	                </div>
	                <div class="join_input_wrap">
	                    <div v-if="user.status == 'H' || user.status == 'R'">
	                            <label><input type="text" v-model="user.userId" @keyup="fnCheck" placeholder="사업자 번호"></label> 
	                        <span v-if="user.userId != ''">{{message}}</span>
	                    </div>
	                    <div v-else>
	                        <label><input type="text" v-model="user.userId" @keyup="fnCheck" placeholder="아이디"></label> 
	                        <span v-if="user.userId != ''">{{message}}</span>
	                    </div>
	                        <div><label><input type="password" v-model="user.pw1" placeholder="비밀번호"></label></div>
	                        <div><label><input type="password" v-model="user.pw2" placeholder="비밀번호 확인"></label></div>
	                        <div><label><input type="text" v-model="user.name" placeholder="이름"></label></div>
	                        <div><label><input type="text" v-model="user.nickName" placeholder="닉네임"></label></div>
	                        <div><label><input type="text" v-model="user.birth" placeholder="생년월일 ex)0000-00-00"></label></div>
	                        <div><label><input type="text" v-model="user.phone" placeholder=></label></div>
	                        <div><label><input type="text" v-model="user.email" placeholder="[선택]이메일"></label></div>
	
	                        
	                            
	                        <div><label class="join_btn"><button @click="fnSearchAddr">주소 검색</button></label></div>
	                        <div v-if="user.addr != ''" ><label><input disabled type="text" v-model="user.addr"></label></div>
	                        <div v-if="user.addrDetail != ''"><label><input type="text" v-model="user.addrDetail"></label></div>
	                        
	                </div>
	                <div class="join_btn"><button @click="fnJoin">가입하기</button></div>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>
<script>
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	app.fnResult(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo);
} 
var app = new Vue({
	el : '#app',
	data : {
		user : {
			userId : "",
			pw1 : "",
			pw2 : "",
			name : "",
			phone : "",
			birth : "",
			addr : "",
			addrDetail : "",
			nickName : "",
			email : "",
			status : "${map.status}"
		},
		joinFlg : false,
		message : ""
	},// data
	methods : {
		fnJoin : function(){
			var self = this;
			if(self.user.userId == ""){
				alert("아이디를 입력하세요.");
				return;
			}
			if(self.user.pw1 == ""){
				alert("패스워드를 입력하세요.");
				return;
			}
			if(self.user.pw1 != self.user.pw2){
				alert("패스워드가 일치하지 않습니다.");
				return;
			}
			if(self.user.name == ""){
				alert("이름을 입력하세요.");
				return;
			}
			if(self.user.birth == ""){
				alert("생년월일을 입력하세요.");
				return;
			}
			if(self.user.addr == ""){
				alert("주소를 입력하세요.");
				return;
			}
		 	var nparmap = self.user;
            $.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	alert("가입을 환영합니다.");
                	location.href="main.do";
                }
            });
		},
		fnCheck : function(){
			var self = this;
			var nparmap = {userId : self.user.userId};
            $.ajax({
                url : "check.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	if(data.cnt > 0){
                		self.message = "중복된 아이디 있음";
                	} else {
                		self.message = "사용 가능";
                		self.joinFlg = true;
                	}
                }
            });
		},
		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("addr.do", "test", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		var self = this;
    		self.user.addr = roadAddrPart1;
    		self.user.addrDetail = addrDetail;
    		// 콘솔 통해 각 변수 값 찍어보고 필요한거 가져다 쓰면 됩니다.
    		console.log(roadFullAddr);
    		console.log(roadAddrPart1);
    		console.log(addrDetail);
    		console.log(engAddr);
    	}
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>