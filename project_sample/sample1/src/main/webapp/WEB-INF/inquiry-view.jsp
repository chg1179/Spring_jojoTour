<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>�Խñ� �� ������</title>
<style>
	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div v-if="!showApp">��й�ȣ �Է� : <input v-model="enteredPwd" @keyup.enter="fnPwd"><button @click="fnPwd">��й�ȣ Ȯ��</button></div>
			<div v-if="showApp">
				<div>���� : {{info.iTitle}}</div>
				<div>�ۼ��� : {{info.uId}}</div>
				<div>�ۼ���¥ : {{info.iWriteTime}}</div>
				<div>���� :<pre v-html="info.iContent"></pre></div>
				<div>
					<button @click="fnEdit" v-if="uId == info.uId" >�����ϱ�</button>
					<button @click="fnAnswer" v-if="status == 'A'" >�亯�ϱ�</button>
					<button @click="fnBack">�ǵ��ư���</button>
				</div> 
			</div>
		</div>
	</div>
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
		iPassword: "${map.iPassword}",      
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
                	// �������̰ų�, �����ڰų� ������ �ۼ��� �� �� �� ���� ����
                	if (self.status === 'A' || (self.uId === self.info.uId) || self.iPassword == "") {
                        self.showApp = true;
                    }
                }
            }); 
		},
		 fnBack : function(){
	        	location.href = "list.do";
	        },
		fnEdit : function(){
				var self = this;
				$.pageChange("edit.do", {iNo : self.iNo});
	        },
	    fnAnswer : function(iNo,iTitle){
	    	var self = this;
	    	location.href = "answer.do?iNo=" + self.iNo + "&iTitle=" + self.info.iTitle;
	    },

	    //�Է��� ��й�ȣ�� ������ üũ
	    fnPwd: function() {
	    	var self = this;
	        if (self.enteredPwd === self.info.iPassword) {
	        	self.showApp = true;
	        	return;
	        } else {
	    		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
	        }
		}
	}, // methods

	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>