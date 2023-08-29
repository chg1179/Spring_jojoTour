<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../css/my/my-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.change{
		background-color : buttonface;
	}
    .change::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
	*{
		margin: 0;
		padding: 0;
	}
	#my_change_container{
		margin : 30px 0;
		display: flex;
		justify-content: center;
		
	}
	.change_box{
		margin: 20px;
		width: 640px;
	}
	.change_box button{
		cursor: pointer;
	}
	.change_table, .change_table td{
		border: 1px solid #ccc;
		border-collapse: collapse;
	}
	.change_table{
		margin: 30px 0px;
	}
	.change_table tr td{
		padding: 15px;
		box-sizing: border-box;
	}
	.change_table tr td:first-child{
		
        background-color: #213555;
		color: #fff;
		font-weight: bold;
		padding: 19px;
		box-sizing: border-box;
	}
	.change_table tr td:last-child{
		padding-right: 55px;
		box-sizing: border-box;
	}
	.change_table tr td input{
		display: inline-block;
		height: 37px;
		border-radius: 6px;
    	padding-left: 5px;
	}
	.change_email input{
		width: 300px;
	}
	.change_addr_title button{
		padding: 2px;
		background-color: #fff;
		color: #213555;;

	}
	.change_addr input{
		width: 400px;
	}
	.change_del_btn{
		display: flex;
		justify-content: right;
		margin-right: 10px;
	}
	.change_del_btn button{
		padding: 5px;
		color: #fff;
		background-color: #505050;
		outline: none;
		border: none;
	}
	.change_update_btn{
		display: flex;
		justify-content: center;
	}
	.change_update_btn button{
        background-color: #213555;
		color: #fff;
		border: none;
		padding: 10px 35px;
		font-weight: bold;
		font-size: 16px;
	}
	button{
	border-radius: 5px;
	}

</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="my_change_container">
			<div class="change_box">
				<div class="coreTxt"><span class="bar">ㅣ</span> 회원정보 수정</div>
				<table class="change_table">
					<tr>
						<td style="width: 160px;">아이디</td>
						<td style="width: 340px;">{{user.userId}}</td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" value="user.name" v-model="user.name" maxlength="8"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" value="user.nickName" v-model="user.nickName" maxlength="10"></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td><input type="date" value="user.birth" v-model="user.birth"></td>
					</tr>
					<tr>
						<td>연락처</td>
						<td><input type="text" value="user.phone" v-model="user.phone" maxlength="11"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td class="change_email"><input type="text" value="user.email" v-model="user.email" maxlength="30"></td>
					</tr>
					<tr>
						<td class="change_addr_title">주소</td>
						<td class="change_addr" style="display: flex;"><input disabled type="text" value="user.addr" v-model="user.addr"><button @click="fnSearchAddr" style="width: 50px; height: 42px;color:white;background-color:#213555;margin-left:5px;">검색</button></td>
					</tr>
					<tr>
						<td>우편번호</td>
						<td><input disabled type="text" value="user.zipNo" v-model="user.zipNo"></td>
					</tr>
					<tr>
						<td>상세 주소</td>
						<td><input type="text" value="user.addrDetail" v-model="user.addrDetail"></td>
					</tr>
					
				</table>
				<div class="change_del_btn"><button @click="fnDelYn" style="padding: 10px;">회원탈퇴</button></div>
				<div class="change_update_btn"><button @click="fnMyChange">수정완료</button></div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	app.fnResult(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo);
} 
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		user : {
			userId : "${sessionId}",
			name : "${sessionName}",
			nickName :"${sessionNickname}",
			birth : "${sessionBirth}",
			phone : "${sessionPhone}",
			email : "${sessionEmail}",
			addr : "${sessionAddr}",
			addrDetail : "${sessionAddrDetail}",
			zipNo : "${sessionZipNo}"
		},
		delYn : ""
	},// data
	methods : {
		fnMyChange : function(){
			var self = this;
			self.user.phone = self.user.phone.replaceAll("-", "");
			if(self.user.name == ""){
				alert("이름을 입력하세요.");
				return;
			}
			if (self.user.name.match(/\s/)) {
			    alert("이름에 공백을 포함할 수 없습니다.");
			    return;
			}
			if(self.user.nickName == ""){
				alert("닉네임을 입력하세요.");
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
			if(self.user.addr == ""){
				alert("주소를 입력하세요.");
				return;
			}
			
			if(self.user.phone == ""){
				alert("핸드폰 번호를 입력하세요.");
				return;
			}
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.user.phone)){
				alert("연락처는 숫자만 입력해주세요.");
				return;
			}
			
			if(self.user.email == ""){
				alert("이메일 주소를 입력하세요.");
				return;
			}
			regex = new RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
			if (!regex.test(self.user.email)) {
			    alert("이메일 주소를 정확하게 입력하세요.");
			    return;
			}
			
			var param = self.user;
			$.ajax({
                url : "/my/change.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	console.log(data);
  					alert(self.user.userId+"님의 회원정보 수정이 완료되었습니다.");
					location.href="change.do";
                }
            }); 
		},

		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("../addr.do", "test", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		var self = this;
    		self.user.addr = roadAddrPart1;
    		self.user.addrDetail = addrDetail;
    		self.user.zipNo = zipNo;
    	},
    	fnDelYn : function(){
    		var self = this;
			if(!confirm("정말 탈퇴하시겠습니까?")){
    			return;
    		}
			var param = {userId : self.user.userId};
			$.ajax({
                url : "/delYn.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
  					alert("탈퇴되었습니다.");
  					location.href="../main.do";
                }
            });
    	}
		
	}, // methods
	created : function() {
		var self = this;
		/* self.fnGetList();  */
	}// created
});
</script>