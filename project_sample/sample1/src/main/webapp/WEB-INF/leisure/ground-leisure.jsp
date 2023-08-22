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
		<div>
			<div>상품명 : <input type="text" v-model="groundKeyword" @keyup.enter="fnGroundSearch"></div>
			<div @click="fnGroundSearch"><button>검색</button></div>
		</div>
		<div v-for="item in list">
			<div><img :src="item.imgPath" alt=""></div>
			<div>{{item.leisureName}}</div>
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
        leisureKind : "${map.leisureKind}",
        groundKeyword : ""
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
			var nparmap = {startNum : startNum, lastNum : lastNum};
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
		fnGroundSearch : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var nparmap = {startNum : startNum, lastNum : lastNum, groundKeyword : self.groundKeyword, leisureKind : self.leisureKind};
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
</script>