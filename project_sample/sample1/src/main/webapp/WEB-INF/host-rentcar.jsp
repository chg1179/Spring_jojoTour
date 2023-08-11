<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
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
	<div id="app">
		렌트카
		<table>
			<tr>
				<th>선택</th>
				<th>No.</th>
				<th>차 이름</th>
				<th>차 종류</th>
				<th>주소</th>
				<th>상세주소</th>
				<th>렌트 금액</th>
			</tr>		
			
			<tr v-for="item in list">
				<td>
					<input type="radio" v-model="productNo" :value="item.productNo" name="productNo">
				</td>
				<td>{{item.productNo}}</td>
				<td>{{item.productName}}</td>
				<td>{{item.carType}}</td>
				<td>{{item.pAddr}}</td>
				<td>{{item.pDetailAddr}}</td>
				<td>{{item.productPrice}}</td>
			</tr>
		</table>
		<div>
			<span><button>추가</button></span>
			<span><button>수정</button></span>
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
		productNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "rentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.carList;
                }
            }); 
		},
		fnRemove : function(){
            var self = this;
            
            console.log(self.productNo);
	        if(!confirm("해당 렌트카를 삭제하시겠습니까?")){
	        	alert("취소되었습니다.");
	          	return;
	        }
            var param = {productNo : self.productNo};
            
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
		
		
		
        /* $.pageChange("edit.do", {bNo : self.bNo}); */
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>