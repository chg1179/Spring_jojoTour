<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>JOJO TOUR - ��Ű�� ��ǰ</title>
<style>
	#container{
		height: 1200px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="container">
			<div class="img_box">
				<img src="../img/main/tung.png">
			</div>
			<div>�غ����Դϴ�.</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		
	},// data
	methods : {
		
	}, // methods
	created : function() {
	} // created
});
</script>