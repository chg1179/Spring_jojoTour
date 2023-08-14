<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌트카 상세정보 페이지</title>
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
		<div>No.</div>
		<table>
			<tr>
				<th>No.</th>
				<th>{{info.rentNo}}</th>
			</tr>
			<tr>
				<th>이름</th>
				<th>{{info.rentName}}</th>
			</tr>
			<tr>
				<th>분류</th>
				<th>{{info.cName}}</th>
			</tr>
			<tr>
				<th>우편번호</th>
				<th>{{info.rZipno}}</th>
			</tr>
			<tr>
				<th>주소</th>
				<th>{{info.rAddr}}</th>
			</tr>
			<tr>
				<th>상세주소</th>
				<th>{{info.rDetailAddr}}</th>
			</tr>
			<tr>
				<th>렌트금액</th>
				<th>{{info.rentPrice}}</th>
			</tr>
			<tr>
				<th>할인금액</th>
				<th>{{info.rentPrice * info.rentSales}}</th>
			</tr>
			<tr>
				<th>할인율</th>
				<th>{{sales}}%</th>
			</tr>
			<tr>
				<th>판매수량</th>
				<th>{{info.rResidue}}</th>
			</tr>
			<tr>
				<th>조회수</th>
				<th>{{info.rRead}}</th>
			</tr>
			<tr>
				<th>등록일</th>
				<th>{{info.rInsertTime}}</th>
			</tr>
			<tr>
				<th>수정일</th>
				<th>{{info.rUpdateTime}}</th>
			</tr>
		</table>
		<div>
			<span><button @click="fnUpdate">상세정보열람</button></span>
			<span><button @click="fnRemove">삭제</button></span>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		info : {},
		rentNo : "${map.rentNo}",
		sales : 0,
		discount : 0 
		
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.carInfo;
                	self.sales = 100 - (self.info.rentSales * 100);
                }
            }); 
		},
		fnUpdate : function(){
			$.pageChange("rentcar/edit.do", {rentNo : self.rentNo}); 
        },
		fnRemove : function(){
            var self = this;
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
                	location.href = "../rentcar.do"; 
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
		self.fnGetInfo();
	}// created
});
</script>