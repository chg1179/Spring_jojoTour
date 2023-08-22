<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<script src="../jquery-1.12.4.js"></script>

<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
   .pagination {
       margin:24px;
       display: inline-flex;
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
   .rentcar_main_con{
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 30px;
   }
   .rentcar_main_wrap{
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	width : 1200px;
	position: relative;
	overflow: hidden;
   }
   
	.rentcar_list{
		display: flex;
		justify-content: space-between;
		width: 500px;
		margin: 50px auto;

	}
	.rentcar_list li{
		display: block;
		width: 100px;
		height: 50px;
		line-height: 50px;
	}
	.rentcar_list li input{
		display: none;
	}
	.rentcar_list li label{
		box-sizing: border-box;
		border: 1px solid #ccc;
		width: 100%;
		height: 100%;
		display: block;
		text-align: center;
	}
	.rentcar_list li input:checked + label{
		border: 1px solid black;
		background: linear-gradient(to right, #ff9900, #ff3333);
		color: #fff;
		font-weight: bold;
	}
   .rentcar_main_box{
	width: calc(33.333% - 10px);
	box-sizing: border-box;
	overflow: hidden;
	position: relative;
	margin: 10px 0;
	cursor : pointer;
	border-radius: 30px;
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
   
   	/* �˻���� */
   .rentcar_search_box_wrap{    
   	position: absolute;
    z-index: 99;
    right: 0;
    
   }
   .rentcar_search_box{
	display: flex;
	position: absolute;
	right: -350px;
	transition-duration: 0.2s;
	background-color: #fff;
   }
   /* �ܹ��� ��ư */
   .rentcar_search_ham{
	width: 30px;
	height: 30px;
	position: absolute;
	top: 5px;
	right: 20px;
	transition-duration: 0.2s;
	cursor: pointer;
   }
   .rentcar_search_ham span{
	width: 100%;
	height: 2px;
	background-color: #000;
	display: block;
	position: absolute;
	transition-duration: .2s;
   }
   .rentcar_search_ham span:nth-child(2){
	margin-top: 10px;
   }
   .rentcar_search_ham span:nth-child(3){
	margin-top: 20px;
   }
   #rentcar_search_checkbox{
	display: none;
   }
   #rentcar_search_checkbox:checked ~ .rentcar_search_ham{
	right: 350px;
   }
   #rentcar_search_checkbox:checked ~ .rentcar_search_box{
	right: 0;
   }
   #rentcar_search_checkbox:checked + .rentcar_search_ham span:nth-child(1){
	transform: rotate(45deg);
	margin-top: 10px;
   }
   #rentcar_search_checkbox:checked + .rentcar_search_ham span:nth-child(2){
	opacity: 0;
   }
   #rentcar_search_checkbox:checked + .rentcar_search_ham span:nth-child(3){
	transform: rotate(-45deg);
	margin-top: 10px;
   }
   .rentcar_search_inbox{
	width: 300px;
	padding: 20px;
	border: 1px solid;
   }
   .rentcar_search_name{
	margin-bottom: 20px;
   }
   .rentcar_search_name input{
	width: 200px;
	padding: 5px 20px;
	border-radius: 10px;
	border: 1px solid;
	display: block;
	margin: 0 auto;
   }
   .rentcar_search_price{
	display: flex;
	justify-content: center;
   }
   .rentcar_search_price input{
	width: 40px;
	height: 20px;
	border: 1px solid;
	padding: 0 0 0 2px;
   }
   .rentcar_search_btn{
	margin-top: 20px;
   }
   .rentcar_search_btn button{
	width: 80%;
	display: block;
	margin: 0 auto;
	padding: 5px 10px;
	border-radius: 20px;
	border: none;
	cursor: pointer;
	background: rgb(82, 82, 82);
	transition-duration: 1s;
	color: #fff;
	font-weight: bold;
   }
   .rentcar_search_btn button:hover{
    background: linear-gradient(to right, #ff9900, #ff3333);
   }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="rentcar_main_container">
			<ul class="rentcar_list">
				<li>
					<input v-if='rentKind==""' type="radio" name="rentcar" id="all_rentcar" @input="checkKind('')" checked="checked">
					<input v-else type="radio" name="rentcar" id="all_rentcar" @input="checkKind('')">
					<label class="rentcar_btn" for="all_rentcar">��ü</label>
				</li>
				<li>
					<input v-if='rentKind=="SMALL"' type="radio" name="rentcar" id="s_rentcar" @input="checkKind('SMALL')" checked="checked">
					<input v-else type="radio" name="rentcar" id="s_rentcar" @input="checkKind('SMALL')">
					<label class="rentcar_btn" for="s_rentcar">������</label>
				</li>
				<li>
					<input v-if='rentKind=="MIDDLE"' type="radio" name="rentcar" id="m_rentcar" @input="checkKind('MIDDLE')" checked="checked">
					<input v-else type="radio" name="rentcar" id="m_rentcar" @input="checkKind('MIDDLE')">
					<label class="rentcar_btn" for="m_rentcar">������</label>
				</li>
				<li>
					<input v-if='rentKind=="LARGE"' type="radio" name="rentcar" id="l_rentcar" @input="checkKind('LARGE')" checked="checked">
					<input v-else type="radio" name="rentcar" id="l_rentcar" @input="checkKind('LARGE')">
					<label class="rentcar_btn" for="l_rentcar">������</label>
				</li>
				<li>
					<input v-if='rentKind=="VAN"' type="radio" name="rentcar" id="v_rentcar" @input="checkKind('VAN')" checked="checked">
					<input v-else type="radio" name="rentcar" id="v_rentcar" @input="checkKind('VAN')">
					<label class="rentcar_btn" for="v_rentcar">������</label>
				</li>
			</ul>

			<div class="rentcar_main_con">
				<div class="rentcar_main_wrap">
							<div class="rentcar_search_box_wrap">
				<input type="checkbox" id="rentcar_search_checkbox">
				<label class="rentcar_search_ham" for="rentcar_search_checkbox">
					<span></span>
					<span></span>
					<span></span>
				</label>
				<div class="rentcar_search_box">
					<div class="rentcar_search_inbox">
						<div class="rentcar_search_name"><input type="text" v-model="rentCarKeyword" placeholder="������ �Ǵ� ��" @keyup.enter="fnRentCarSearch"></div>
						<div class="rentcar_search_price">
							<div class="rentcar_search_price_inbox">
								���� : 
								<input type="text" v-model="minPay">���� ~ 
								<input type="text" v-model="maxPay" @keyup.enter="fnRentCarSearch">����
							</div>
						</div>
						<div class="rentcar_search_btn"><button @click="fnRentCarSearch">�˻�</button></div>
					</div>
				</div>
			</div>
					<div v-for="item in list" class="rentcar_main_box" @click="fnRentCarView(item.rentNo)">
						<div class="rentcar_main_img">
							<img :src="item.imgPath" alt="">
						</div>
						<div class="rentcar_txt_box">
							<p class="rent_name">������ : {{item.rentName}}</p>
							<P class="rent_kind">���� : {{item.rentKind}}</P>
							<P class="rent_price">��Ʈ �ݾ� : {{item.rentPrice}}</P>
							<P class="rent_sale">���η� : {{item.rentSales}}%</P>
							<P class="rent_update_time">���� ��� ��¥ : {{item.rUpdateTime}}</P>
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
        cnt : 0,
        rentKind : "${map.rentKind}",
        rentCarKeyword : "",
        minPay : null,
        maxPay : null

	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum, kind : self.rentKind};
			$.ajax({
                url : "rentCarMain.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 9);
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 9);
			var lastNum = 9;
			var nparmap = {startNum : startNum, lastNum : lastNum, rentCarKeyword : self.rentCarKeyword, rentKind : self.rentKind, minPay : self.minPay, maxPay : self.maxPay};
			$.ajax({
				url : "rentCarMain.dox",
				dataType : "json",
				type : "POST",
				data : nparmap,
				success : function(data) {
					self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 9);
				}
			});
		},
		checkRentKind : function(kind){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum, kind : kind};
			$.ajax({
                url : "kindCheck.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	console.log(data);
                	self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 9);
                }
            }); 
		},
		checkKind : function(kind){
			$.pageChange("rentcar.do", {rentKind : kind});
		},
		fnRentCarView : function(rentNo){
			var self = this;
			console.log(rentNo);
			$.pageChange("rentcar/view.do", {rentNo : rentNo});
		},
		fnRentCarSearch : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
            var nparmap = {startNum : startNum, lastNum : lastNum, rentCarKeyword : self.rentCarKeyword, rentKind : self.rentKind, minPay : self.minPay, maxPay : self.maxPay};
            $.ajax({
                url : "rentCarSearchList.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 9);
                }
            }); 
		}
	}, // methods
	created : function() {
		var self = this;
		if(self.rentKind != ""){
			self.checkRentKind(self.rentKind);
		} else{
			self.fnGetList();
		}
	}// created
});
$(document).ready(function(){

});
</script>