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
pagination {
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
   .page-item a {
       color:#666;
       text-decoration: none;
   }
   .pagination li.active {
       background-color : #E7AA8D;
       color:#fff;
   }
   .pagination li.active a {
       color:#fff;
   }

</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<ul>
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
		<div v-for="item in list">
			<div><img :src="item.imgPath" alt=""></div>
			<div>상품명 : {{item.cName}}</div>
			<div>가격 : {{item.leisurePrice}}</div>
			<div>할인율 : {{item.leisureSales}}</div>
			<div>상품 등록 날짜 : {{item.lInsertTime}}</div>
		</div>
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
        leisureKind : "${map.leisureKind}"

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
			var nparmap = {startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "../water/leisure.dox",
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