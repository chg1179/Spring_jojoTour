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
	.inquiry{
		background-color : buttonface;
	}
    .inquiry::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right : 0;
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>1:1 문의 내역</h2>
		<table>
			<tr>
				<th></th>
				<th>게시글 번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>조회수</th>
				<th>등록날짜</th>
			</tr>
			<tr v-for="(item, index) in list" v-if="item.delyn =='N'">
				<td>
					<input v-if="index == 0" type="radio" :value="item.iNo" @input="changeINo(item)" name="iNo" checked="checked">
					<input v-else type="radio" :value="item.iNo" @input="changeINo(item)" name="iNo">
				</td>
				<td>{{item.iNo}}</td>
				<td>{{item.iTitle}}</td>
				<td><div v-html="item.iContent"></div></td>
				<td>{{item.iHits}}</td>
				<td>{{item.iWriteTime}}</td>
			</tr>
		</table>
		<button @click="fnEdit">수정하기</button>
		<button @click="fnRemove">삭제하기</button>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "inquiry.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	self.list = data.list;
                	if(data.list.length > 0){
                		self.iNo = self.list[0].iNo;
                	}
                }
            }); 
		},
		changeINo : function(item){
			var self = this;
			self.iNo = item.iNo;
		},
		fnRemove : function(){
			var self = this;
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			var param = {iNo : self.iNo};
			$.ajax({
                url : "i_remove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("삭제 되었습니다.");
                	self.fnGetList();
                }
            });
		},

		fnEdit : function(){
			var self = this;
			$.pageChange("inquiry/edit.do", {iNo : self.iNo});
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>