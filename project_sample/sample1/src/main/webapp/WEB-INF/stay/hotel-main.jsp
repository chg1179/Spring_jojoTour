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
	
	.filter-wrap {
		float: left;
		display: inline-block;
		position: relative;
		top: 20px;
		width: 250px;
		margin: 0px 30px 0px 30x;
		padding-bottom: 10px;
		border: 1px solid #ccc;
	}
	
	.filter-wrap section, .filter-wrap h3 {
		margin: 0 0 0 24px;
		padding: 27px 0 0 0;
		border-bottom: none;
	}
	
	.filter-wrap, .list-wrap {
		box-sizing: border-box;
	}
	
	.filter-wrap .btn-wrap {
		overflow: hidden;
		position: relative;
		top: auto;
		height: 27px;
		padding: 0 20px;
		border-bottom: none;
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
	
	.list-wrap {
		float: left;
		width: calc(100% - 250px);
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
		width: 1024px !important;
		margin: 0 auto 0 auto;
		padding-bottom: 50px;
	}
	
	#content {
		overflow: hidden;
	}
	
	.stay-info {
		border: 1px solid #ccc;
		margin-bottom: 20px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<%-- <%@ include file="header.jsp" %> --%>
	<div id="app">
		<div class="banner_box">
			<p class="banner_text">숙박</p>
		</div>
		<div id="content" class="sub-wrap">
			<div class="filter-wrap">
				<div>
					<h3 class="filter-header">필터</h3>
				</div>
				<section class="date-wrap">
					<strong>날짜</strong>
				</section>

				<h3>상세조건</h3>
				<div class="btn-wrap">
					<span><button @click="fnReset">초기화</button></span> <span><button
							@click="fnSearch">적용</button></span>
				</div>

				<section>
					<strong>숙소명</strong>
					<div>
						<input type="text" v-model="stayKeyword"
							placeholder="검색 키워드를 입력해주세요">
					</div>
				</section>

				<section>
					<strong>인원</strong> <span> <select v-model="info.peopleMax">
							<option value="">선택하세요</option>
							<option value="1">1명</option>
							<option value="2">2명</option>
							<option value="3">3명</option>
							<option value="4">4명</option>
							<option value="5">5명</option>
							<option value="6">6명</option>
							<option value="7">7명</option>
							<option value="8">8명</option>
							<option value="9">9명</option>
							<option value="10">10명</option>
							<!-- 추후 수정 -->
					</select>
					</span>
				</section>

				<section>

					<div v-for="item in serviceList">
						<label><input type="checkbox" v-model="selectServiceList"
							:value="item.serviceNo">{{item.serviceName}}</label>
					</div>
				</section>
			</div>
			<div class="">
				<div class="stay-type">
					<select v-model="info.stayKind">
						<option value="HOTEL">호텔</option>
						<option value="MOTEL">모텔</option>
						<option value="PENSION">펜션</option>
						<option value="GUEST">게스트하우스</option>
						<option value="CAMPING">캠핑</option>
					</select>
				</div>
				<div class="list-wrap">
					<ul>
						<li v-for="item in list">
							<div class="stay-info">
								<div>
									<a @click="fnDetail(item.stayNo)">호텔이름 : {{item.stayName}}</a>
								</div>
								<div>가격 : {{item.minPrice}}원</div>
								<div>위치 : {{item.sAddr}}</div>
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
		info : {
			stayKind : "",
			peopleMax : 0
		},
		
	},// data
	methods : {
		// 호텔 리스트 
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
			$.pageChange("view.do", {stayNo : stayNo , productKind : "STAY"}); 
		},
		fnReset : function(){
			var self = this;
			location.href = "/stay/hotel.do";
		},
		fnSearch : function(){
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
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
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