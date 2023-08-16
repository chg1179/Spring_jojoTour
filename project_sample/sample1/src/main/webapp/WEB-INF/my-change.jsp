<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<div id="app">
		<h2>ȸ����������</h2>
		<table>
			<tr>
				<td>���̵�</td>
				<td>{{user.userId}}</td>
			</tr>
			<tr>
				<td>�̸�</td>
				<td><input type="text" value="user.name" v-model="user.name"></td>
			</tr>
			<tr>
				<td>�г���</td>
				<td><input type="text" value="user.nickName" v-model="user.nickName"></td>
			</tr>
			<tr>
				<td>�������</td>
				<td><input type="text" value="user.birth" v-model="user.birth" placeholder="8�ڸ� �Է�"></td>
			</tr>
			<tr>
				<td>����ó</td>
				<td><input type="text" value="user.phone" v-model="user.phone" placeholder="-���� �Է��ϼ���."></td>
			</tr>
			<tr>
				<td>�̸���</td>
				<td><input type="text" value="user.email" v-model="user.email"></td>
			</tr>
			<tr>
				<td><button @click="fnSearchAddr">�ּҰ˻�</button></td>
				<td><input disabled type="text" value="user.addr" v-model="user.addr"></td>
			</tr>
			<tr>
				<td>�����ȣ</td>
				<td><input disabled type="text" value="user.zipNo" v-model="user.zipNo"></td>
			</tr>
			<tr>
				<td>�� �ּ�</td>
				<td><input type="text" value="user.addrDetail" v-model="user.addrDetail"></td>
			</tr>
			
		</table>
		<button @click="fnDelYn">ȸ��Ż��</button>
		<button @click="fnMyChange">�����Ϸ�</button>
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
			if(self.user.birth.length < 8|| self.user.birth.length > 10){
				alert("��������� ��Ȯ�ϰ� �ۼ����ּ���.");
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
  					alert(self.user.userId+"���� ȸ������ ������ �Ϸ�Ǿ����ϴ�.");
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
			if(!confirm("���� Ż���Ͻðڽ��ϱ�?")){
    			return;
    		}
			var param = {userId : self.user.userId};
			$.ajax({
                url : "/delYn.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
  					alert("Ż��Ǿ����ϴ�.");
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