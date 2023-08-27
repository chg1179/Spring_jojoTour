<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-1.12.4.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>숙소 페이지</title>
 <link href="https://fonts.googleapis.com/css?family=Nanum+Barun+Gothic" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f2f2f2;
    }
	a{
		text-decoration: none;
		color: red;
	}
	/* 베너 스타일 */
	.banner_box {
		background-image: url(../img/main/main.jpg);
		background-repeat: no-repeat;
		background-size: cover;
		height: 100px;
		padding-top: 50px;
	}
	
	.banner_text {
		text-align: center;
		font-size: 40px;
		font-weight: 400;
		line-height: 32px;
		color: #fff;
		margin-bottom: 30px;
	}
	
	.banner_img {
		display: flex;
		justify-content: center;
		margin-bottom: 50px;
	}
	
	.banner_img>img {
		width: 600px;
	}
	
	.banner_start {
		text-align: center;
		font-weight: 700;
		color: #fff;
		margin-bottom: 30px;
	}
	
	.banner_question {
		width: 200px;
		height: 50px;
		margin: 0 auto;
		display: block;
		background-image: url(../img/main/icon_question.svg);
		background-repeat: no-repeat;
		background-color: #F86F03;
		background-position: 10px;
		border: none;
		color: #fff;
		font-size: 20px;
		cursor: pointer;
	}
	.stay-container {
		display: flex;
		justify-content: center;
		max-width: 1200px;
		margin: 0px auto;
		padding: 20px;
	}
	
	/* 호텔 검색 필터 */
	.filter {
		background-color: #fff;
		padding: 30px;
		border-radius: 5px;
		margin-right: 20px;
		max-width: 300px;
		min-width: 300px;
		height: 1070px;
		width: 100%;
		box-sizing: border-box;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	}
	.filter h2{
		font-size: 20px;
		margin-bottom: 10px;
		color: #333;
	}
	.filter .btn-wrap {
		margin: 0 auto;
	}
	.filter button{
		font-family: 'Jeju Gothic', sans-serif;
		background-color: #213555;
		color : #fff;
		border: none;
		padding: 8px 15px;
		border-radius: 3px;
		cursor : pointer;
		margin-bottom: 20px;
	}
	.filter .service-list label {
		display: flex;	
		align-items: center;
		margin-bottom: 10px;
	}
	.filter .service-list input{
		margin-right: 10px;
		width: 18px;
		height: 18px;
	}
	.filter .service-list{
		margin-top: 15px;
		margin-bottom: 10px;
	}
	.filter .stay-search h4, .filter .service-list h4{
		margin-bottom: 10px;
	}
	.filter .stay-search input{
		width: 90%;
		padding: 8px;
		border: 1px solid #ccc;
		border-radius: 3px;
		margin: 0 auto;
		box-sizing: border-box;
		
	}
	.filter .service-list input[type="checkbox"] {
	    -webkit-appearance: none;
	    -moz-appearance: none;
	    appearance: none;
	    border: 2px solid #ccc;
	    border-radius: 4px;
	    width: 18px;
	    height: 18px;
	    cursor: pointer;
	    transition: background-color 0.3s, border-color 0.3s;
	}
	.filter .service-list input[type="checkbox"]:checked {
	    background-color: #36578c;
	    border-color: #36578c;
	}
	.stay-info {
		display: flex;
		width: 400px;
		flex-direction: column;
		margin-left: 10px;
	}
	 .caption{
		display: inline-block; 
		padding: 2px; 
		border: 1px solid #e31756;
		width: 70px;
		margin-top: 10px;
		margin-bottom: 10px;
		color: #e31756;
		font-size: 14px;
		
	}
	.stay-type select{
		padding: 3px;
		margin-bottom: 20px;
	}
	.stay-list-con{
		width: 700px;
	}
	.stay-list {
		background-color: #fff;
		display: flex;
		align-items: center;
		border-radius: 5px;
		margin-bottom: 20px;
		width: 100%;
		padding: 15px;
		box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	}
	
	.stay-img-box {
		box-sizing: border-box;
		position: relative;
		margin: 10px 0;
		cursor : pointer;
		width: 200px;
		height : 150px;
		
	}
	
	.image-wrapper {
	    width: 100%;
	    height: 100%;
	    overflow: hidden;
	    border-radius: 5px;
	}
	.image-wrapper img {
		width: 100%;
		height : 100%;
		object-fit: cover;
		border-radius: 5px;
		overflow: hidden;
		transform-origin: center center;
   		transition: transform 0.4s ease;
	}
	
	.image-wrapper:hover img {
	    transform: scale(1.1); 
	}
	
	.stay-name {
		font-weight: bold;
		font-size : 22px;
		margin-bottom: 10px;
	}
	
	.stay-price {
		display: flex;
		flex-direction: column;
		text-align: right;
		font-size: 24px;
		margin-top: auto;
		margin-left: auto;
		margin-right: -75px;
		font-weight: bold;
	}
	
	.stay-address {
		font-size: 13px;
		margin-bottom: 10px;
		color: #979797;
	}
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="banner_box">
		<p v-if="stayKind == ''" class="banner_text">숙소</p>
		<p v-else-if="stayKind == 'HOTEL'" class="banner_text">호텔</p>
		<p v-else-if="stayKind == 'MOTEL'" class="banner_text">모텔</p>
		<p v-else-if="stayKind == 'PENSION'" class="banner_text">펜션</p>
		<p v-else-if="stayKind == 'GUEST'" class="banner_text">게스트하우스</p>
		<p v-else class="banner_text">캠핑</p>
	</div>
	<div class="stay-container">
		<div class="filter">
			<h2>상세조건</h2>
            <div class="btn-wrap">
                <span><button @click="fnReset">초기화</button></span> 
            </div>
    
            <div class="stay-search">
                <h4>검색</h4>
                <div class="name-input">
                    <input style="font-family: 'Jeju Gothic', sans-serif;" type="text" v-model="stayKeyword" placeholder="검색 키워드를 입력해주세요" @input="fnSearch">
                </div>
            </div>

            <div class="service-list">
            	<h4>편의시설</h4>
                <div v-for="item in serviceList">
                    <label><input type="checkbox" v-model="selectServiceList" :value="item.serviceNo" @change="fnSearch">{{item.serviceName}}</label>
                </div>
            </div>
		</div>
		<div class="stay-list-con">
			<div class="stay-type">
	            <select style="font-family: 'Jeju Gothic', sans-serif;" v-model="stayKind" @change="fnSearch">
	                <option value="" selected disabled hidden>::전체::</option>
	                <option value="">::전체::</option>
	                <option value="HOTEL">호텔</option>
	                <option value="MOTEL">모텔</option>
	                <option value="PENSION">펜션</option>
	                <option value="GUEST">게스트하우스</option>
	                <option value="CAMPING">캠핑</option>
	            </select>
       		</div>
            <div class="stay-list"  v-if ="stayKind == ''" v-for="item in list">
                <div class="stay-img-box">
				    <a @click="fnDetail(item.stayNo)">
				        <div class="image-wrapper">
				            <img :src="item.imgPath" alt="숙소이미지">
				        </div>
				    </a>
				</div>
                
                <div class="stay-info">
                	<span class="caption">실시간 예약</span>
                   	<p class="stay-name">{{item.stayName}}</p>
                    <p class="stay-address">
	                    {{item.cName}} | {{item.sAddr}}
                    </p>
                     <!-- 찜하기 -->
                    <span v-if="item.jjimcheck > 0">
		               <a @click="fnJjimDel(item.stayNo)" href="javascript:;">
		               	  <!-- 꽉찬하트 -->
		                  <i class="fa-solid fa-heart"></i>	
		               </a>
		            </span>
		            <span v-else-if="item.jjimcheck != 1">
		               <a @click="fnJjim(item.stayNo)" href="javascript:;">
		               	  <!-- 빈하트 -->
		                  <i class="fa-regular fa-heart"></i>
		               </a>
		            </span>
                    <div class="stay-price">
	                    <p>{{item.minPrice}}<span style="font-size:18px; font-weight: normal;">원~</span></p>
	                    <p style="font-weight: normal; font-size:15px; color: #b3b3b3;">(세금/봉사료 포함)</p>
                    </div>
                </div>
               	
            </div>
            <div class="stay-list"  v-if ="stayKind == item.stayKind" v-for="item in list">
                <div class="stay-img-box">
				    <a @click="fnDetail(item.stayNo)">
				        <div class="image-wrapper">
				            <img :src="item.imgPath" alt="숙소이미지">
				        </div>
				    </a>
				</div>
               <div class="stay-info">
                	<span class="caption">실시간 예약</span>
                   	<p class="stay-name">{{item.stayName}}</p>
                    <p class="stay-address">
	                    {{item.cName}} | {{item.sAddr}}
                    </p>
                    <!-- 찜하기 -->
                    <span v-if="item.jjimcheck == 1">
		               <a @click="fnJjim(item.stayNo)" href="javascript:;">
		               	  <!-- 꽉찬하트 -->
		                  <i class="fa-solid fa-heart"></i>	
		                  
		               </a>
		            </span>
		            <span v-else>
		               <a @click="fnJjimDel(item.stayNo)" href="javascript:;">
		               	  <!-- 빈하트 -->
		                  <i class="fa-regular fa-heart"></i>
		               </a>
		            </span>
                    <div class="stay-price">
	                    <p>{{item.minPrice}}<span style="font-size:18px; font-weight: normal;">원~</span></p>
	                    <p style="font-weight: normal; font-size:15px; color: #b3b3b3;">(세금/봉사료 포함)</p>
                    </div>
                </div>
            </div>
             <div v-if="list.length == 0" class="empty-list-placeholder">
		        <!-- 빈 목록용 플레이스홀더 내용 -->
		        결과가 없습니다.
		    </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		serviceList : [],
		list : [],
		selectServiceList : [],
		stayKeyword : "",
		info : {},
		stayKind : "${map.stayKind}",
		uId : "${sessionId}",
		imgList : [],
		
	},// data
	methods : {
		// 숙소 리스트 
		fnGetList : function(){
			var self = this;
			var param = {stayKeyword : self.stayKeyword, uId : self.uId, stayNo : self.stayNo};
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	console.log(self.list);
                	
                	self.serviceList = data.serviceList;
                	console.log(self.serviceList);
                	
                }
            }); 
		},
		fnGetInfo : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "stayView.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.stayInfo;
                }
            }); 
		},
		
		fnDetail : function(stayNo){
			var self = this;
			console.log(stayNo);
			$.pageChange("/stay/view.do", {stayNo : stayNo , productKind : "STAY"}); 
		},
		fnReset : function(){
			var self = this;
			self.stayKeyword = "";
			self.selectServiceList = [];
			self.fnSearch();
		},
		fnSearch : function(){
			var self = this;
			var noServiceList = JSON.stringify(self.selectServiceList);
			var param = {
				stayKeyword : self.stayKeyword,
				selectServiceList : noServiceList
			};
			console.log(self.selectServiceList);
			console.log(self.list);
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                }
            }); 
		},
		fnJjim : function(stayNo){
			var self = this;
			if(self.uId == ""){
				alert("로그인 후 이용 가능한 서비스입니다.");
				return;
			}
			var param = {stayNo : stayNo, uId : self.uId};
			console.log(stayNo);
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 목록에 추가되었습니다.");
                	console.log(stayNo);
                	self.fnGetList();
                }
            }); 
		},
		fnJjimDel : function(stayNo){
			var self = this;
			var param = {stayNo : stayNo, uId : self.uId};
			console.log(stayNo);
			$.ajax({
                url : "jjimDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 해제 되었습니다.");
                	console.log(stayNo);
                	self.fnGetList();
                }
            }); 
		},
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	//	self.fnGetImgList();
	}// created
});


$(document).ready(function(){
    $('.slide_btn').click(function(){
        $('#slide_wrap').animate({
            left: -600
        }, function(){
            $('#slide_wrap').css({left: 0}).find('img').first().appendTo('#slide_wrap');
        });
    });
    function time(){
        auto = setInterval(function(){
            $('.slide_btn').trigger('click');
        },3000);
    }    
    time();
});

</script>