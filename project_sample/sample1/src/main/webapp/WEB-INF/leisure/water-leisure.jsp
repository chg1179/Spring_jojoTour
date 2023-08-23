<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../css/leisure/water-leisure.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="water_leisure_main_container">
			<ul class="water_leisure_list">
				<li>
					<input v-if='leisureKind == ""' type="radio" name="waterLeisure" id="all_waterLeisure" @input="checkKind('')" checked="checked">
					<input v-else type="radio" name="waterLeisure" id="all_waterLeisure" @input="checkKind('')">
					<label class="water_leisure_btn" for="all_waterLeisure">전체</label>
				</li>
				<li><input v-if='leisureKind == "SNORKE"' type="radio" name="waterLeisure" id="snorke" @input="checkKind('SNORKE')" checked="checked">
					<input v-else type="radio" name="waterLeisure" id="snorke" @input="checkKind('SNORKE')">
					<label class="water_leisure_btn" for="snorke">스노쿨링</label>
				</li>
				<li><input  v-if='leisureKind == "SURFING"' type="radio" name="waterLeisure" id="surfing" @input="checkKind('SURFING')" checked="checked">
					<input  v-else type="radio" name="waterLeisure" id="surfing" @input="checkKind('SURFING')">
					<label class="water_leisure_btn" for="surfing">서핑</label>
				</li>
				<li><input  v-if='leisureKind == "YACHT"' type="radio" name="waterLeisure" id="yacht" @input="checkKind('YACHT')" checked="checked">
					<input  v-else type="radio" name="waterLeisure" id="yacht" @input="checkKind('YACHT')">
					<label class="water_leisure_btn" for="yacht">요트</label>
				</li>
				<li><input  v-if='leisureKind == "JETSKI"' type="radio" name="waterLeisure" id="jetski" @input="checkKind('JETSKI')" checked="checked">
					<input  v-else type="radio" name="waterLeisure" id="jetski" @input="checkKind('JETSKI')">
					<label class="water_leisure_btn" for="jetski">제트스키</label>
				</li>
			</ul>
			<div class="water_leisure_main_con">
				<div class="water_leisure_main_wrap">

					<div class="water_leisure_search_box_wrap">
						<input type="checkbox" id="water_leisure_search_checkbox">
						<label class="water_leisure_search_ham" for="water_leisure_search_checkbox">
							<span></span>
							<span></span>
							<span></span>
						</label>
						<div class="water_leisure_search_box">
							<div class="water_leisure_search_inbox">
								<div class="water_leisure_search_name"><input type="text" v-model="waterKeyword" @keyup.enter="fnWaterSearch" placeholder="상품명"></div>
								<div @click="fnWaterSearch" class="water_leisure_search_btn"><button>검색</button></div>
							</div>
						</div>
					</div>
					<div class="water_leisure_main_wrap_box">
						<div v-for="item in list" class="water_leisure_main_box"  @click="fnWaterLeisureView(item.leisureNo)">
							<div class="water_leisure_main_img">
								<img :src="item.imgPath" alt="">
							</div>
							<div class="water_leisure_txt_box">
								<p>상품명 : {{item.leisureName}}</p>
								<p>종류 : {{item.leisureKind}}</p>
								<p>가격 : {{item.leisurePrice}}</p>
								<p>할인율 : {{item.leisureSales}}</p>
								<p>상품 등록 날짜 : {{item.lInsertTime}}</p>
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
        waterKeyword : ""

	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "../water/leisure.dox",
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
			var nparmap = {startNum : startNum, lastNum : lastNum, waterKeyword : self.waterKeyword, leisureKind : self.leisureKind};
			$.ajax({
				url : "../water/waterSearchList.dox",
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
			$.pageChange("../water/leisure.do", {leisureKind : kind});
		},
		checkWaterKind : function(kind){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {startNum : startNum, lastNum : lastNum, kind : kind};
			$.ajax({
                url : "../water/kindCheck.dox",
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
		fnWaterSearch : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var nparmap = {startNum : startNum, lastNum : lastNum, waterKeyword : self.waterKeyword, leisureKind : self.leisureKind};
            $.ajax({
                url : "/water/waterSearchList.dox",
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
		fnWaterLeisureView : function(leisureNo){
			var self = this;
			console.log(leisureNo);
			$.pageChange("leisure/view.do", {leisureNo : leisureNo});
		}
		
	}, // methods
	created : function() {
		var self = this;
		if(self.leisureKind !=""){
			self.checkWaterKind(self.leisureKind);
		} else{
			self.fnGetList();
		}
	}// created
});
</script>