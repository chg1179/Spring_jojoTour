<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>

<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
   .pagination {
       margin:24px;
       display: inline-flex;
   }
   ul {
   }
   .pagination li {
      min-width:32px;
      padding:2px 6px;
      text-align:center;
      margin:0 3px;
      border-radius: 6px;
      border:1px solid #eee;
      color:#666;
      display : inline;
   }
   .pagination li:hover {
       background: #E4DBD6;
   }
   .pagination li.active {
       background-color : #E7AA8D;
       color:#fff;
   }
   .pagination li.active a {
       color:#fff;
   }
   *{
	margin: 0;
	padding: 0;
   }
   #rentcar_main_container{
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 30px;
   }
   .rentcar_main_wrap{
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
   }
   .rentcar_main_box{
	width: calc(33.333% - 10px);
	box-sizing: border-box;
	overflow: hidden;
	position: relative;
	margin: 10px 0;
	cursor : pointer;
   }
   .rentcar_main_box img{
	width: 100%;
	height: 300px;
   }
   .rentcar_txt_box{
	background-color: rgba(65, 65, 65, 0.5);
	padding : 10px;
	width: 100%;
	position: absolute;
	bottom: 0;
	left: 0;
	color: #fff;
	opacity : 0;
	transition-duration: .5s;
   }
   .rentcar_main_box:hover .rentcar_txt_box{
	opacity: 1;
   }
    .paginate_box{
	display: flex;
	justify-content: center;
	width: 100%;
   }
   .paginate_box a {
       color:#666;
       text-decoration: none;
       width : 100%;
       height : 100%;
       display : block;
   }

</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="rentcar_main_container">
			<div class="rentcar_main_wrap">
				<div v-for="item in list" class="rentcar_main_box">
					<div class="rentcar_main_img">
						<img :src="item.imgPath" alt="">
					</div>
					<div class="rentcar_txt_box">
						<p class="rent_name">차량명 : {{item.rentName}}</p>
						<P class="rent_kind">차종 : {{item.rentKind}}</P>
						<P class="rent_price">렌트 금액 : {{item.rentPrice}}</P>
						<P class="rent_sale">할인률 : {{item.rentSales}}%</P>
						<P class="rent_update_time">차량 등록 날짜 : {{item.rUpdateTime}}</P>
					</div>
				</div>
				<div class="paginate_box">
					<template>
						<paginate
						:page-count="pageCount"
						:page-range="3"
						:margin-pages="2"
						:click-handler="fnSearch"
						:prev-text="'<'"
						:next-text="'>'"
						:container-class="'pagination'"
						:page-class="'page-item'">
						</paginate>
					</template>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
        selectPage: 1,
        pageCount: 1,
        cnt : 0

	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 10);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "rentCarMain.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
					console.log(self.list);
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 10);
			var lastNum = 9;
			var nparmap = {startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "rentCarMain.dox",
				dataType : "json",
				type : "POST",
				data : nparmap,
				success : function(data) {
					self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
				}
			});
		}
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>