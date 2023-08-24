<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../css/board/board-view.css" rel="stylesheet"/>
<link href="../../css/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	.free_board_wrap{
		margin-top: -500px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="free_board_container">
			<div class="free_board_wrap">
				<div class="free_board_h2_wrap">
					<h2 class="con_title">공지사항</h2>
					<a href="list.do" class="back_btn">목록</a>
				</div>
	
			<div class="free_board_title">제목 : {{info.nTitle}}</div>
				<div class="free_board_user">
					<div>작성자 : {{info.uId}}</div>
					<div class="free_board_user_num">
						<div>게시글 번호 : {{info.nNo}}</div>
						<div>작성날짜 : {{info.fWriteTime}}</div>
					</div>
				</div>
				
				<div class="free_board_contents"><pre v-html="info.nContent"></pre></div>
				<div>
					<button @click="fnEdit" v-if="status == 'A'" class="btn1" >수정하기</button>
				</div> 
			</div>
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
		nNo : "${map.nNo}",
		status : "${sessionStatus}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {nNo : self.nNo, nKindNo : "UPDATE"};
			$.ajax({
                url : "view.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	console.log(data);
                }
            }); 
		},
		 fnBack : function(){
	        	location.href = "list.do";
	        },
		fnEdit : function(){
				var self = this;
				$.pageChange("edit.do", {nNo : self.nNo});
	                }

	}, // methods
	created : function() {
		var self = this;
		if(self.nNo != ""){
			self.fnGetList();
		}
	}// created
});
</script>