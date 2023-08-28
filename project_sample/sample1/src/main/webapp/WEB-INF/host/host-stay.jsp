<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙박 관리 페이지</title>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../../css/basic/paging-style.css" rel="stylesheet"/>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../css/basic/custom-table-style.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	a{
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div>
			<h3>숙박 업체 등록</h3>
		</div>
		<!-- stay list area -->
		<div class="container">
			<table class=" table custom-table table-striped table-bordered ">
				<thead class="thead-dark">
					<tr>
						<th>선택</th>
						<th>No.</th>
						<th>숙소타입</th>
						<th>업체명</th>
						<th>주소</th>
						<th>상세 주소</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(item, index) in list">
						<td>
							<input v-if="index==indexNo" type="radio" :value="item.stayNo" @input="changeStayNo(item.stayNo)" name="stayNo" checked="checked"> 
							<input v-else type="radio" :value="item.stayNo" @input="changeStayNo(item.stayNo)" name="stayNo">
						</td>
						<td>{{item.stayNo}}</td>
						<td>{{item.cName}}</td>
						<td><a @click="fnMove(item.stayNo)" href="javascript:;">{{item.stayName}}</a></td>
						<td>{{item.sAddr}}</td>
						<td>{{item.sDetailAddr}}</td>
						<td>{{item.sInsertTime}}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="container">
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
		<div class="btn-con">
			<span><button @click="fnAdd" class="btn-dark">숙소 등록</button></span> 
			<span><button @click="fnUpdate" class="btn-dark">숙소 정보 수정</button></span> 
			<span><button @click="fnRemove" class="btn-red">숙소 삭제</button></span>
		</div>
		
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
	var app = new Vue({
		el : '#app',
		data : {
			list : [],
			status : "${sessionStatus}",
			uId : "${sessionId}",
			stayNo : "",
			selectPage: 1,
		    pageCount: 1,
		    cnt : 0,
		    indexNo : 0
		},// data
		methods : {
			fnGetList : function() {
				var self = this;
				var startNum = ((self.selectPage-1) * 10);
		        var lastNum = 10;
		        var param = {uId : self.uId, startNum : startNum, lastNum : lastNum};
				console.log(param);
				$.ajax({
					url : "stayList.dox",
					dataType : "json",
					type : "POST",
					data : param,
					success : function(data) {
						self.list = data.stayList;
						self.cnt = data.cnt;
		                self.pageCount = Math.ceil(self.cnt / 10);
						if (self.list.length > 0) {
							self.stayNo = self.list[0].stayNo; //리스트의 첫 번째 값을 디폴트로 체크하고, 해당 pk 값을 받아온다.
							console.log(self.list);
						}
					}
				});
			},
			/* 페이징 추가 */
			fnSearch : function(pageNum){
		         var self = this;
		         self.selectPage = pageNum;
		         var startNum = ((pageNum-1) * 10);
		         var lastNum = 10;
		         var parmap = {uId : self.uId, startNum : startNum, lastNum : lastNum};
		         $.ajax({
		            url : "stayList.dox",
		            dataType : "json",
		            type : "POST",
		            data : parmap,
		            success : function(data) {
		               self.list = data.stayList;
		               self.cnt = data.cnt;
		               self.pageCount = Math.ceil(self.cnt / 10);
		               
			            // 저장된 인덱스 값으로 라디오 버튼 선택
			            if (self.indexNo >= 0 && self.list[self.indexNo]) {
			                self.stayNo = self.list[self.indexNo].stayNo;
			            } else if (self.list.length -1 < self.indexNo) {
			                self.stayNo = self.list[0].stayNo; 
			            }
		            }
		         });
		    },
			fnUpdate : function() {
				var self = this;
				console.log(self.stayNo);
				$.pageChange("stayEdit.do", {stayNo : self.stayNo});
			},
			fnRemove : function() {
				var self = this;
				if (!confirm("해당 숙소를 삭제하시겠습니까?")) {
					alert("취소되었습니다.");
					return;
				}
				var param = {
					stayNo : self.stayNo
				};
				$.ajax({
					url : "stayRemove.dox",
					dataType : "json",
					type : "POST",
					data : param,
					success : function(data) {
						alert("해당 객실이 삭제되었습니다.");
						self.fnGetList();
					}
				});
			},
			fnMove : function(stayNo) {
				var self = this;
				//	console.log(item.stayName);
				$.pageChange("room.do", {
					stayNo : stayNo
				});
			},
			fnAdd : function() {
				location.href = "stayAdd.do"
			},
			changeStayNo : function(stayNo) { //라디오박스를 선택할 때 마다 pk 값 변경
				var self = this;
				self.stayNo = stayNo;
			}

		}, // methods
		created : function() {
			var self = this;
			console.log(self.status);
			if (self.status != 'H') {
				alert("권한 없음");
				location.href = "../main.do";
			}
			/* if (self.uId) {

			} */
			self.fnGetList();
		}// created
	});
</script>