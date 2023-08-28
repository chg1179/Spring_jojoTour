<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
    *{
        margin: 0;
        padding: 0;
    }
    a{
        text-decoration: none;
        color: inherit;
    }
    #my_page_container{
        float: left;
        margin : 50px;
        border: 1px solid #ccc;
    }
    .my_page_title{
        width: 200px;
        background-color: #213555;
        text-align: center;
        padding: 5px;
        box-sizing: border-box;
        color: #fff;
        font-weight: bold;
        height: 70px;
        font-size: 24px;
        line-height: 60px;
    }
    .my_page_btn_box a{
        display: block;
        width: 200px;
        box-sizing: border-box;
        text-align: left;
        padding: 5px;
        height: 50px;
        line-height: 40px;
        border: 1px solid #ccc;
        font-size: 16px;
        font-weight: 500;
        position: relative;
    }
</style>
</head>
<body>
	<div id="my-page">
		<div id="my_page_container">
            <div class="my_page_title">마이페이지</div>
            <div class="my_page_btn_box">
                <a href="javascript:;" class="page_btn order" @click="fnOrder">예약내역</a>
                <a href="javascript:;" class="page_btn jjim" @click="fnJjimList">찜목록</a>
                <a href="javascript:;" class="page_btn change" @click="fnChange">회원정보 수정</a>
                <a href="javascript:;" class="page_btn point" @click="fnPoint">포인트</a>
                <a href="javascript:;" class="page_btn inquiry" @click="fninquiry">1:1 문의내역</a> 
            </div>
        </div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#my-page',
	data : {
		list : []
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
                	console.log(self.list);
                }
            }); 
		},
		fnOrder : function(){
			location.href="/my/order.do";
		},
		fnChange : function(){
			location.href="/my/change.do";
		},
		fnPoint : function(){
			location.href="/my/point.do";
		},
		fnReview : function(){
			location.href="/my/review.do";
		},
		fninquiry : function(){
			location.href="/my/inquiry.do";
		},
		fnJjimList : function(){
			location.href="/my/jjim.do";
		}
	},
	created : function() {
		var self = this;
		/* self.fnGetList(); */
	}// created
});
</script>