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
		<div><label>제목 : <input type="text" v-model="info.rTitle"></label></div>
		<div>별점 : 
			<label> 1점 : <input type="radio" name="rStar" v-model="info.rStar" value="1"></label>
			<label> 2점 : <input type="radio" name="rStar" v-model="info.rStar" value="2"></label>
			<label> 3점 : <input type="radio" name="rStar" v-model="info.rStar" value="3"></label>
			<label> 4점 : <input type="radio" name="rStar" v-model="info.rStar" value="4"></label>
			<label> 5점 : <input type="radio" name="rStar" v-model="info.rStar" value="5"></label>
		</div>
		<div><label>내용 : <input type="text" v-model="info.rContent"></label></div>
		<div><label><button @click="fnWrite">작성하기</button></label></div>
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
				alert("제목을 작성하세요");
				return;
			}
			if(self.info.rStar == ""){
				alert("별점을 체크하세요.");
				return;
			}
			if(self.info.rContent == ""){
				alert("내용을 작성하세요.");
				return;
			}
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert("글이 등록되었습니다.");
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