<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>객실 상세 정보</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	table{
		margin : 30px auto;
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
		font-size : 14px;
		padding:5px 10px;
	}

	th, td {
		border : 1px solid gray;
		padding: 30px 12px;
	}
	th{
		background-color:#f2f2f2;
	}
	h3{
		margin: 50px auto;
		text-align: center;
		margin-bottom: 30px;
	}
	h2{
		margin: 50px auto;
		text-align: center;
		margin-bottom: 30px;
		color:black;
	}
	img {
	  max-width: 600px; /* 최대 너비를 800px로 설정 */
	  height: auto; /* 높이를 자동으로 조절하여 비율 유지 */
	}
	.btnbtn{
		text-align: center;
		margin-bottom:50px;
	}
	.container{
		width:1100px;
		background-color:white;
		border-radius:6px;
		box-shadow:0px 0px 10px rgba(0, 0, 0, 0.2);
		padding: 5px;
	    margin: 50px auto;
	    
	}
	body{
		background-color:#f2f2f2
	}

</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="container">
		<h2>객실 상세정보</h2>
			<table>
				<tr>
					<th>No.</th>
					<td>{{info.roomNo}}</td>
				</tr>
				<tr>
					<th>객실타입</th>
					<td>{{info.roomName}}</td>
				</tr>
				<tr>
					<th>수용인원</th>
					<td>최대 {{info.peopleMax}}명</td>
				</tr>
				<tr>
					<th>객실금액</th>
					<td>{{info.roomPrice}}</td>
				</tr>
				<tr>
					<th>남은객실</th>
					<td>{{info.roomResidue}}</td>
				</tr>
				<tr>
					<th>할인금액</th>
					<td>{{info.roomPrice * info.roomSales}}</td>
				</tr>
				<tr>
					<th>할인율</th>
					<td>{{sales}}%</td>
				</tr>
				<tr>
					<th>판매수량</th>
					<td>{{info.roomResidue}}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>{{info.roomInsertTime}}</td>
				</tr>
				<tr>
					<th>수정일</th>
					<td>{{info.roomUpdateTime}}</td>
				</tr>
				<tr>
					<th>상세정보 이미지</th>
					<td>
						<div>{{imgInfo.imgName}}</div>
						<img :src="imgInfo.imgPath" :style="{ width: '500px'}">
					</td>
				</tr>
			</table>
		
		<div class="btnbtn">
			<span><button @click="fnEdit" class="btn-dark">수정</button></span>
			<span><button @click="fnRemove" class="btn-red">삭제</button></span>
			<span><button @click="fnBack" class="btn-dark">돌아가기</button></span>
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
		info : {},
		roomNo : "${map.roomNo}",
		stayNo : "${map.stayNo}",
		sales : 0,
		discount : 0,
		imgInfo : {}
		
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.roomInfo;
                	console.log(self.info);
              	 	self.sales = 100 - (self.info.roomSales * 100);
              	 	console.log(self.sales);
              	 	self.fnGetImgList();
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomImgInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgInfo = data.imgInfo;
                	console.log(self.imgInfo);
                }
            }); 			
		},
		fnRemove : function(){
			var self = this;
			if(!confirm("해당 객실을 삭제하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomRemove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("삭제되었습니다.");
                	$.pageChange("room.do", {stayNo : self.stayNo});
                }
            }); 
		},
		fnEdit : function(){
			var self = this;
			$.pageChange("roomEdit.do", {roomNo : self.roomNo , stayNo : self.stayNo});
		},
		fnBack : function(){
			var self = this;
			var url = "room.do?stayNo=" + encodeURIComponent(self.stayNo);
		    window.location.href = url;
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetInfo();
	}// created
});
</script>