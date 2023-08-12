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
</style>
</head>
<body>
	<div id="app">
		<h2>FAQ 게시판</h2>
		<div>
			<label><input v-model="keyword" placeholder="키워드검색">
				<button @click="fnSearch">검색</button>
			</label>
		</div>
		<table>
			<tr>
				<th v-if="status == 'A'">선택</th>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록 날짜</th>
			</tr>
			<tr v-for="item in list">
				<th v-if="status == 'A'"><input type="radio" v-model="fNo" :value="item.fNo"></th>
				<th>{{item.fNo}}</th>
				<th><a @click="fnView(item.fNo)" href="javascript:;">{{item.fTitle}}</a></th>
				<th>{{item.fId}}</th>
				<th>{{item.fHits}}</th>
				<th>{{item.fWriteTime}}</th>	
			</tr>
		</table>
	<div><button @click="fnRemove">삭제</button></div>
	<div><button @click="fnMove">글쓰기</button></div>
	</div>
	
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		keyword:"",
		fNo : "",
		status : "${sessionStatus}"
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	console.log(data);
                	self.list = data.faqList;
                }
            }); 
		},
 		fnSearch : function(){
			var self = this;
			var param = {keyword : self.keyword};
            $.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) { 
                	self.list = data.list;
                	console.log(self.list);
                }
            });  
		},
		fnRemove : function(){
			var self = this;
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
			var param = {fNo : self.fNo};
            $.ajax({
                url : "remove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) { 
                	alert("삭제되었습니다.");
                	self.fnGetList();
                }
            }); 
		},
		
 		 fnMove : function(){
	        	location.href = "add.do";
	        }, 
	        
 	     fnView : function(fNo){
 	    	$.pageChange("view.do", {fNo : fNo});	 
	     	},
	        
	      
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>