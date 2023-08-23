<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../css/rentcar/rentcar.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
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
					<label class="rentcar_btn" for="all_rentcar">전체</label>
				</li>
				<li>
					<input v-if='rentKind=="SMALL"' type="radio" name="rentcar" id="s_rentcar" @input="checkKind('SMALL')" checked="checked">
					<input v-else type="radio" name="rentcar" id="s_rentcar" @input="checkKind('SMALL')">
					<label class="rentcar_btn" for="s_rentcar">소형차</label>
				</li>
				<li>
					<input v-if='rentKind=="MIDDLE"' type="radio" name="rentcar" id="m_rentcar" @input="checkKind('MIDDLE')" checked="checked">
					<input v-else type="radio" name="rentcar" id="m_rentcar" @input="checkKind('MIDDLE')">
					<label class="rentcar_btn" for="m_rentcar">중형차</label>
				</li>
				<li>
					<input v-if='rentKind=="LARGE"' type="radio" name="rentcar" id="l_rentcar" @input="checkKind('LARGE')" checked="checked">
					<input v-else type="radio" name="rentcar" id="l_rentcar" @input="checkKind('LARGE')">
					<label class="rentcar_btn" for="l_rentcar">대형차</label>
				</li>
				<li>
					<input v-if='rentKind=="VAN"' type="radio" name="rentcar" id="v_rentcar" @input="checkKind('VAN')" checked="checked">
					<input v-else type="radio" name="rentcar" id="v_rentcar" @input="checkKind('VAN')">
					<label class="rentcar_btn" for="v_rentcar">승합차</label>
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
								<div class="rentcar_search_name"><input type="text" v-model="rentCarKeyword" placeholder="차량명 또는 모델" @keyup.enter="fnRentCarSearch"></div>
								<div class="rentcar_search_price">
									<div class="rentcar_search_price_inbox">
										가격 : 
										<input type="text" v-model="minPay">만원 ~ 
										<input type="text" v-model="maxPay" @keyup.enter="fnRentCarSearch">만원
									</div>
								</div>
								<div class="rentcar_search_btn"><button @click="fnRentCarSearch">검색</button></div>
							</div>
						</div>
					</div>
					<div class="rentcar_main_wrap_box">
						<div v-for="item in list" class="rentcar_main_box" @click="fnRentCarView(item.rentNo)">
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
</script>