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
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div><label>���� : <input type="text" v-model="info.rTitle"></label></div>
		<div>���� : 
			<label> 1�� : <input type="radio" name="rStar" v-model="info.rStar" value="1"></label>
			<label> 2�� : <input type="radio" name="rStar" v-model="info.rStar" value="2"></label>
			<label> 3�� : <input type="radio" name="rStar" v-model="info.rStar" value="3"></label>
			<label> 4�� : <input type="radio" name="rStar" v-model="info.rStar" value="4"></label>
			<label> 5�� : <input type="radio" name="rStar" v-model="info.rStar" value="5"></label>
		</div>
		<div><label>���� : <input type="text" v-model="info.rContent"></label></div>
		<div><label><button @click="fnWrite">�ۼ��ϱ�</button></label></div>
		{{userId}}
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
			userId : "${map.userId}",
		info : {
			rTitle : "",
			rContent : "",
			rStar : ""
		}
	},// data
	methods : {
		fnWrite : function(){
			var self = this;			
			var param = self.info;
			param.userId = self.userId;
			console.log(self.info);
			if(self.info.rTitle == ""){
				alert("������ �ۼ��ϼ���");
				return;
			}
			if(self.info.rStar == ""){
				alert("������ üũ�ϼ���.");
				return;
			}
			if(self.info.rContent == ""){
				alert("������ �ۼ��ϼ���.");
				return;
			}
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert("���� ��ϵǾ����ϴ�.");
					location.href="../review/list.do";
                }
            }); 
		},
		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>