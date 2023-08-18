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
	*{
         margin: 0;
         padding: 0;
       }
       a{
           text-decoration: none;
           color: inherit;
       }
       ul, li{
           list-style: none; 
       }
       img{
           width: 100%;
           height: 100%;
       }
       .inner_con{
           width: 1200px;
           margin: 0 auto;
       }
       .banner_box{
           background-image: url(./img/main/main.jpg);
           background-repeat: no-repeat;
           background-size: cover;
           height: 100px;
           padding-top: 50px;
       }
       .banner_text{
           text-align: center;
           font-size: 40px;
           font-weight: 400;
           line-height: 32px;
           color: #fff;
           margin-bottom: 30px;
       }

       .banner_img{
           display: flex;
           justify-content: center;
           margin-bottom: 50px;
       }
       .banner_img>img{
           width: 600px;
       }
       .banner_start{
           text-align: center;
           font-weight: 700;
           color: #fff;
           margin-bottom: 30px;
       }
       .banner_question{
           width: 200px;
           height: 50px;
           margin: 0 auto;
           display: block;
           background-image: url(./img/main/icon_question.svg);
           background-repeat: no-repeat;
           background-color: #F86F03;
           background-position: 10px;
           border: none;
           color: #fff;
           font-size: 20px;
           cursor : pointer;
       }
       .filter-wrap {
       		float: left;
       		display: inline-block;
       		position: relative;
       		top: 40px;
       		width : 200px;
       		margin: 0px 30px 0px 30x;
       		padding-bottom: 10px;
       		border: 1px solid #ccc;
       		
       }
       ul{
       		display: block;
       		margin-block-start : 1em;
       		margin-block-end: 1em;
       		margin-inline-start : 0px;
       		margin-inline-end : 0px;
       		padding-inline-start: 
       }
        
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<%-- <%@ include file="header.jsp" %> --%>
<div id="app">
	<div id="container">
        <div class="banner_box">
            <p class="banner_text">
                숙박
            </p>
        </div>
        <div class="filter-wrap">
	    	<div>
	    		<h3 class="filter-header">필터</h3>
		    </div>
		    <section class="btn-date">
		    	<span class="date-view">
		    		<b>8.18 ~ 8.19</b>
					<em>1박</em>   
				</span> 
		    </section>
		    <div class="btn-wrap">
		    	<span><button>초기화</button></span>
		    	<span><button>적용</button></span>
		    </div>
		    
		    <section>
		    	<strong>숙소명</strong>
		    	<div><input type="text" placeholder="검색 키워드를 입력해주세요"></div>
		    </section>
		    
		    <section>
		    	<strong>인원</strong>
		    	<span>
			    	<select>
			    		<option value="">선택하세요</option>
			    		<option value="1">1명</option> <!-- 추후 수정 -->
			    	</select>
		    	</span>
		    </section>
		    
		    <section>
		    	<div v-for="item in serviceList">
					<label><input type="checkbox" :value="item.serviceNo" v-model="selectServiceList">{{item.serviceName}}</label>
				</div>
		    </section>
    	</div>
    </div>
    <div class="list-wrop">
   		<ul>
   			<a href="">상세페이지로 이동</a>
	    	<li v-for="item in list">
		    	<div class="name">
		    		<div><a href="">{{item.stayName}}</a></div>
				</div>	
			</li>
	    </ul>
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
		selectServiceList : ""
	},// data
	methods : {
		
		// 호텔 리스트 
		fnGetList : function(){
			var self = this;
			var param = {uId : self.uId};
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	console.log(self.list);
                	
                	self.serviceList = data.serviceList;
                	console.log(self.list);
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