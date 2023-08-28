<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/board/board-view.css" rel="stylesheet"/>
<link href="../../css/board/board-btn-style.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../css/board/board-page.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>공지사항 상세 조회</title>
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
	#free_board_container{
		margin-top: 0px;
	}
	.free_board_wrap{
		margin-top:0;
		align-items: auto;
	}
	.free_board_title, .free_board_wrap{
		width : 876px;
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
				
				<div class="free_board_contents"><p v-html="info.nContent"></p></div>
				<div>
					<button @click="fnEdit" v-if="status == 'A'" class="btn1" >수정하기</button>
				</div> 
				
			<div class="page_move">
			    <ul class="page_move">
			        <li v-if="upInfo != null">
			            <span @click="fnNextTitle">
			                <span class="page_move_btn">
			                    <a href="javascript:;">
			                        <i class="fa-solid fa-sort-up"></i>다음글
			                    </a>
			                </span>
			                <p class="notice_title">
			                   <a href="javascript:;"><span>[공지]</span></a>
			                    <a href="javascript:;">
			                        {{upInfo.nTitle}}
			                    </a>
			                </p>
			            </span>
			           
			            <ul class="page_move_info">
			                <li><i class="fas fa-light fa-clock"></i><span>{{upInfo.fWriteTime}}</span></li>
			            </ul>
			        </li>
			        <li v-if="downInfo != null">
			            <span @click="fnBackTitle">
			                <span class="page_move_btn">
			                    <a href="javascript:;">
			                        <i class="fa-solid fa-sort-down"></i>이전글
			                    </a>
			                </span>
			                <p class="notice_title">
			                <a href="javascript:;"><span>[공지]</span></a>
			                    <a href="javascript:;">
			                        {{downInfo.nTitle}}
			                    </a>
			                    <em class="reply_numb"><a href=""></a></em>
			                </p>
			            </span>
			            <ul class="page_move_info">
			                <li><i class="fas fa-light fa-clock"></i><span>{{downInfo.fWriteTime}}</span></li>
			            </ul>
			        </li>
			    </ul>
			</div>
			
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		info : {},	//현재글
		upInfo : {}, // 다음글
		downInfo : {}, // 이전글
		nNo : "${map.nNo}",
		status : "${sessionStatus}",
		uId : "${sessionId}",
		back:{},
		next:{}
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
                	self.upInfo = data.upBoard;
                	self.downInfo = data.downBoard;
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
		        },
	                
	    		fnBackTitle: function() {
	    			var self = this;
	    			$.pageChange("view.do", {nNo : self.downInfo.nNo});
	    		},
	    		//다음글 로드
	    		fnNextTitle: function() {
	    			 var self = this;
	    			 $.pageChange("view.do", {nNo : self.upInfo.nNo});
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