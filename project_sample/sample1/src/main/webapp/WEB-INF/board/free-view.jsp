<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<link href="../../css/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	*{
		margin: 0;
		padding: 0;
	}
	#free_board_container{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100vh;
		margin-top: 100px;
	}
	.free_board_h2_wrap{
		display: flex;
		justify-content: space-between;
		margin-top: 60px;
		margin-bottom: 30px;
    	width: 100%;
	}
	.free_board_wrap h2{
		font-size: 34px;
		color: #333;
		height: 40px;
	}
	.free_board_title{
		width: 876px;
		line-height: 1.3;
		border-top: 1px solid #7e7e7e;
		color: #333;
		font-size: 24px;
		background-color: #f9f9f9;
		font-weight: bold;
		padding: 37px 27px 30px;
	}
	.free_board_user{
		display: flex;
		justify-content: space-between;
		margin: 20px;
	}
	.free_board_contents{
		margin : 20px; 
		font-size: 18px;
	}
	.free_board_user_num{
		display: flex;
		justify-content: space-between;
		
	}
	.free_board_user_num div:first-child{
		margin-right: 20px;
	}
	.free_board_good{
		display: flex;
		justify-content: center;
	}
	.free_board_reply_title{
		width: 100%;
		border-top: 1px solid #e3e3e3;
		background-color: #f9f9f9;
		box-sizing: border-box;
	}
	.free_board_reply_title h3{
		margin: 10px;
		height: 44px;
		line-height: 45px;
	}
	.free_board_reply_contents{
		height: 230px;
		background-color: #e8eaee;
		border: 1px solid #dcdde1;
	}
	.free_board_reply_contents textarea{
		width: 90%;
		display: block;
		margin: 10px auto;
		padding: 20px;
		box-sizing: border-box;
		height: 160px;
	}
	.free_board_reply_contents_btn{
		display: flex;
		align-items: center;
		justify-content: right;
		margin-right: 50px;
	}
	.free_board_reply_contents_btn button{
	    font-size: 16px;
	    color: #fff;
	    text-align: center;
	    background-color: #747a86;
	    border-radius: 2px;
	    padding: 9px 14px 9px 14px;
	    border: 1px solid #747a86;
	    display: inline-block;
	    line-height: 1;
	}
	.free_board_good_a{
		display: block;
	}
	.free_board_good_a i{
		color: #540bfe;
		margin-right: 25px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="free_board_container">
			<div class="free_board_wrap">
				<div class="free_board_h2_wrap">
					<h2 class="con_title">자유게시판</h2>
					<a href="list.do" style="width:56px; text-align:center;">목록</a>
				</div>
				<div class="free_board_title">제목 : {{info.freeTitle}}</div>
				<div class="free_board_user">
					<div>작성자 : {{info.uId}}</div>
					<div class="free_board_user_num">
						<div>게시글 번호 : {{info.freeNo}}</div>
						<div>작성 시간 : {{info.fWriteTime}}</div>
					</div>
				</div>
				<a @click="fnReport" href="javascript:;" v-if="status == 'H' || status == 'U' || status == 'A'">
					<i class="fas fa-light fa-hand-middle-finger fa-shake fa-2x" style="color: #ff0000;"></i>
				</a> 
				<div class="free_board_contents">
					<pre v-html="info.freeContent"></pre>
				</div>
				<div class="free_board_good">
					<a @click="fnRecommend" href="javascript:;" class="free_board_good_a">
						<i class="fas fa-light fa-thumbs-up fa-bounce fa-3x">
						</i>
					</a>
					<div>{{info.recommend}}명</div>
				</div>
				<div>
					<button @click="fnDel" v-if="uId == info.uId || status == 'A'">삭제하기</button>
					<button @click="fnEdit" v-if="uId == info.uId">수정하기</button>
				</div> 
				<div class="free_board_reply_title">
					<h3>댓글</h3>
				</div>	
				<ul>
					<li>
						<div v-for="(item, index) in commentList">
							<div> {{item.uId}} {{item.cWriteTime}} </div>
							<div>
								{{item.comm}} 
								<a @click="fnRemoveComm(item.cNo)" href="javascript:;" v-if="item.uId == uId || status == 'A'">
									<i class="fa-solid fa-circle-xmark fa-xs"></i>
								</a> 
							</div>
						</div>
					</li>
				</ul>
				<div class="free_board_reply_contents">
					<textarea rows="10" cols="50" v-model="comment" @keyup.enter="fnComment" placeholder="로그인 후, 이용해주세요"></textarea>
					<div class="free_board_reply_contents_btn">
						<button style="vertical-align: middle; margin-bottom: 35px;" @click="fnComment" v-if="status == 'A'||status == 'U'||status == 'H'">등록</button>
					</div>
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
		info : {},
		freeNo : "${map.freeNo}",
		status : "${sessionStatus}",
		commentList :[],
		comment :"",
		uId : "${sessionId}",
		list:[]
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
		fnRemoveComm : function(cNo){
			var self = this;
			if(!confirm("정말 삭제하시겠습니까?")){
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
		
		fnDel : function(){
			var self = this;
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
			var param = {freeNo : self.freeNo};
			$.ajax({
                url : "removeFree.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("삭제되었습니다.");
                	self.fnGetList();
                	window.location.href = "list.do";
                }
            }); 
		},
		
		fnEdit : function(){
				var self = this;
				$.pageChange("edit.do", {freeNo : self.freeNo});
	         },
	         
	         fnReport : function(){
				var self = this;
				var param = {freeNo : self.freeNo};
				$.ajax({
	                url : "addReport.dox",    
	                dataType:"json",	
	                type : "POST",
	                data : param,
	                success : function(data) { 
	                	alert("신고되었습니다..");
	                	self.fnGetList();
	                	window.location.href = "list.do";
	                }
	            }); 
			},
			fnRecommend : function(){
				var self = this;
				var param = {freeNo : self.freeNo};
				$.ajax({
	                url : "addRecommend.dox",   
					dataType:"json",	
	                type : "POST",
	                data : param,
	                success : function(data) { 
	                	alert("추천 완료 *^~^*");
	                	self.fnGetList();
	                }
	            }); 
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