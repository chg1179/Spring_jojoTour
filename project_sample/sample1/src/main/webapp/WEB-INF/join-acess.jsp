<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div><label><input type="checkbox" v-model="acess" value="1">����</label></div>
		<div><label><input type="checkbox" v-model="acess" value="2">����</label></div>
		
		<div>
			<label><input type="radio" v-model="acessRadio" value="3" name="agree">����</label>
			<label><input type="radio" v-model="acessRadio" value="4" name="agree">�������� ����</label>
		</div>
		<div v-if="status == 'U'">
			<button @click="fnAcess">14�� �̻� ȸ������</button>
			<button v-else @click="fnAcess">14�� �̸� ȸ������</button>
		</div>
		<div v-else>
			<button @click="fnAcess">ȣ��Ʈ ȸ������</button>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		acess : [],
		acessRadio : "",
		status : "${map.status}"
	},// data
	methods : {
		fnAcess : function(){
			var self = this;
			console.log(self.acessRadio[0]);
			if(self.acess[0] == null){
				alert("ȸ������ ����� �����ϼž� �մϴ�.");
				return;
			}else if(self.acess[1] == null){
				alert("�������� �������̿� ���Ǹ� �ϼž� ȸ�������� �����մϴ�.");
				return;
			}else if(self.acessRadio[0] == null){
				alert("�̸��ϡ����� ���� ���Ǹ� �������ּ���.");
				return;
			}else{
				$.pageChange("../join.do", {status : status});
			}

		}
	}, // methods
	created : function() {
		var self = this;
	//	self.fnGetList();
	}// created
});
</script>