<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
			<div>게시글 번호 : {{info.freeNo}}</div>
			<div>제목 : {{info.freeTitle}}</div>
			<div>작성자 : {{info.uId}}</div>
			<div>작성날짜 : {{info.fWriteTime}}</div>
			<div>내용 :<pre v-html="info.freeContent"></pre></div>
		<div>
			<button>삭제하기</button>
			<button @click="fnEdit" v-if="uId == info.uId">수정하기</button>
			<button @click="fnBack">되돌아가기</button>
		</div> 
	<hr>
		<div v-for="(item, index) in commentList">
			<span>[ {{item.uId}} ] : </span>
			<span style="width : 300px; display: inline-block;">
				{{item.comm}} 
				<a @click="fnRemove(item.cNo)" href="javascript:;" v-if="item.uId == uId || status == 'A'">
					<i class="fa-solid fa-circle-xmark fa-xs"></i>
				</a> 
			</span>
			<span >{{item.cWriteTime}}</span>
		</div>
		<hr>
		<div>
			<textarea rows="3" cols="40" v-model="comment" @keyup.enter="fnComment"></textarea>
			<button style="vertical-align: middle; margin-bottom: 35px;" @click="fnComment">댓글 등록</button>
		</div>
		</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		info : {},
		freeNo : "${map.freeNo}",
		status : "${sessionStatus}",
		commentList :[],
		comment :"",
		uId : "${sessionId}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {freeNo : self.freeNo};
			$.ajax({
                url : "view.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	self.commentList = data.commentList;
                }
            }); 
		},
		fnComment : function(){
			var self = this;
			var param = {freeNo : self.freeNo, comment : self.comment, uId : self.uId};
			$.ajax({
                url : "comment.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("등록되었습니다.");
                	self.comment = "";
                	self.fnGetList();
                }
            }); 
		},
		fnRemove : function(cNo){
			var self = this;
			if(!confirm("정말 삭제할거냐")){
				return;
			}
			var param = {cNo : cNo};
			$.ajax({
                url : "c_remove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("삭제되었습니다..");
                	self.fnGetList();
                }
            }); 	
		},
		 fnBack : function(){
	        	location.href = "list.do";
	        },
		fnEdit : function(){
				var self = this;
				$.pageChange("edit.do", {freeNo : self.freeNo});
	         }

	}, // methods
	created : function() {
		var self = this;
		if(self.freeNo != ""){
			self.fnGetList();
		}
	}// created
});
</script>