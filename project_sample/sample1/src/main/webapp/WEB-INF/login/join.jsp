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
        padding-top : 20px;
    }
    .join_title{
        text-align: center;
        margin: 10px;
    }
    .join_check_wrap{
        position: relative;
    }
    .join_check{
        position: absolute;
        top: 10px;
        font-size: 16px;
        width : 200px;
        margin-left : 10px;
    }

    #join_container, .join_tab, .join_addr, .join_btn{
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
    .join_tab input{
        display: none;
    }
    .join_btn{
    	padding-bottom: 20px;
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
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	    <div id="join_container">
	        <div class="join_inner_con">
	            <h2 class="join_title" v-if="user.status == 'U'"><span style="color : blue;">일반</span> 회원가입</h2>
	            <h2 class="join_title" v-else><span style="color : red;">호스트</span> 회원가입</h2>
	            <div class="join_inner_box">
	                <div class="join_input_wrap">
	                    <div class="join_check_wrap">
	                        <label><input type="text" v-model="user.userId" @keyup="fnCheck" placeholder="아이디"></label> 
	                        <span class="join_check" v-if="user.userId != ''">{{message}}</span>
	                    </div>
	                        <div><label><input type="password" v-model="user.pw1" placeholder="비밀번호"></label></div>
	                        <div><label><input type="password" v-model="user.pw2" placeholder="비밀번호 확인"></label></div>
	                        <div><label><input type="text" v-model="user.name" placeholder="이름"></label></div>
	                        <div><label><input type="text" v-model="user.nickName" placeholder="닉네임"></label></div>
	                        <div><label><input type="date" v-model="user.birth" id="birth"></label></div>
	                        <div><label><input type="text" v-model="user.phone" id ="phone" placeholder="핸드폰 번호"></label></div>
	                        <div><label><input type="text" v-model="user.email" placeholder="이메일"></label></div>
	
	                        
	                            
	                        <div><label class="join_btn"><button @click="fnSearchAddr">주소 검색</button></label></div>
	                        <div v-if="user.addr != ''" ><label><input disabled type="text" v-model="user.addr"></label></div>
	                        <div v-if="user.zipNo != ''" ><label><input disabled type="text" v-model="user.zipNo"></label></div>
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
			zipNo : "",
			status : "${map.status}"
		},
		upAndDown : "${map.upAndDown}",
		joinFlg : false,
		message : ""
	},// data
	methods : {
		fnJoin : function(){
			var self = this;
			var birth = document.querySelector('#birth').value;
			var age = birth.split("-");
			var now = new Date();
			var year =  now.getFullYear() - parseInt(age[0],10);
	        var month = (now.getMonth()+1) - parseInt(age[1],10);
	        var day = parseInt(age[2],10);
	        self.user.phone = self.user.phone.replaceAll("-", "");
			if(self.user.userId == ""){
				alert("아이디를 입력하세요.");
				return;
			}
			if (self.user.userId.match(/\s/)) {
			    alert("아이디에 공백을 포함할 수 없습니다.");
			    return;
			}
		    var regex = /^[a-zA-Z0-9]+$/;
		    if (!regex.test(self.user.userId)) {
			    alert("아이디는 영문자와 숫자만입력할 수 있습니다.");
		        self.joinFlg = false;
		        return;
		    }
			if(self.user.pw1 == ""){
				alert("패스워드를 입력하세요.");
				return;
			}
			if(self.user.pw1.length < 8){
				alert("패스워드는 8자리 이상 입력하세요.");
				return;
			}
			if (self.user.pw1.match(/\s/)) {
			    alert("비밀번호에 공백을 포함할 수 없습니다.");
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
			if (self.user.name.match(/\s/)) {
			    alert("이름에 공백을 포함할 수 없습니다.");
			    return;
			}
			if (self.user.nickName.match(/\s/)) {
			    alert("닉네임에 공백을 포함할 수 없습니다.");
			    return;
			}
			if(self.user.birth == ""){
				alert("생년월일을 입력하세요.");
				return;
			}
	        if(month < 0 || (month == 0 && now.getDate() <= day)){
	              year--;
	          }
	        if(self.upAndDown == "up"){
		        if(year < 14){
		            alert("만 14세 이상만 가입이 가능합니다.");
		            return;
		         }
	        } else if(self.upAndDown == "down"){
		        if(year >= 14){
		            alert("만 14세 미만만 가입이 가능합니다.");
		            return;
		         }
	        }
			if(self.user.addr == ""){
				alert("주소를 입력하세요.");
				return;
			}
			if(self.user.phone == ""){
				alert("핸드폰 번호를 입력하세요.");
				return;
			}
			if(self.user.email == ""){
				alert("이메일 주소를 입력하세요.");
				return;
			}
			var regex = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
			if (!regex.test(self.user.email)) {
			    alert("이메일 주소를 정확하게 입력하세요.");
			    return;
			}
			var nparmap = { userId: self.user.userId , nickName : self.user.nickName, email : self.user.email};
		    $.ajax({
		        url: "check.dox",
		        dataType: "json",    
		        type: "POST", 
		        data: nparmap,
		        success: function(data) {
		            if (data.cnt > 0) {
		                alert("중복된 아이디가 있습니다. 다른 아이디를 선택해주세요.");
		                return;
		            } else if(data.nickCnt > 0){
		                alert("중복된 닉네임이 있습니다. 다른 닉네임을 선택해주세요.");
		                return;
		            } else if(data.emailCnt > 0){
		                alert("중복된 이메일이 있습니다. 다른 이메일을 선택해주세요.");
		                return;
		            } else {
		                var nparmap = self.user;
		                $.ajax({
		                    url: "add.dox",
		                    dataType: "json",    
		                    type: "POST", 
		                    data: nparmap,
		                    success: function(data) {
		                        alert(self.user.nickName + "님 가입을 환영합니다.\n 포인트 5,000점이 적립되었습니다.");
		                        /* location.href = "main.do"; */
		                    }
		                });
		            }
		        }
		    });
		},
		fnCheck : function(){
			var self = this;
		    var userId = self.user.userId;
		    var regex = /^[a-zA-Z0-9]+$/;

		    if (!regex.test(userId)) {
		        self.message = "영문자와 숫자만 입력 가능합니다.";
		        self.joinFlg = false;
		        return;
		    }
		    if (userId.match(/\s/)) {
		        self.message = "공백을 포함할 수 없습니다.";
		        self.joinFlg = false;
		        return;
		    }
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
    		self.user.zipNo = zipNo;
    		// 콘솔 통해 각 변수 값 찍어보고 필요한거 가져다 쓰면 됩니다.
    		console.log(roadFullAddr);
    		console.log(roadAddrPart1);
    		console.log(addrDetail);
    		console.log(engAddr);
    		console.log(zipNo);
    	}
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>