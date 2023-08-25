<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌터카 상세정보 페이지</title>
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
		<div id="container">
			<table>
				<tr>
					<th>No.</th>
					<td>{{info.rentNo}}</td>
				</tr>
				<tr>
					<th>분류</th>
					<td>{{info.cName}}</td>
				</tr>
				<tr>
					<th>렌터카명</th>
					<td>{{info.rentName}}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>{{info.rZipno}}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>{{info.rAddr}}</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td>{{info.rDetailAddr}}</td>
				</tr>
				<tr>
					<th>렌트금액</th>
					<td>{{info.rentPrice}}</td>
				</tr>
				<tr>
					<th>할인적용금액</th>
					<td>{{info.rentPrice * info.rentSales}}</td>
				</tr>
				<tr>
					<th>할인율</th>
					<td>{{sales}}%</td>
				</tr>
				<tr>
					<th>판매수량</th>
					<td>{{info.rResidue}}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>{{info.rRead}}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>{{info.rInsertTime}}</td>
				</tr>
				<tr>
					<th>수정일</th>
					<td>{{info.rUpdateTime}}</td>
				</tr>
				<tr>
					<th>썸네일 이미지</th>
					<td v-for="(item, index) in imgList" v-if="item.mainYN =='Y'">
						<div>{{item.imgName}}</div>
						<img :src="item.imgPath">
					</td>
					<td v-if="imgList.length == 0"></td>
				</tr>
				<tr>
					<th>상세정보 이미지</th>
					<td v-for="(item, index) in imgList" v-if="item.mainYN =='N'">
						<div>{{item.imgName}}</div>
						<img :src="item.imgPath">
					</td>
					<td v-if="imgList.length == 0"></td>
				</tr>
			</table>
			<div>
				<span v-if="rCnt == 0">
					<span><button @click="fnUpdate">수정</button></span>
					<span><button @click="fnRemove">삭제</button></span>
				</span>
				<span><button @click="fnBack">뒤로가기</button></span>
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
		status : "${sessionStatus}",
		info : {},
		rentNo : "${map.rentNo}",
		rCnt : "${map.rCnt}",
		sales : 0,
		imgList : []
		
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
                	self.fnGetImgList();
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carImgList.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.carImgList;
                	// 앞 경로로 상대 경로 수정
                	for(var i=0;i< self.imgList.length;i++){
                		self.imgList[i].imgPath = "../"+self.imgList[i].imgPath; 
                	}
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			$.pageChange("edit.do", {rentNo : self.rentNo}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("해당 렌터카를 삭제하시겠습니까?")){
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
                	alert("해당 렌터카의 정보가 삭제되었습니다.");
                	location.href = "../rentcar.do"; 
                }
            });  
        },
        changeRentNo : function(rentNo){ //라디오박스를 선택할 때 마다 pk 값 변경
        	var self = this;
        	self.rentNo = rentNo;
        },
        fnBack : function(){
        	location.href = "../rentcar.do"; 
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("호스트만 접근할 수 있습니다.");
			location.href="../../main.do";
		} else {
			self.fnGetInfo();
		}
	}// created
});
</script>