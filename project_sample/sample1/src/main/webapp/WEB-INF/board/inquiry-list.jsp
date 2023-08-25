<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../../css/paging-style.css" rel="stylesheet"/>
<link href="../../css/board-style.css" rel="stylesheet"/>
<link href="../../css/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>1:1 문의 게시판</title>
<style>
	section.inquiry {
	  padding: 80px 0;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<section class="inquiry">
			<div class="page-title">
				<div id="container">
					<h3>1:1 문의 게시판</h3>
				</div>
			</div>
				<div id="board-list">
					<div class="container">
						<table class="board-table">
							<tr class="board-tr">
								<th v-if="status == 'A'" scope="col">선택</th>
								<th scope="col">No.</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">조회수</th>
								<th scope="col">등록 날짜</th>
								<th scope="col">답변 상태</th>
							</tr>
							<tr v-for="(item, index) in list">
								<th v-if="status == 'A'"><input type="checkbox" v-model="selectItem" :value="item.iNo"></th>
								<th>{{item.iNo}}</th>
								<th>
									<a @click="handleTitleClick(item.uId, item.iNo, item.iTitle)" href="javascript:;">		
										{{ item.iTitle }}
									</a>
								</th>
								<th>{{item.uId}}</th>
								<th>{{item.iHits}}</th>
								<th>{{item.iWriteTime}}</th>
								<th>
									<span v-if="item.answerYn=='A'">답변</span>
									<span v-else-if="item.answerYn=='Y'">답변완료</span>
									<span v-else-if="item.answerYn=='N'">답변대기</span>
								</th>
							</tr>
						</table>
						<div class="page-wrap">
							<div>
								<button  v-if="status == 'A'" @click="fnRemove" class="btn1">삭제</button>
								<button  v-if="status == 'A'" @click="fnACheck" class="btn1">전체선택</button>
								<button  v-if="status == 'A'" @click="fnNCheck" class="btn1">전체해제</button>
								<button v-if="status == 'U' || status == 'H'" @click="fnMove" class="btn1">문의하기</button>
							</div>
							
						
							<template>
							  <paginate
							    :page-count="pageCount"
							    :page-range="3"
							    :margin-pages="2"
							    :click-handler="fnSearch"
							    :prev-text="'<'"
							    :next-text="'>'"
							    :container-class="'pagination'"
							    :page-class="'page-item'">
							  </paginate>
							</template>
						</div>
					</div>
				</div>
		</section>
	</div>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}",
		selectItem : [],
		uId : "${sessionId}",
		selectPage: 1,
		pageCount: 1,
		cnt : 0
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 10);
    		var lastNum = 10;
			var param = {startNum : startNum, lastNum : lastNum};
			console.log(param);
			$.ajax({
                url : "/inquiry/list.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.inquiryList;
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 10);
			var lastNum = 10;
			var param = {startNum : startNum, lastNum : lastNum};
			console.log(self.selectPage);
			$.ajax({
				url : "/inquiry/list.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.list = data.inquiryList;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
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
                url : "removeInquiryCheck.dox",
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
		handleTitleClick(uId, iNo, iTitle) {
		    var self = this;
		    if ((self.status === 'A' || self.uId === uId) || iTitle !== '[비밀]') {
		        $.pageChange("view.do", { iNo: iNo });
		    } else {
		        alert("권한 없음");
		    }
		},
		fnNCheck : function(){
			var self = this;
			self.selectItem = [];
		},
		fnACheck : function(){
			var self = this;
			self.selectItem = [];
			for(var i=0; i<self.list.length; i++){
				self.selectItem.push(self.list[i].iNo);
			}
		},
		fnMove : function(){
			var self = this;
 			if (self.status !== 'A' && self.status !== 'U' && self.status !== 'H'){
	            if (confirm("로그인 후 이용해주세요. 로그인 페이지로 이동하시겠습니까?")) {
	                window.location.href = "/login.do";
	            }	    
 			}else{
 				$.pageChange("add.do", { iNo: "", cnt : self.cnt });
 			}
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>