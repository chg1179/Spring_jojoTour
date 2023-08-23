<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<script src="../js/jquery-1.12.4.js"></script>
<link href="../css/leisure/ground-leisure.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="ground_leisure_main_container">
			<ul class="ground_leisure_list">
				<li>
					<input v-if='leisureKind == ""' type="radio" name="groundLeisure" id="all_groundLeisure" @input="checkKind('')" checked="checked">
					<input v-else type="radio" name="groundLeisure" id="all_groundLeisure" @input="checkKind('')">
					<label class="ground_leisure_btn" for="all_groundLeisure">전체</label>
				</li>
				<li><input v-if='leisureKind == "ATV"' type="radio" name="groundLeisure" id="atv" @input="checkKind('ATV')" checked="checked">
					<input v-else type="radio" name="groundLeisure" id="atv" @input="checkKind('ATV')">
					<label class="ground_leisure_btn" for="atv">ATV</label>
				</li>
				<li><input  v-if='leisureKind == "GLIDER"' type="radio" name="groundLeisure" id="glider" @input="checkKind('GLIDER')" checked="checked">
					<input  v-else type="radio" name="groundLeisure" id="glider" @input="checkKind('GLIDER')">
					<label class="ground_leisure_btn" for="glider">패러글라이딩</label>
				</li>
				<li><input  v-if='leisureKind == "HORSE"' type="radio" name="groundLeisure" id="horse" @input="checkKind('HORSE')" checked="checked">
					<input  v-else type="radio" name="groundLeisure" id="horse" @input="checkKind('HORSE')">
					<label class="ground_leisure_btn" for="horse">승마</label>
				</li>
			</ul>
			<div class="ground_leisure_main_con">
				<div class="ground_leisure_main_wrap">
					<div class="ground_leisure_search_box_wrap">
						<input type="checkbox" id="ground_leisure_search_checkbox">
						<label class="ground_leisure_search_ham" for="ground_leisure_search_checkbox">
							<span></span>
							<span></span>
							<span></span>
						</label>
						<div class="ground_leisure_search_box">
							<div class="ground_leisure_search_inbox">
								<div class="ground_leisure_search_button">
									<button @click="fnGroundSearch('L_READ')">조회수 높은순</button>
									<button @click="fnGroundSearch('LEISURE_PRICE')">가격순</button>
								</div>
								<div class="ground_leisure_search_name"><input type="text" v-model="groundKeyword" @keyup.enter="fnGroundSearch" placeholder="상품명"></div>
								<div class="ground_leisure_search_price">
									<div class="ground_leisure_search_price_inbox">
										가격 : 
										<input type="text" v-model="minPay">만원 ~ 
										<input type="text" v-model="maxPay" @keyup.enter="fnRentCarSearch">만원
									</div>
								</div>
								<div @click="fnGroundSearch" class="ground_leisure_search_btn"><button>검색</button></div>
							</div>
						</div>
					</div>
					<div class="ground_leisure_main_wrap_box">
							<div v-if="list.length==0">
								조건에 충족하는 상품이 없습니다.
							</div>
						<div v-for="item in list" class="ground_leisure_main_box" @click="fnGroundLeisureView(item.leisureNo)" v-else>
							<div class="ground_leisure_main_img">
								<img :src="item.imgPath" alt="">
							</div>
							<div class="ground_leisure_txt_box">
								<p>{{item.leisureName}}</p>
								<p>{{item.leisurePrice}}</p>
								<p>{{item.lResidue}}</p>
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
        leisureKind : "${map.leisureKind}",
        groundKeyword : "",
        minPay : null,
        maxPay : null
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "../ground/leisure.dox",
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
			var nparmap = {startNum : startNum, lastNum : lastNum, groundKeyword : self.groundKeyword, leisureKind : self.leisureKind, minPay : self.minPay, maxPay : self.maxPay};
			$.ajax({
				url : "../ground/leisure.dox",
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
		checkKind : function(kind){
			$.pageChange("../ground/leisure.do", {leisureKind : kind});
		},
		checkGroundKind : function(kind){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum, kind : kind};
			$.ajax({
                url : "../ground/kindCheck.dox",
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
		fnGroundSearch : function(orderKind){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var nparmap = {startNum : startNum, lastNum : lastNum, groundKeyword : self.groundKeyword, leisureKind : self.leisureKind, minPay : self.minPay, maxPay : self.maxPay, orderKind : orderKind};
			 $.ajax({
	                url : "../ground/groundSearchList.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	console.log(data);
	                	self.list = data.list;
						self.cnt = data.cnt;
						self.pageCount = Math.ceil(self.cnt / 9);
	                }
	            }); 
		},
		fnGroundLeisureView : function(leisureNo){
			var self = this;
			$.pageChange("leisure/view.do", {leisureNo : leisureNo});
			
		}
		
	}, // methods
	created : function() {
		var self = this;
		if(self.leisureKind !=""){
			self.checkGroundKind(self.leisureKind);
		} else{
			self.fnGetList();
		}
	}// created
});
$(document).ready(function(){
    $('.ground_leisure_search_button button').click(function(){
        $(this).css({
			color : 'orange',
			fontWeight : 'bold'
        });
		$(this).siblings().css({
			color : 'black',
			fontWeight : 'normal'
        });
    });
});
</script>