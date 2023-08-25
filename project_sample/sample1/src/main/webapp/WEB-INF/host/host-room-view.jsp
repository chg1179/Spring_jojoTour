<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>객실 상세 정보</title>
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
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div>객실 상세정보 페이지</div>
		<table>
			<tr>
				<td>No.</td>
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
					<img :src="imgInfo.imgPath">
				</td>
			</tr>
		</table>
		<div>
			<span><button @click="fnEdit">수정</button></span>
			<span><button @click="fnRemove">삭제</button></span>
			<span><button @click="fnBack">돌아가기</button></span>
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