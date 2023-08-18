<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Package List Page</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	table {
		margin : 30px auto;
		width : 1400px;
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
		 background-color: #f8852a;
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
<jsp:include page="header.jsp" flush="true"></jsp:include>
<div id="app">
	<div style="text-align : center; margin: 20px auto;">
		<h2 style="color:#F86F03;">패키지 목록</h2>
		<hr style="width: 1000px; margin: 2px auto;">
	</div>
	<table>
		<thead>
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
					
				<td rowspan="3" style="font-size: 20px;">{{item.packageName}}</td>
				
				<td style="background-color:#f8852a; color : white; width: 60px;">숙소</td>
				
				<td style="width : 300px">{{item.stayName}}</td>
				
				<td style="width : 200px">{{item.roomName}}</td>
				
			   <td style="width: 100px;"> {{item.roomPrice}}원</td>
			   
			    <td rowspan="3" style="width: 200px; border-left-style:dotted; border-left-color: #f8852a;"><span style="color:#f8852a">TOTAL : </span>{{ item.roomPrice + item.rentPrice + item.leisurePrice }}원</td>
			</tr>
			<tr>
				<td style="background-color:#f8852a; color : white;">레저</td>
				<td>{{item.leisureName}}</td>
				<td>{{item.leisureKind}}</td>
				<td >{{item.leisurePrice}}원</td>
			</tr>
			<tr>
				<td style="background-color:#f8852a; color : white;">렌트카</td>
				<td>{{item.rentName}}</td>
				<td>{{item.rentKind}}</td>
				<td> {{item.rentPrice}}원</td>
			</tr>
		</tbody>
	</table>
	
	
</div>
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
			$.pageChange("../admin/packagereq.do", {packageNo : self.packageNo}); 
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