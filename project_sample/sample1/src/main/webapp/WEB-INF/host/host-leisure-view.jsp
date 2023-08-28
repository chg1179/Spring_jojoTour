<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>레저 상세정보 페이지</title>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
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
	.btnbtn{
		text-align: center;
		margin-bottom:50px;
	}
	.container{
		width:1100px;
		background-color:white;
		border-radius:6px;
		box-shadow:1px 1px 2px darkgray;
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
			<h2>레저 상세 정보</h2>
			<table>
				<tr>
					<th>No.</th>
					<td>{{info.leisureNo}}</td>
				</tr>
				<tr>
					<th>분류</th>
					<td>
						<span v-if='info.cType=="WATER"'>수상</span>
						<span v-else-if='info.cType=="GROUND"'>지상</span>
					</td>
				</tr>
				<tr>
					<th>분야</th>
					<td>{{info.cName}}</td>
				</tr>
				<tr>
					<th>레저명</th>
					<td>{{info.leisureName}}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td>{{info.lZipno}}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>{{info.lAddr}}</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td>{{info.lDetailAddr}}</td>
				</tr>
				<tr>
					<th>레저금액</th>
					<td>{{info.leisurePrice}}</td>
				</tr>
				<tr>
					<th>할인적용금액</th>
					<td>{{info.leisurePrice * info.leisureSales}}</td>
				</tr>
				<tr>
					<th>할인율</th>
					<td>{{sales}}%</td>
				</tr>
				<tr>
					<th>판매수량</th>
					<td>{{info.lResidue}}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>{{info.lRead}}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>{{info.lInsertTime}}</td>
				</tr>
				<tr>
					<th>수정일</th>
					<td>{{info.lUpdateTime}}</td>
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
			<div class="btnbtn">
				<span v-if="lCnt == 0">
					<span><button @click="fnUpdate" class="btn-dark">수정</button></span>
					<span><button @click="fnRemove" class="btn-red">삭제</button></span>
				</span>
				<span><button @click="fnBack" class="btn-dark">뒤로가기</button></span>
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
		info : {
			cType : "",
			leisureKind : "",
			leisureName : "",
			lZipno : "",
			lAddr : "",
			lDetailAddr : "",
			lentPrice : "",
			lentSales : "",
			lResidue : "",
			leisureNo : ""
		},
		leisureNo : "${map.leisureNo}",
		lCnt : "${map.lCnt}",
		sales : 0,
		imgList : []
		
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.leisureInfo;
                	self.sales = 100 - (self.info.leisureSales * 100);
                	self.fnGetImgList();
                	console.log(self.info);
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureImgList.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.leisureImgList;
                	// 앞 경로로 상대 경로 수정
                	for(var i=0;i< self.imgList.length;i++){
                		self.imgList[i].imgPath = "../"+self.imgList[i].imgPath; 
                	}
                }
            }); 
		},
		fnUpdate : function(){
			var self = this;
			$.pageChange("edit.do", {leisureNo : self.leisureNo}); 
        },
		fnRemove : function(){
            var self = this;
	        if(!confirm("해당 레저를 삭제하시겠습니까?")){
	        	alert("취소되었습니다.");
	          	return;
	        }
	        
            var param = {leisureNo : self.leisureNo};
            
            $.ajax({
                url : "leisureRemove.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) {
                	alert("해당 레저의 정보가 삭제되었습니다.");
                	location.href = "../leisure.do"; 
                }
            });  
        },
        changeLeisureNo : function(leisureNo){ //라디오박스를 선택할 때 마다 pk 값 변경
        	var self = this;
        	self.leisureNo = leisureNo;
        },
        fnBack : function(){
        	location.href = "../leisure.do"; 
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