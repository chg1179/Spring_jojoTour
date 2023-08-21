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
.stay-info{
	margin-bottom: 20px;
}
.sub_wra
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<%-- <%@ include file="header.jsp" %> --%>
	<div id="app">
		<div class="stay-type">
			<select v-model="info.stayKind">
				<option value="HOTEL">호텔</option>
				<option value="MOTEL">모텔</option>
				<option value="PENSION">펜션</option>
				<option value="GUEST">게스트하우스</option>
				<option value="CAMPING">캠핑</option>
			</select>
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
		
	},// data
	methods : {
		// 호텔 리스트 
		fnGetInfo : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "stayInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	console.log(self.list);
                }
            }); 
		},
		
	}, // methods
	created : function() {
		var self = this;
	//	self.fnGetList();
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