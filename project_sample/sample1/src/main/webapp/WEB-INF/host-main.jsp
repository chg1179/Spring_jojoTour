<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȣ��Ʈ ��ǰ ���� ������</title>
<style>

</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<input type="button" value="���Ұ���" @click="fnStayPage"/>
		<input type="button" value="��������" @click="fnLeisurePage"/>
		<input type="button" value="��Ʈī����" @click="fnRentcarPage"/>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
	},// data
	methods : {
		fnStayPage : function(){
			location.href = "stay.do";
		},
		fnLeisurePage : function(){
			location.href = "leisure.do";
		},
		fnRentcarPage : function(){
			location.href = "rentcar.do";
		}
	}, // methods
	created : function() {
	}// created
});
</script>