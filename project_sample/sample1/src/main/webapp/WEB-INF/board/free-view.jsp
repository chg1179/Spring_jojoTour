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
	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
	.contents_wrap {
    width: 930px;
    float: left;
    height: 100%;
	}
	.contents_wrap.m_btm {
	    margin-bottom: 150px;
	}
	.con_title {
    font-size: 34px;
    color: #333;
    margin-top: 60px;
    width: 100%;
    float: left;
    margin-bottom: 30px;
    height: 40px;
	}
	.con_title_btn {
    float: right;
    line-height: 1;
    margin: 0;
    padding: 0;
	}
	.back_btn {
    display: inline-block;
    font-size: 13px;
    color: #666;
    padding: 13px 11px;
    line-height: 1;
    border: 1px solid #e6e6e6;
	}
	#container {
    float: left;
    width: 100%;
    height: 100%;
	}
	.qs_title {
    float: left;
    width: 876px;
    line-height: 1.3;
    min-height: 36px;
    border-top: 1px solid #7e7e7e;
    color: #333;
    font-size: 24px;
    background-color: #f9f9f9;
    word-break: break-all;
    font-weight: bold;
    padding: 37px 27px 30px;
    margin-top: 0 !important;
	}
	.qs_info_wrap {
    float: left;
    width: 100%;
    height: 55px;
    line-height: 55px;
    border-top: 1px solid #e3e3e3;
    border-bottom: 1px solid #e3e3e3;
	}
	.qs_id {
	    float: left;
	    margin-left: 27px;
	    height: 100%;
	    font-size: 13px;
	}
	.qs_info p.last {
	    margin-right: 27px;
	}
	.qs_id a {
	    float: left;
	    color: #888;
	}
	
	.qs_id a img {
	    margin-bottom: 3px;
	    margin-right: 5px;
	    vertical-align: middle;
	}
	
	.qs_info {
	    float: right;
	}
	
	.qs_info span {
	    float: left;
	    line-height: 1;
	    margin-top: 12px;
	    padding-left: 31px;
	    background: url("https://ssl.nexon.com/s2/game/maplestory/renewal/common/btn_line_img.png") left center no-repeat;
	}
	
	.qs_info span img {
	    float: left;
	}
	
	.qs_info span.report {
	    margin-right: 27px;
	    background: url();
	    padding: 0;
	    margin-left: 9px;
	}
	
	.qs_info p {
	    float: left;
	    font-size: 12px;
	    color: #aaa;
	    margin-right: 25px;
	    line-height: 1;
	    margin-top: 21px;
	    font-family: "Tahoma"
	}
	
	.qs_info p.last {
	    margin-right: 27px;
	}
	
	.qs_info p img {
	    margin-right: 4px;
	    vertical-align: middle;
	    margin-bottom: 2px;
	}
	.qs_text {
    float: left;
    width: 876px;
    margin-top: 40px;
    margin-left: 27px;
    font-size: 16px;
    color: #333;
    line-height: 26px;
    margin-bottom: 40px;
    word-break: break-all;
    display: block;
	}
	.qs_text img {
	    max-width: 100%;
	    display: block
	}
	.qs_empathy_wrap {
    width: 100%;
    position: relative;
    float: left;
    height: auto;
    text-align: center;
    position: relative;
    margin-bottom: 25px;
    z-index: 999999;
	}
	.qs_empathy_wrap a img {
	width:190px;
	}
	.empathy_info {
	    position: relative;
	}
	.empathy_info p {
	    margin: 0;
	    display: inline-block;
	    font-size: 16px;
	    color: #666666;
	    position: absolute;
	    top: 0;
	}
	.empathy_info p > a {
	    padding: 0px 25px;
	    border: 1px solid #e3e3e3;
	    border-image: none;
	    height: 51px;
	    color: #666;
	    line-height: 51px;
	    display: inline-block;
	    margin-left: 5px;
	    background-color: #f7f7f7;
	}
	.empathy_info p > a:hover {
	    border: 1px solid #afafaf;
	}
	.empathy_info p > span {
	    font-size: 16px;
	    border-bottom: 1px solid #9fadca;
	    margin-top: 13px;
	    margin-left: 20px;
	    float: left;
	}
	.empathy_info p > span a {
	    color: #9fadca;
	}
	.empathy_popup {
	    position: absolute;
	    top: 0;
	    left: 568px;
	    width: 188px;
	    background-color: #fff;
	    border: 1px solid #e3e3e3;
	    z-index: 9999;
	    display: none;
	    text-align: left;
	}
	.empathy_numb_popup {
	    position: relative;
	    float: left;
	    width: 100%;
	    height: 51px;
	    line-height: 51px;
	    font-size: 13px;
	    color: #666;
	}
	.empathy_numb {
	    margin-left: 20px;
	    font-size: 13px;
	}
	.empathy_numb a {
	    border-bottom: 0px;
	    color: #9fadca;
	}
	
	.popup_close {
	    position: absolute;
	    top: 11px;
	    right: 5px;
	    width: 33px;
	    height: 23px;
	    line-height: 23px;
	    text-align: center;
	    font-size: 12px;
	}
	
	.popup_close a {
	    float: left;
	    width: 100%;
	    height: 100%;
	    color: #666666;
	}
	.reply_wrap {
    float: left;
    width: 100%;
	}
	
	.reply_title {
	    float: left;
	    width: 100%;
	    height: 44px;
	    line-height: 45px;
	    border-top: 1px solid #e3e3e3;
	    background-color: #f9f9f9;
	}
	
	.reply_title h2 {
	    float: left;
	    margin-left: 27px;
	    font-size: 16px;
	    color: #333333;
	}
	
	.reply_title h2 span {
	    font-size: 16px;
	    color: #f68400;
	    margin-left: 5px;
	  }
	  .reply_ul {
		    float: left;
		    width: 100%;
		}
		
		.reply_ul > li {
		    float: left;
		    width: 876px;
		    padding: 30px 27px 25px 27px;
		    border-bottom: 1px solid #e3e3e3;
		}
		
		.reply {
		    float: left;
		    width: 100%;
		    height: 100%;
		}
		.bottom_txar_wrap {
		    float: left;
		    margin-top: 40px;
		    width: 100%;
		    height: 205px;
		}
		
		.bottom_txar {
		    height: 203px;
		    background-color: #e8eaee;
		    border: 1px solid #dcdde1;
		}
		
		.bottom_txar .txar {
		    float: left;
		    padding: 20px;
		    width: 868px;
		    height: 90px;
		    margin-top: 10px;
		    margin-left: 10px;
		    background-color: #fff;
		    resize: none;
		    overflow: hidden;
		    overflow-y: auto
		}
		
		.bottom_txar .emoticon_wrap {
		    position: absolute;
		    top: 53px;
		    left: -1px;
		    width: 100%;
		    border: 1px solid #dcdde1;
		}
		
		.bottom_txar .emoticon_knob {
		    position: absolute;
		    top: -8px;
		    left: 30px;
		}
		
		.bottom_txar_btn {
		    position: relative;
		    float: left;
		    margin-top: 11px;
		    width: 100%;
		    height: 42px;
		    line-height: 42px;
		}
		
		.bottom_txar_btn span.emoticon_sum {
		    background-color: #fff;
		    margin-top: 0;
		}
		
		.bottom_txar .txar_right_btn {
		    float: right;
		    margin-right: 9px;
		}
		
		.bottom_txar .emoticon_btn {
		    float: left;
		    margin-top: 8px;
		    margin-left: 26px;
		}
		.btn01_g {
		    min-width: 53px;
		    font-size: 16px;
		    color: #fff !important;
		    ; text-align: center;
		    background-color: #747a86;
		    border-radius: 2px;
		    padding: 9px 14px 9px 14px;
		    border: 1px solid #747a86;
		    display: inline-block;
		    line-height: 1;
		    float: left;
		}
		
		.btn01_g:hover {
		    background-color: #6b717d;
		    border: 1px solid #6b717d;
		}
		.repley_txtarea textarea {
	    height: 62px;
	    float: left;
	    border: 0;
	    width: 95%;
	    padding-left: 5%;
	    padding-top: 10px;
	}
	.btn1{
	float: right;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<div id="container">
		<div class="contents_wrap">
			<h2 class="con_title">
			자유게시판
			<span class="con_title_btn"><a href="list.do" class="back_btn" style="width:56px; text-align:center;">목록</a></span>
			</h2>
			
			<p class="qs_title"><span>제목 : {{info.freeTitle}}</span></p>
				<div class="qs_info_wrap">
					<span class="qs_id">
					작성자 : {{info.uId}}
					</span>
					<div class="qs_info">
						<p>게시글 번호 : {{info.freeNo}}</p>
						<p class="last">{{info.fWriteTime}}</p>
						<span class="report">신고하기</span>
					</div>
				</div>
			
			<div class="qs_text">
				<div><pre v-html="info.freeContent"></pre></div>
			</div>
			
			<div class="qs_empathy_wrap">
			    <div class="empathy_info">
			        <a href="#a" ><img src="https://ssl.nexon.com/s2/game/maplestory/renewal/common/empathy_btn_off.png" alt="공감하기 버튼"></a>
			        <p>
			            <a href="#a"><span class="recomref">0</span>&nbsp;명</a>
			        </p>
			    </div>
			</div>
			
			<div>
				<button @click="fnDel" v-if="uId == info.uId || status == 'A'" class="btn1">삭제하기</button>
				<button @click="fnEdit" v-if="uId == info.uId" class="btn1">수정하기</button>
			</div> 
						<hr>
		<div class="reply_wrap">
				<div class="reply_title">
           			<h2>댓글<span></span></h2>
      		  	</div>  		
      		  	
      		<ul class="reply_ul">
      		<li>
				<div v-for="(item, index) in commentList" class="reply">
					<span> {{item.uId}} {{item.cWriteTime}} </span>
					<br>
					<div style="width : 300px; display: inline-block;">
						{{item.comm}} 
						<a @click="fnRemoveComm(item.cNo)" href="javascript:;" v-if="item.uId == uId || status == 'A'">
							<i class="fa-solid fa-circle-xmark fa-xs"></i>
						</a> 
					</div>
					<br>
				</div>
			
			</li>
			</ul>
			</div>
			<hr>
			<div class="bottom_txar_wrap">
				<div class="bottom_txar ctracker">
					<textarea rows="10" cols="50" v-model="comment" @keyup.enter="fnComment" placeholder="로그인 후, 이용해주세요"></textarea>
					
				<div class="txar_right_btn">
	                <span class="glist_number">(<em>0</em>/200)</span>
	                <button style="vertical-align: middle; margin-bottom: 35px;" @click="fnComment" v-if="status == 'A'||status == 'U'||status == 'H'" class="btn01_g">등록</button>
	            </div>
				
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