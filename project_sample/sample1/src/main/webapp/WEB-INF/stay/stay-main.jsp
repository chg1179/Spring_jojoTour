<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-1.12.4.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<meta charset="EUC-KR">
<title>숙소 페이지</title>
<style>
	* {
		margin: 0;
		padding: 0;
	}
	
	a {
		text-decoration: none;
		color: inherit;
	}
	
	ul, li {
		list-style: none;
	}
	
	img {
		width: 100%;
		height: 100%;
	}
	
	.inner_con {
		width: 1200px;
		margin: 0 auto;
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
	
	/* 필터 스타일 */ 
	.filter-wrap {
		float: left;
		display: inline-block;
		position: relative;
		top: 20px;
		width: 250px;
		margin: 0px 30px 0px 30x;
		padding-bottom: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	
	.filter-wrap , .filter-wrap h3 {
		margin: 0 0 0 24px;
		padding: 20px 0 0 0;
		border-bottom: none;
		
	}
	
	.filter-wrap, .list-wrap {
		box-sizing: border-box;
	}
	
	.filter-wrap strong {
		display: block;
	}
	
	.list-wrap ul {
		display: block;
		margin-block-start: 1em;
		margin-block-end: 1em;
		margin-inline-start: 0px;
		margin-inline-end: 0px;
		padding-inline-start:
	}
	
	.list-wrap, .stay-type {
		float: left;
		width: 600px;
	}
	
	.list-wrap::after {
		content: "";
		display: table;
		clear: both;
	}
	
	ul a:hover {
		text-decoration: underline;
	}
	
	.sub-wrap {
		width: 1024px;
		margin: 0 auto;
		padding-bottom: 50px;
	}
	
	#content {
		overflow: hidden;
	}
	
	.stay-info {
		border: 1px solid #ccc;
		margin-bottom: 20px;
		margin-left: 20px;
	}
	.stay-type {
		margin-left: 10px;
	}
	
	.btn-wrap button {
		margin: 20px;
		padding: 6px;
	}
	
	.service-list {
		margin-top: 30px;
		margin-left: 20px;

	}
	.name-input input {
		margin: 20px;
		padding: 6px;
	}
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<%-- <%@ include file="header.jsp" %> --%>
	<div id="app">
		<div class="banner_box">
			<p v-if="stayKind == ''" class="banner_text">숙소</p>
			<p v-else-if="stayKind == 'HOTEL'" class="banner_text">호텔</p>
			<p v-else-if="stayKind == 'MOTEL'" class="banner_text">모텔</p>
			<p v-else-if="stayKind == 'PENSION'" class="banner_text">펜션</p>
			<p v-else-if="stayKind == 'GUEST'" class="banner_text">게스트하우스</p>
			<p v-else="stayKind == 'CAMPING'" class="banner_text">캠핑</p>
		</div>
		<div id="content" class="sub-wrap">
			<div class="filter-wrap">
				<h3>상세조건</h3>
				<div class="btn-wrap">
					<span><button @click="fnReset">초기화</button></span> 
				</div>

				<div class="stay-name">
					<h3>숙소명</h3>
					<div class="name-input">
						<input type="text" v-model="stayKeyword" placeholder="검색 키워드를 입력해주세요" @input="fnSearch">
					</div>
				</div>

				<div class="service-list">
					<div v-for="item in serviceList">
						<label><input type="checkbox" v-model="selectServiceList" :value="item.serviceNo" @change="fnSearch">{{item.serviceName}}</label>
					</div>
				</div>
			</div>
			<div class="">
				<div class="stay-type">
					<select v-model="stayKind" @change="fnSearch">
						<option value="" selected disabled hidden>::전체::</option>
						<option value="">::전체::</option>
						<option value="HOTEL">호텔</option>
						<option value="MOTEL">모텔</option>
						<option value="PENSION">펜션</option>
						<option value="GUEST">게스트하우스</option>
						<option value="CAMPING">캠핑</option>
					</select>
				</div>
				<div class="list-wrap">
					<ul>	
						<li v-if ="stayKind == ''" v-for="item in list">
							<div class="stay-info">
								<div class="stay-img">
									<img :src="item.imgPath" alt="">
								</div>
								<div class="txt_box">
									<p>
										<a @click="fnDetail(item.stayNo)">{{item.stayName}}</a>
									</p>
									<p>{{item.minPrice}}원</p>
									<p>{{item.sAddr}}</p>
									<button @click="fnJjim(item.stayNo)">찜</button>
								</div>
							</div>
						</li>
						<li v-if ="stayKind == item.stayKind" v-for="item in list">
							<div class="stay-info">
								<div class="stay-img">
									<img :src="item.imgPath" alt="">
								</div>
								<div class="stay_txt_box">
									<p>
										<a @click="fnDetail(item.stayNo)">{{item.stayName}}</a>
									</p>
									<p>{{item.minPrice}}원</p>
									<p>{{item.sAddr}}</p>
									<button @click="fnJjim(item.stayNo)">찜</button>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
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
		imgList : []
	},// data
	methods : {
		// 숙소 리스트 
		fnGetList : function(){
			var self = this;
			var param = {stayKeyword : self.stayKeyword};
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
			if(!confirm("찜목록에 추가하시겠습니까?")){
				alert("취소되었습니다.");
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