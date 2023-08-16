<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
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
		<h2>FAQ 게시판</h2>
		<div>
		<select id="mySelect" v-model="mySelect" @click="fnGetList">
			<option value="">:: 전체 ::</option>
			<option value="<숙박>">숙박</option>
			<option value="<렌트>">렌트</option>
			<option value="<레저>">레저</option>
			<option value="<패키지>">패키지</option>
			<option value="<포인트>">포인트</option>
			<option value="<기타문의>">기타문의</option>
		</select>
			<label><input v-model="search" placeholder="키워드검색"  @keyup.enter="fnGetList" id="myInput">
				<button @click="fnGetList">검색</button>
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
			<tr v-for="(item, index) in list">
				<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.fNo"></th>
				<th>{{item.fNo}}</th>
				<th><a @click="fnView(item.fNo)" href="javascript:;">{{item.fTitle}}</a></th>
				<th>{{item.uId}}</th>
				<th>{{item.fHits}}</th>
				<th>{{item.fWriteTime}}</th>	
			</tr>	
		</table>
	<div  v-if="status == 'A'">
		<button @click="fnRemove">삭제</button>
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
		search:"",
		status : "${sessionStatus}",
		selectItem:[],
		category:"",
		mySelect:""
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {search : self.search, category : self.mySelect};
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

		fnRemove : function(){
			var self = this;
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
        	var fList = JSON.stringify(self.selectItem);
			var param = {selectItem : fList};
            $.ajax({
                url : "removeFaqCheck.dox",
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
	        
 	     fnView : function(fNo){
 	    	$.pageChange("view.do", {fNo : fNo});	 
	     	},
	     	
		fnNCheck : function(){
				var self = this;
				 self.selectItem = [];
			},
		fnACheck : function(){
		    var self = this;
		    self.selectItem = [];
		    for(var i=0; i<self.list.length; i++){
		        self.selectItem.push(self.list[i].fNo);
				}
			}
	      
		
	}, // methods
	mounted: function() {
	      const selectElement = document.getElementById('mySelect');
	      const inputElement = document.getElementById('myInput');

	      selectElement.addEventListener('change', function() {
	          inputElement.value = this.value;
	      });
	   },
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>