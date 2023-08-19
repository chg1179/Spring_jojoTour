<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌트카 관리 페이지</title>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
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
	.pagination {
        margin:24px;
        display: inline-flex;
    }
    ul {
    }
    .pagination li {
	    min-width:32px;
	    padding:2px 6px;
	    text-align:center;
	    margin:0 3px;
	    border-radius: 6px;
	    border:1px solid #eee;
	    color:#666;
	    display : inline;
	}
	.pagination li:hover {
	    background: #E4DBD6;
	}
	.page-item a {
	    color:#666;
	    text-decoration: none;
	}
	.pagination li.active {
	    background-color : #E7AA8D;
	    color:#fff;
	}
	.pagination li.active a {
	    color:#fff;
	}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<table>
			<tr>
				<th>선택</th>
				<th>No.</th>
				<th>이름</th>
				<th>분류</th>
				<th>렌트금액</th>
				<th>판매수량</th>
				<th>등록일</th>
				<th>패키지신청</th>
			</tr>
			
			<tr v-for="(item, index) in list">
				<td>
					<input v-if="index==indexNo" type="radio" :value="item.rentNo" @input="changeRentNo(item, index)" name="rentNo" checked="checked">
					<input v-else type="radio" :value="item.rentNo" @input="changeRentNo(item, index)" name="rentNo">
				</td>
				<td>{{item.rentNo}}</td>
				<td>{{item.rentName}}</td>
				<td>{{item.cName}}</td>
				<td>{{item.rentPrice * item.rentSales}}원</td>
				<td>{{item.rResidue}}</td>
				<td>{{item.rInsertTime}}</td>
				<td>
					<span v-if="item.state=='A'">
						<div>신청이 완료되었습니다.</div>
						<div>취소는 1:1 문의를 남겨주세요.</div>
					</span>
					<button v-else-if="item.state=='D'" @click="fnPackDel(item.rentNo)">취소</button>
					<button v-else @click="fnPackAdd(item.rentNo)">신청</button>
				</td>
			</tr>
		</table>
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
		<div>
			<span><button @click="fnAdd">상품등록</button></span>
			<span><button @click="fnView">상세정보열람</button></span>
			<span><button @click="fnRemove">삭제</button></span>
			<span><button @click="fnBack">뒤로가기</button></span>
		</div>
	</div>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		uId : "${sessionId}",
		status : "${sessionStatus}",
		list : [],
		rentNo : "",
		rCnt : "",
		selectPage: 1,
		pageCount: 1,
		cnt : 0,
		indexNo : 0
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 10);
    		var lastNum = 10;
			var param = {uId : self.uId, startNum : startNum, lastNum : lastNum};
			console.log(param);
			$.ajax({
                url : "rentcar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	self.list = data.carList;
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
                	if(data.carList.length > 0){
                		self.rentNo = self.list[0].rentNo; //리스트의 첫 번째 값을 디폴트로 체크하고, 해당 pk 값을 받아온다.
                		self.rCnt = self.list[0].rCnt;
                	}
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 10);
			var lastNum = 10;
			var param = {uId : self.uId, startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "rentcar.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.list = data.carList;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
					
					// 저장된 인덱스 값으로 라디오 버튼 선택
		            if (self.indexNo >= 0 && self.list[self.indexNo]) {
		                self.rentNo = self.list[self.indexNo].rentNo;
		            } else if (self.list.length -1 < self.indexNo) {
		            	//마지막 리스트에 10개 미만의 값이 들어있다면 최상단 값을 선택
		                self.rentNo = self.list[0].rentNo; 
		            }
				}
			});
		},
		fnAdd : function(){
			location.href = "rentcar/edit.do"; 
        },
        fnView : function(){
        	var self = this;
			$.pageChange("rentcar/view.do", {rentNo : self.rentNo, rCnt : self.rCnt}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("해당 렌트카를 삭제하시겠습니까?")){
	        	alert("취소되었습니다.");
	          	return;
	        }
	        
	        //해당 렌트카가 패키지 신청이 되어있다면 삭제 불가능
	        if(self.rCnt != 0){
	        	alert("패키지 신청한 렌트카의 정보는 삭제가 불가능합니다.");
	        	return;
	        }
	        
			var param = {rentNo : self.rentNo};
            $.ajax({
                url : "rentcar/carRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("해당 렌트카의 정보가 삭제되었습니다.");
                	self.fnGetList();
                }
            });
        },
        changeRentNo : function(item, index){ //라디오박스를 선택할 때 마다 pk 값 변경
        	var self = this;
        	self.rentNo = item.rentNo;
        	self.rCnt = item.rCnt;
        	self.indexNo = index; // 인덱스 값을 업데이트
        },
        fnPackAdd : function(rentNo){
			var self = this;
			console.log(rentNo);
			if(!confirm("패키지를 신청하시겠습니까?")){
	        	alert("신청이 취소되었습니다.");
	          	return;
	        }
			var param = {rentNo : rentNo};
			$.ajax({
                url : "rentPackAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("패키지 신청이 완료되었습니다.");
                	self.fnGetList();
                }
			});
        },
        fnPackDel : function(rentNo){
			var self = this;
			if(!confirm("패키지 신청을 취소하시겠습니까?")){
	        	alert("변경이 취소되었습니다.");
	          	return;
	        }
			var param = {rentNo : rentNo};
			$.ajax({
                url : "rentPackDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("패키지 신청이 취소되었습니다.");
                	self.fnGetList();
                }
			});
        },
        fnBack : function(){
        	location.href = "main.do"; 
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>