<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌트카 관리 페이지</title>
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
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		렌트카
		<table>
			<tr>
				<th>선택</th>
				<th>No.</th>
				<th>이름</th>
				<th>분류</th>
				<th>렌트금액</th>
				<th>판매수량</th>
				<th>등록일</th>
			</tr>		
			
			<tr v-for="(item, index) in list">
				<td>
					<input v-if="index==0" type="radio" :value="item.rentNo" @input="changeRentNo(item.rentNo)" name="rentNo" checked="checked">
					<input v-else type="radio" :value="item.rentNo" @input="changeRentNo(item.rentNo)" name="rentNo">
				</td>
				<td>{{item.rentNo}}</td>
				<td>{{item.rentName}}</td>
				<td>{{item.cName}}</td>
				<td>{{item.rentPrice}}</td>
				<td>{{item.rResidue}}</td>
				<td>{{item.rInsertTime}}</td>
			</tr>
		</table>
		<div>
			<span><button @click="fnAdd">상품등록</button></span>
			<span><button @click="fnView">상세정보열람</button></span>
			<span><button @click="fnRemove">삭제</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		rentNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "rentcar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.carList;
                	self.rentNo = self.list[0].rentNo; //리스트의 첫 번째 값을 디폴트로 체크하고, 해당 pk 값을 받아온다.
                }
            }); 
		},
		fnAdd : function(){
			location.href = "rentcar/edit.do"; 
        },
        fnView : function(){
        	var self = this;
			$.pageChange("rentcar/view.do", {rentNo : self.rentNo}); 
        },
		fnRemove : function(){
            var self = this;
            console.log(self.rentNo);
	        if(!confirm("해당 렌트카를 삭제하시겠습니까?")){
	        	alert("취소되었습니다.");
	          	return;
	        }
            var param = {rentNo : self.rentNo};
            
            $.ajax({
                url : "carRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("해당 렌트카의 정보가 삭제되었습니다.");
                	self.fnGetList();
                }
            });  
        },
        changeRentNo : function(rentNo){ //라디오박스를 선택할 때 마다 pk 값 변경
        	var self = this;
        	self.rentNo = rentNo;
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>