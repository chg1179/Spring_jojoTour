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
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>공지사항</h2>
		<div>
			<label><input type="text" v-model="search" @keyup.enter="fnGetList"></label>
			<button @click="fnGetList">검색</button>
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
			<tr v-for="(item, index) in list">
				<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.nNo"></th>
				<th>{{item.nNo}}</th>
				<th><a @click="fnView(item.nNo)" href="javascript:;">{{item.nTitle}}</a></th>
				<th>{{item.uId}}</th>
				<th>{{item.nHits}}</th>
				<th>{{item.fWriteTime}}</th>	
			</tr>
		</table>
	<div v-if="status == 'A'"><button @click="fnRemove">삭제</button>
		<button @click="fnACheck">전체선택</button>
		<button @click="fnNCheck">전체해제</button>
	</div>
	<div v-if="status == 'A'"><button @click="fnMove">글쓰기</button></div>
	</div>
	
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}",
		search : "",
		selectItem : []
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {search : self.search};
			console.log(param);
			$.ajax({
                url : "/notice/list.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.noticeList;
                	console.log(self.list);
                }
            }); 
		},

		fnRemove : function(){
			var self = this;
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
        	var noList = JSON.stringify(self.selectItem);
			var param = {selectItem : noList};
            $.ajax({
                url : "removeNoticeCheck.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) { 
                	self.fnGetList();
                	self.selectItem = [];
                	alert("삭제되었습니다.");

                }
            }); 
		},
		fnMove : function(){
	        	location.href = "add.do";
		},  
		fnView : function(nNo){
 	    	$.pageChange("view.do", {nNo : nNo});	 
	    },
		fnNCheck : function(){
			var self = this;
			self.selectItem = [];
		},
		fnACheck : function(){
			var self = this;
			self.selectItem = [];
			for(var i=0; i<self.list.length; i++){
				self.selectItem.push(self.list[i].nNo);
			}
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>