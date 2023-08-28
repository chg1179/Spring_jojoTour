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
<link href="../css/leisure/water-leisure.css" rel="stylesheet"/>
<link href="../../css/basic/paging-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>���� ����</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="banner"></div>
		<div id="water_leisure_main_container">
		<div class="water_leisure_list_box">
				<ul class="water_leisure_list">
					<li>
						<input v-if='leisureKind == ""' type="radio" name="waterLeisure" id="all_waterLeisure" @input="checkKind('')" checked="checked">
						<input v-else type="radio" name="waterLeisure" id="all_waterLeisure" @input="checkKind('')">
						<label class="water_leisure_btn" for="all_waterLeisure">��ü</label>
					</li>
					<li><input v-if='leisureKind == "SNORKE"' type="radio" name="waterLeisure" id="snorke" @input="checkKind('SNORKE')" checked="checked">
						<input v-else type="radio" name="waterLeisure" id="snorke" @input="checkKind('SNORKE')">
						<label class="water_leisure_btn" for="snorke">������</label>
					</li>
					<li><input  v-if='leisureKind == "SURFING"' type="radio" name="waterLeisure" id="surfing" @input="checkKind('SURFING')" checked="checked">
						<input  v-else type="radio" name="waterLeisure" id="surfing" @input="checkKind('SURFING')">
						<label class="water_leisure_btn" for="surfing">����</label>
					</li>
					<li><input  v-if='leisureKind == "YACHT"' type="radio" name="waterLeisure" id="yacht" @input="checkKind('YACHT')" checked="checked">
						<input  v-else type="radio" name="waterLeisure" id="yacht" @input="checkKind('YACHT')">
						<label class="water_leisure_btn" for="yacht">��Ʈ</label>
					</li>
					<li><input  v-if='leisureKind == "JETSKI"' type="radio" name="waterLeisure" id="jetski" @input="checkKind('JETSKI')" checked="checked">
						<input  v-else type="radio" name="waterLeisure" id="jetski" @input="checkKind('JETSKI')">
						<label class="water_leisure_btn" for="jetski">��Ʈ��Ű</label>
					</li>
				</ul>
			</div>
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
								<div class="water_leisure_search_button">
									<button @click="fnChange('L_READ')">��ȸ�� ������</button>
									<button @click="fnChange('LEISURE_PRICE')">���� ������</button>
								</div>
								<div class="water_leisure_search_name"><input type="text" v-model="waterKeyword" @keyup.enter="fnWaterSearch()" placeholder="��ǰ��"></div>
								<div class="water_leisure_search_price">
									<div class="water_leisure_search_price_inbox">
										���� : 
										<input type="text" v-model="minPay">���� ~ 
										<input type="text" v-model="maxPay" @keyup.enter="fnWaterSearch()">����
									</div>
								</div>
								<div @click="fnWaterSearch()" class="water_leisure_search_btn"><button>�˻�</button></div>
							</div>
						</div>
					</div>
					<div class="water_leisure_main_wrap_box">
							<div v-if="list.length==0"class="tung_container">
								<div class="tung_wrap">
									<div class="tung_img_box">
										<img src="../img/main/tung.png">
									</div>
									<h2 class="tung_txt">���ǿ� �����ϴ� ��ǰ�� �����ϴ�.</h2>
								</div>
							</div>
						<div v-for="item in list" class="water_leisure_main_box"  @click="fnWaterLeisureView(item.leisureNo)" v-else>
							<div class="water_leisure_main_img">
								<img :src="item.imgPath" alt="">
							</div>
							<div class="water_leisure_txt_box">
								<p class="water_leisure_cnt">��ȸ�� : {{item.lRead}}</p>
								<p class="water_leisure_name">��ǰ�� : <span>{{item.leisureName}}</span></p>
								<p class="water_leisure_kind">���� : {{item.leisureKind}}</p>
								<p class="water_leisure_sale">������ : <span>{{100-(item.leisureSales*100)}}%</span></p>
								<p class="water_leisure_price">��ǰ ���� : <del>{{item.leisurePrice | comma }}��</del></p>
								<p class="water_leisure_last_price">���� ���� : <span>{{item.leisurePrice-item.leisurePrice*(100-(item.leisureSales*100))/100 | comma }}��</span></p>
								<p class="water_leisure_update_time">��ǰ ��� ��¥ : {{item.lInsertTime}}</p>
							</div>
							<div style="margin: 5px; bold; font-size: 16px;">{{item.leisureName}}</div>
							<div style="text-align: center;">
								<hr style=" width:90%; margin:5px auto; background-color: grey; ">
							</div>
							<div style="margin: 10px; color: #ff7a95; font-weight: bold; font-size:18px;">
								{{item.leisurePrice-item.leisurePrice*(100-(item.leisureSales*100))/100 | comma }}��~
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
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.filter('comma', function(value) {
	  if (!value) return '';
	  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	});
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
        selectPage: 1,
        pageCount: 1,
        cnt : 0,
        leisureKind : "${map.leisureKind}",
        waterKeyword : "",
        minPay : null,
        maxPay : null,
        kindChange : ""
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
			var nparmap = {
					startNum : startNum, 
					lastNum : lastNum, 
					waterKeyword : self.waterKeyword, 
					leisureKind : self.leisureKind, 
					minPay : self.minPay, 
					maxPay : self.maxPay, 
					orderKind: self.kindChange
				};
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
		fnWaterSearch : function(orderKind){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var nparmap = {
					startNum : startNum, 
					lastNum : lastNum, 
					waterKeyword : self.waterKeyword, 
					leisureKind : self.leisureKind, 
					minPay : self.minPay, 
					maxPay : self.maxPay, 
					orderKind : orderKind
				};
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
		},
		fnChange : function(kind){
			this.kindChange=kind;
			this.fnWaterSearch(kind);
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
$(document).ready(function(){
    $('.water_leisure_search_button button').click(function(){
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