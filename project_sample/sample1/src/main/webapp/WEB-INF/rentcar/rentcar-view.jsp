<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../css/detail-img.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>렌터카 상세 페이지</title>
<style>
	#app{
	margin: 20px auto;
    max-width: 1200px;
    background-color: #fff;
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
    border-radius: 5px;
	}
	body {
		font-family: 'Jeju Gothic', sans-serif;
		font-weight: lighter;
	}
       .condiv {
       	display: flex; 
   		justify-content: center;
           
       }
       .linediv {
       	display: flex;
       	padding: 20px;
           box-sizing: border-box;
           flex-direction : column;
       }
       
       
	.mainimg {
		width : auto;
		height : 500px;
	}
	.dediv {
		
		 text-align: left;
	}
	.btn {
		color : white;
		width: 400px;
		height : 60px;
		border : 1px solid #213555;
		background: #213555;
		border-radius : 8px;
		font-size: 30px;
	}
	.datebtn{
    color: white;
    width: 40px;
    height: 23px;
    border: 1px solid #213555;
    background: #213555;
    border-radius: 8px;
    font-size: 12px;
	}
	body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }
	hr {
	  height: 10px;
	  border: 0;
	  box-shadow: 0 10px 10px -10px #bbb inset;
	}
	

</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h1 style="color: #213555; text-align: center; margin-top: 40px; margin-bottom: 30px;">차량 상세보기</h1>
			<hr>
			<div class="condiv">
			<p v-for="item in imgList">
				<img :src="item.imgPath" alt="" class="mainimg" style="border-radius: 4px;">
			</p>
			<span class="linediv">
				<span>차량 이름 : {{info.rentName}}</span> 
				<br>
				
				<span style="color : red; font-size: 20px; padding-left : 10px;">{{sales}}%
				<span style="color : black;  font-size: 24px;  padding-left : 10px;">{{info.rentPrice * info.rentSales | comma }}</span></span>
				<span style="font-size: 16px; color : grey; text-decoration : line-through;">{{info.rentPrice | comma }}</span>
				<br><br><br>
				<div class="check-date">
					<div>
						<input type="date" name="checkInDate" v-model="checkInDate"> ~
						<input type="date" name="checkOutDate" v-model="checkOutDate">
						<!-- <button @click="fnCheck" class="datebtn" style="cursor: pointer;">검색</button> -->
					</div>
				</div>
				<br>
				<span> 차량 종류 : {{info.rentKind}}</span>
				<br>
				<ul>인수장소 :
					<li>{{info.rAddr}}</li>
					<li>{{info.rDetailAddr}}</li>
				</ul>
				<br>
				<span > 등록날짜 : {{info.rInsertTime}}</span>
				<br><br><br><br>
				<span v-if="!isWished">
					<a @click="fnWish(info.rentNo)" href="javascript:;">
						<i class="fa-regular fa-heart fa-bounce fa-2x" style="color: #ff0000;"></i>
					</a>
				</span>
				<span v-else>
					<a @click="fnDelWish(info.rentNo)" href="javascript:;">
						<i class="fa-solid fa-heart fa-2x " style="color: #ff0000;"></i>
					</a>
				</span>
				<span><input type="button" value="장바구니" class="btn" @click="fnCart"></span>
		
			</span>
		</div>
		<div class="detail_container">
			<div class="detail_wrap">
				<h2>상세 이미지</h2>
				<div class="detail_img_box">
					<img alt="" :src="detailImg.imgPath">
				</div>
				<button class="detail_btn">펼쳐보기</button>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.filter('comma', function(value) {
	  if (!value) return '';
	  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	});
var app = new Vue({
	el : '#app',
	data : {
		uId : "${sessionId}",
		status : "${sessionStatus}",
		info : {},
		rentNo : "${map.rentNo}",
		rCnt : "${map.rCnt}",
		sales : 0,
		imgList : [],
		wishlist: [],
		isWished : false,
		checkInDate : "",
		checkOutDate : "",
		detailImg : ""
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
                	self.detailImg = data.detailImg;
            		self.detailImg.imgPath = "../"+self.detailImg.imgPath;
            		console.log(data.detailImg);
                	self.sales = 100 - (self.info.rentSales * 100);
                	self.fnGetImgList();
                	self.fnCheckHeart(); // 해당 아이디의 찜 목록 체크 후 정보 불러옴
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
		fnCheckHeart : function(){
			var self = this;
			var param = {
				uId : self.uId,
				productKind : "RENT",
				productNo : self.rentNo
			};
			$.ajax({
                url : "../checkHeart.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	// 중복이 있으면 true
                	if(data.jjimCnt > 0){
                		self.isWished = true;
                	}
                }
            }); 
		},
		fnWish : function(rentNo){
			var self = this;
			if(this.uId=="" || this.uId == null){
        		alert("로그인 후 이용이 가능합니다.");
        		location.href="/login.do";
        		return;
        	} 
			var param = {rentNo : rentNo, uId:self.uId};
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.isWished = true;
                	alert("찜 목록에 추가되었습니다.");
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
                	self.isWished = false;
                	alert("찜 목록에서 해제되었습니다.");
                	self.fnGetList();
                }
            });

		},
		fnCart : function(){
			var self = this;
			if(this.uId=="" || this.uId == null){
        		alert("로그인 후 이용이 가능합니다.");
        		location.href="/login.do";
        		return;
        	} 
			
			if(self.checkInDate == ""){
				alert("예약 날짜를 선택해주세요");
				return;
			}
			if(self.checkOutDate == ""){
				alert("반납 날짜를 선택해주세요");
				return;
			}
			if(!self.checkInDate || new Date(self.checkInDate) < new Date()){
				alert("유효하지 않은 날짜입니다. 오늘 이후 날짜를 선택해주세요.");
				location.reload();
				return;
			}
			if (new Date(self.checkInDate) > new Date(self.checkOutDate)) {
			    alert("반납 날짜는 예약 날짜보다 먼저 올 수 없습니다. 다시 선택해주세요");
			    location.reload();
			    return;
			}
			
			if(!confirm("장바구니에 담으시겠습니까?")){
				alert("취소되었습니다.");
				location.reload();
				return;
			}
			var param = {rentNo : self.rentNo, uId: self.uId,checkInDate : self.checkInDate , checkOutDate : self.checkOutDate}
			$.ajax({
                url : "addRentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
	                alert("추가되었습니다");
					location.reload();
                }
            }); 
		},
		fnCheck:function(){
			alert("확인되었습니다");
		}

	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
$(document).ready(function(){
    $('.detail_btn').click(function(){
        var detailWrap = $('.detail_wrap');
        if (detailWrap.css('height') === '400px') {
            detailWrap.css({
                height : 'auto'
            });
            $(this).html('닫기');
        } else {
            detailWrap.css({
                height : '400px'
            });
            $(this).html('펼쳐보기');
        }
    });
});
</script>