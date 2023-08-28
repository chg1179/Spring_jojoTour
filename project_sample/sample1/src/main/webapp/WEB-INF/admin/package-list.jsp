<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Package List Page</title>
<link href="../../css/basic/table-style.css" rel="stylesheet"/>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	table {
		margin : 30px auto;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
    	border-radius: 5px;
    	background-color: #f4f4f4;
  	 	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	th {
		 padding : 5px 10px;
		 border: 1px solid #ddd;
		 color : white;
		 background-color: #213555;
	}
	tr {
		border-bottom: 1px solid white;
		padding : 5px 10px;
	}
	td {
		padding : 5px 10px;
		border-left-width: 2px;
		
	}
	td:hover {
	    background-color: #EEEEEE;
	    color : black;
	  }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="adminbar.jsp" flush="true"></jsp:include>
<div id="app">
	<div style="text-align : center; margin: 20px auto;">
		<h1 style="color : #213555; text-align: center; margin: 50px; font-weight : 20;">패키지 목록</h1>
	</div>
	<table style="width: 1400px;">
		<thead>
			<tr> 
				<td colspan="4" style="text-align:left; padding-left: 30px; font-size: 20px; color:#213555;">패키지 리스트</td>
			</tr>
			<tr>	
				<th>번호</th>
				<th>패키지명</th>	
				<th colspan="3">구성</th>
				<th colspan="2">가격</th>
			<tr>
		</thead>
		<tbody v-for="item in list">
			<tr >		
				<td rowspan="3" style="width : 80px">{{item.packageNo}}</td>
					
				<td rowspan="3" style="font-size: 20px;"><a href="javascript:;" @click="fnPackageView">{{item.packageName}}</a></td>
				
				<td style="background-color:#213555; color : white; width: 60px;">숙소</td>
				
				<td style="width : 300px"><a href="javascript:;" @click="fnStayView">{{item.stayName}}</a></td>
				
				<td style="width : 200px"><a href="javascript:;" @click="fnRoomView">{{item.roomName}}</a></td>
				
			   <td style="width: 100px;"> {{item.roomPrice*item.roomSales}}원</td>
			   
			    <td rowspan="3" style="width: 200px; border-left-style:dotted; border-left-color: #f8852a;"><span style="color:#f8852a">TOTAL : 
			    </span>{{ item.roomPrice*item.roomSales + item.leisurePrice*item.leisureSales + item.rentPrice*item.rentSales }}원</td>
			</tr>
			<tr>
				<td style="background-color:#f8852a; color : white;">레저</td>
				<td><a href="javascript:;" @click="fnLeisureView">{{item.leisureName}}</a></td>
				<td>{{item.leisureKind}}</td>
				<td>{{item.leisurePrice*item.leisureSales}}원</td>
			</tr>
			<tr>
				<td style="background-color:#f8852a; color : white;">렌트카</td>
				<td><a href="javascript:;" @click="fnRentView">{{item.rentName}}</a></td>
				<td>{{item.rentKind}}</td>
				<td>{{item.rentPrice*item.rentSales}}원</td>
			</tr>
		</tbody>
	</table>
	
	
</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		status : "${sessionStatus}"
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/packageList.dox",
                dataType:"json",
                type : "POST",
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
                }
            }); 
		},
		fnPackageView : function(){
        	var self = this;
			$.pageChange("../admin/package.do", {packageNo : self.packageNo}); 
        },
        fnStayView : function(){
        	var self = this;
			$.pageChange("../admin/stay.do", {stayNo : self.stayNo}); 
        },
        fnRoomView : function(){
        	var self = this;
			$.pageChange("../admin/room.do", {roomNo : self.roomNo}); 
        },
        fnRentView : function(){
        	var self = this;
			$.pageChange("../admin/rent.do", {rentNo : self.rentNo}); 
        },
        fnLeisureView : function(){
        	var self = this;
			$.pageChange("../admin/leisure.do", {leisureNo : self.leisureNo}); 
        }
	}, // methods
	created : function() {
		var self = this;
		console.log(self.status);
		
		 if(self.status == 'U'){
			alert("권한 없음");
			location.href="../main.do";
		}  
		self.fnGetList();
	}// created
});
</script>