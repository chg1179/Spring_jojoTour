<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../css/board/board-view.css" rel="stylesheet"/>
<link href="../css/board/board-page.css" rel="stylesheet"/>
<link href="../../css/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.free_board_title{
		display: flex; justify-content: space-between; align-items: center;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="free_board_container">
			<div class="free_board_wrap">
				
				<div class="free_board_h2_wrap">
					<h2 class="con_title">�����Խ���</h2>
					<a href="list.do" class="back_btn">���</a>
				</div>
				
				<div class="free_board_title">
					<div>���� : {{info.freeTitle}}</div>
					<a @click="fnReport" href="javascript:;" v-if="status == 'H' || status == 'U' || status == 'A'">
					<i class="fas fa-solid fa-bullhorn fa-xl" style="color: #ff0000;" title="�Ű��ϱ�"></i>
				</a> 
				</div>
				
				<div class="free_board_user">
					<div>�ۼ��� : {{info.uId}}</div>
					<div class="free_board_user_num">
						<div>�Խñ� ��ȣ : {{info.freeNo}}</div>
						<div>�ۼ� �ð� : {{info.fWriteTime}}</div>
					</div>
				</div>

				<div class="free_board_contents">
					<pre v-html="info.freeContent"></pre>
				</div>
				<div class="free_board_good">
					<a @click="fnRecommend" href="javascript:;" class="free_board_good_a">
						<i class="fas fa-light fa-thumbs-up fa-bounce fa-3x" title="��õ�ϱ�">
						</i>
					</a>
					<div class="free_board_good_b">{{info.recommend}}��</div>
				</div>
				<div>
					<button @click="fnDel" v-if="uId == info.uId || status == 'A'" class="btn1">�����ϱ�</button>
					<button @click="fnEdit" v-if="uId == info.uId" class="btn1">�����ϱ�</button>
				</div> 
				<div class="free_board_reply_title">
					<h3>���</h3>
				</div>	
			
				<ul>
					<li >
						<div v-for="(item, index) in commentList">
							<div> {{item.uId}} {{item.cWriteTime}} </div>
							<div>
								{{item.comm}} 
								<a @click="fnRemoveComm(item.cNo)" href="javascript:;">
									<i class="fa-solid fa-circle-xmark fa-xs"></i>
								</a> 
							</div>
							<hr v-if="index < commentList.length - 1">
						</div>
					</li>
				</ul>
				<br>
				<div class="free_board_reply_contents">
					<textarea rows="10" cols="50" v-model="comment" @keyup.enter="fnComment" placeholder="�α��� ��, �̿����ּ���"></textarea>
					<div class="free_board_reply_contents_btn">
						<button style="vertical-align: middle; margin-bottom: 35px;" @click="fnComment" >���</button>
					</div>
				</div>

			<div class="page_move">
			    <ul class="page_move">
			        <li v-if="upInfo != null">
			            <span @click="fnNextTitle">
			                <span class="page_move_btn">
			                    <a href="javascript:;">
			                        <i class="fa-solid fa-sort-up"></i>������
			                    </a>
			                </span>
			                <p class="notice_title">
			                   <a href="javascript:;"><span>[����]</span></a>
			                    <a href="javascript:;">
			                        {{upInfo.freeTitle}}
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
			                        <i class="fa-solid fa-sort-down"></i>������
			                    </a>
			                </span>
			                <p class="notice_title">
			                <a href="javascript:;"><span>[����]</span></a>
			                    <a href="javascript:;">
			                        {{downInfo.freeTitle}}
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
		info : {},	//�����
		upInfo : {}, // ������
		downInfo : {}, //������
		freeNo : "${map.freeNo}",
		status : "${sessionStatus}",
		commentList :[],
		comment :"",
		uId : "${sessionId}",
		list:[],
		back:{},
		next:{}
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
                	self.upInfo = data.upBoard;
                	self.downInfo = data.downBoard;
                	self.commentList = data.commentList;
                }
            }); 
		},
		fnComment : function(){
			var self = this;
			if (self.status !== 'A' && self.status !== 'U' && self.status !== 'H'){
	            if (confirm("�α��� �� �̿����ּ���. �α��� �������� �̵��Ͻðڽ��ϱ�?")) {
	               
	                window.location.href = "/login.do";
	            }
	            return;
			}
			var param = {freeNo : self.freeNo, comment : self.comment, uId : self.uId};
			$.ajax({
                url : "comment.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("��ϵǾ����ϴ�.");
                	self.comment = "";
                	self.fnGetList();
                }
            }); 
		},
		fnRemoveComm : function(cNo){
			var self = this;
			if(!confirm("���� �����Ͻðڽ��ϱ�?")){
				return;
			}
			var param = {cNo : cNo};
			$.ajax({
                url : "c_remove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�����Ǿ����ϴ�..");
                	self.fnGetList();
                }
            }); 	
		},
		
		fnDel : function(){
			var self = this;
        	if(!confirm("���� �����Ͻðڽ��ϱ�?")){
        		return;
        	}
			var param = {freeNo : self.freeNo};
			$.ajax({
                url : "removeFree.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�����Ǿ����ϴ�.");
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
				var self = this;
	        	if(!confirm("�ش� �Խñ��� �Ű��Ͻðڽ��ϱ�?")){
	        		return;
	        	}
				var param = {freeNo : self.freeNo};
				$.ajax({
	                url : "addReport.dox",    
	                dataType:"json",	
	                type : "POST",
	                data : param,
	                success : function(data) { 
	                	alert("�Ű�Ǿ����ϴ�..");
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
	                	alert("��õ �Ϸ� *^~^*");
	                	self.fnGetList();
	                }
	            }); 
			},
			//������ �ε�
			fnBackTitle: function() {
			    var self = this;
			    $.pageChange("view.do", {freeNo : self.downInfo.freeNo});
			},
			//������ �ε�
			fnNextTitle: function() {
			    var self = this;
			    $.pageChange("view.do", {freeNo : self.upInfo.freeNo});
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