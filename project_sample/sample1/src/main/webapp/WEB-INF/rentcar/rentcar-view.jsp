<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		차량 상세보기
	<div>
		<p>No : {{info.rentNo}}</p> 
		<p>차량 이름 : {{info.rentName}}</p> 
		<p>차량 종류 : {{info.rentKind}}</p> 
		<p v-for="item in imgList">상세 이미지 : {{item.imgName}}
			<img :src="item.imgPath" alt="">
		</p>
		
		<p>렌트금액 : {{info.rentPrice}} / 할인율 : {{sales}}%</p>
		<p>할인된 가격 : {{info.rentPrice * info.rentSales}}</p> 
		<p>인수장소 : {{info.rAddr}} {{info.rDetailAddr}}</p> 
		
	</div>

		<span v-if="!isWished">
			<a @click="fnWish(info.rentNo)" href="javascript:;">
				<i class="fa-regular fa-heart" style="color: #ff0000;"></i>찜하기
			</a>
		</span>
		<span v-else>
			<a @click="fnDelWish(info.rentNo)" href="javascript:;">
				<i class="fa-solid fa-heart" style="color: #ff0000;"></i>찜해제
			</a>
		</span>

		<span><button>예약하기</button></span>
		<span><button @click="fnBack">뒤로가기</button></span>
	</div>
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
		imgList : [],
		wishlist: [],
		uId : "${sessionId}",
		isWished:false
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "rentCarInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.rentcarinfo;
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
		fnWish : function(rentNo){
			var self = this;
			var param = {rentNo : rentNo, uId:self.uId};
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 목록에 추가되었습니다.");
                	self.isWished=true;
                	self.fnGetList();
                }
    
            });

		},
		fnDelWish : function(rentNo){
			var self = this;
			var param = {rentNo : rentNo, uId:self.uId};
			$.ajax({
                url : "jjimDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 목록에서 해제되었습니다.");
                	self.isWished=false;
                	self.fnGetList();
                }
    
            });

		},
		fnBack : function(){
			var self = this;
			location.href = "../rentcar.do";
		}

	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>