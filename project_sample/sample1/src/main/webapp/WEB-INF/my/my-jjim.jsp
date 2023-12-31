<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../../css/basic/paging-style.css" rel="stylesheet"/>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../css/my/my-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>찜목록</title>
<style>
	.jjim{
		background-color : buttonface;
	}
    .jjim::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
   *{
	margin: 0;
	padding: 0;
   }
	table {
	  border-collapse: collapse;
	  border-spacing: 0;
	}
	#jjim_container {
		margin-top : 50px;
		display: flex;
		justify-content: center;
		margin-bottom: 231px;
	}
	.jjim_wrap{
	}
	
	.page-title {
	  margin-bottom: 30px;
	}
	.page-title h3 {
	  font-size: 28px;
	  color: #333333;
	  font-weight: 400;
	  text-align: center;
	}
	
	#board-search .search-window {
	  padding: 15px 0;
	  background-color: #f9f7f9;
	}
	#board-search .search-window .search-wrap {
	  position: relative;
	/*   padding-right: 124px; */
	  margin: 0 auto;
	  width: 80%;
	  max-width: 564px;
	}
	#board-search .search-window .search-wrap input {
	  height: 40px;
	  width: 100%;
	  font-size: 14px;
	  padding: 7px 14px;
	  border: 1px solid #ccc;
	}
	#board-search .search-window .search-wrap input:focus {
	  border-color: #333;
	  outline: 0;
	  border-width: 1px;
	}
	#board-search .search-window .search-wrap .btn {
	  position: absolute;
	  right: 0;
	  top: 0;
	  bottom: 0;
	  width: 108px;
	  padding: 0;
	  font-size: 16px;
	}
	
	.board-table {
	  font-size: 13px;
	  width: 100%;
	  border-top: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	}
	
	.board-table a {
	  color: #333;
	  display: inline-block;
	  line-height: 1.4;
	  word-break: break-all;
	  vertical-align: middle;
	}
	.board-table a:hover {
	  text-decoration: underline;
	}
	.board-table th {
	  text-align: center;
	}
	
	.board-table .th-num {
	  width: 100px;
	  text-align: center;
	}
	
	.board-table .th-date {
	  width: 200px;
	}
	
	.board-table th, .board-table td {
	  padding: 14px 0;
	}
	
	.board-table tbody td {
	  border-top: 1px solid #e7e7e7;
	  text-align: center;
	}
	
	.board-table tbody th {
	  padding-left: 28px;
	  padding-right: 14px;
	  border-top: 1px solid #e7e7e7;
	  text-align: left;
	}
	
	.board-table tbody th p{
	  display: none;
	}
	
	.btn-dark {
	  background: #555;
	  color: #fff;
	}
	
	.btn-dark:hover, .btn-dark:focus {
	  background: #373737;
	  border-color: #373737;
	  color: #fff;
	}
	
	.btn-dark {
	  background: #555;
	  color: #fff;
	}
	
	.btn-dark:hover, .btn-dark:focus {
	  background: #373737;
	  border-color: #373737;
	  color: #fff;
	}
	
	/* reset */
	
	* {
	  list-style: none;
	  text-decoration: none;
	  padding: 0;
	  margin: 0;
	  box-sizing: border-box;
	}
	.clearfix:after {
	  content: '';
	  display: block;
	  clear: both;
	}
	.blind {
	  position: absolute;
	  overflow: hidden;
	  clip: rect(0 0 0 0);
	  margin: -1px;
	  width: 1px;
	  height: 1px;
	}
	.page-wrap {
	  text-align: center; /* 수평 가운데 정렬 */
	  margin-top: 20px; /* 필요한 여백 추가 */
	}
	.btn1 {
	  display: inline-block;
	  padding: 8px 16px;;
	  font-size: 12px;
	  font-weight: 400;
	border:1px solid #eee;
	  color: black;
	  border-radius: 5px;
	  cursor: pointer;
	}

	.btn1:hover {
	  background:  #213555;
	  transform: scale(1.05);
	  color: white;
	}
	.btn2 {
	  margin:10px;
	  display: inline-block;
	  padding: 6px 12px;;
	  font-size: 12px;
	  font-weight: 400;
	  border:1px solid #eee;
	  color: black;
	  border-radius: 5px;
	  cursor: pointer;
	}

	.btn2:hover {
	  background: #213555;
	  transform: scale(1.05);
	  color: white;
	}

	.board-tr {
	font-weight: bold;
    background-color: #213555;
	color:white;
	}
	.board-tr td{
		padding: 10px 80px;
	}
	.font1{
	font-size:18px;
	font-weight:bolder;
	}
	.price{
	text-decoration:line-through;
	}
	@media(max-width:1150px){
		.board-tr td{
			padding: 10px 50px;
		}
	}
	@media(max-width:900px){
		.board-tr td{
			padding: 10px 30px;
		}
	}
	@media(max-width:750px){
		.board-tr td{
			padding: 10px 10px;
		}
	}
	.active-btn {
    background-color: #213555;
    color: white;
    transform: scale(1.02);
    
    
  }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
      	<div id="jjim_container">
			<div class="jjim_wrap">
	      	<div class="page-title">
	      		<div class="container">
				<div class="coreTxt"><span class="bar">ㅣ</span> 찜목록</div>
	    		</div>
			</div>
			
    	<div id="board-list">
    		<div class="container">
				<div class="tab-buttons" style="text-align: center;">
				  	<button :class="{ 'active-btn': activeTab === 'STAY' }" @click="setActiveTab('STAY')" class="btn" style="width: 160px;font-size:18px;">숙박</button>
  					<button :class="{ 'active-btn': activeTab === 'RENT' }" @click="setActiveTab('RENT')" class="btn" style="width: 160px;font-size:18px;">렌트카</button>
  					<button :class="{ 'active-btn': activeTab === 'LEISURE' }" @click="setActiveTab('LEISURE')" class="btn" style="width: 160px;font-size:18px;">레저</button>
				</div>
			    <table class="board-table">
			      <tr class="board-tr">
			      	<td scope="col"><input type="checkbox" v-model="selectAll" @change="selectAllItems"></th>
			        <td scope="col">상품정보</th>
			        <td scope="col">찜한제품</th>
			        <td scope="col">할인된 금액</th>
			      </tr>
			      <tr v-for="(item, index) in filteredJjim" :key="index">
			      	<td><input type="checkbox" v-model="selectItem" :value="item.productNo"></td>
			        <td>	          			         
			            <span v-if="item.productKind == 'STAY'">
			            <a @click="fnStayView(item.productNo)" href="javascript:;">
			            	{{item.stayName}}
			            </a>
			            </span>
			            <span v-if="item.productKind == 'RENT'">
			            <a @click="fnRentView(item.productNo)" href="javascript:;"> 
			            	{{item.rentName}}
			            </a>
			            </span>			        
			            <span v-if="item.productKind == 'LEISURE'">
			            <a @click="fnLeisureView(item.productNo)" href="javascript:;"> 
			            	{{item.leisureName}}
			            </a>
			            </span>			       
			        </td>
			        <td>
			          <div v-if="item.productKind == 'STAY'">숙박</div>
			          <div v-if="item.productKind == 'RENT'">렌트카</div>
			          <div v-if="item.productKind == 'LEISURE'">레저</div>
			        </td>
			        <td>
			          <div v-if="item.productKind == 'RENT'">
			          <span class="price">가격 : {{item.rentPrice}}</span>
			          <div class="font1">{{item.rentPrice*item.rentSales}}</div></div>
			          <div v-if="item.productKind == 'STAY'">
			          <span class="price">가격 : {{item.minPrice}}</span>
			          <div class="font1">{{item.minPrice*item.roomSales}}</div></div>
			          <div v-if="item.productKind == 'LEISURE'">
			          <span class="price">가격 : {{item.leisurePrice}}</span>
			          <div class="font1">{{item.leisurePrice*item.leisureSales}}</div></div>
			          <button class="btn2" v-if="item.productKind == 'STAY'" @click="fnStayView(item.productNo)">예약하러가기</button>
			          <button class="btn2" v-if="item.productKind == 'RENT'" @click="fnRentView(item.productNo)">예약하러가기</button>
			          <button class="btn2" v-if="item.productKind == 'LEISURE'" @click="fnLeisureView(item.productNo, item.productKind)">예약하러가기</button>
			        </td>
			      </tr>
			    </table>
				<div class="page-wrap">
					<div> 
						<button @click="fnRemove" class="btn1">삭제하기</button>
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
			</div>
		</div>
		</div>
  		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.component('paginate', VuejsPaginate)
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}",
		jjim:[],
		selectItem : [],
		selectAll: false,
		imgList:[],
		activeTab: 'STAY', // 페이지 로딩시 숙박 탭이 띄워지도록 초기화
		selectPage: 1,
		pageCount: 1,
		cnt : 0
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 9);
    		var lastNum = 9;
			var param = {userId : self.userId,startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "/my/jjim.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                   	self.jjim = data.jjim;
                	self.cnt = data.cnt;
            		self.pageCount = Math.ceil(self.cnt / 10);
                	console.log(self.jjim);
                }
            }); 
		},
		fnSearch : function(pageNum){
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 10);
			var lastNum = 10;
			var param = {userId : self.userId, startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "/my/jjim.dox",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					self.jjim = data.jjim;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 10);
					
				}
			});
		},
		fnRemove : function(){
			var self = this;
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
        	var noList = JSON.stringify(self.selectItem);
			var param = {selectItem : noList};
            $.ajax({
                url : "removeJjimCheck.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) { 
                	self.fnGetList();
                	self.selectItem = [];
                	alert("삭제되었습니다.");

                }
            }); 
		},
		fnRentView : function(rentNo){
				var self = this;
				$.pageChange("/rentcar/view.do", {rentNo : rentNo});
	    },
	    fnStayView : function(stayNo){
		    	var self = this;
		    	console.log(stayNo);
				$.pageChange("/stay/view.do", {stayNo : stayNo});
	    },
	    fnLeisureView : function(leisureNo, productKind){
	    	var self = this;
	    	// 추후 수정 예정
	    	if(productKind == "ATV" || productKind == "CLIDER" || productKind == "HORSE"){
	    		$.pageChange("/ground/leisure/view.do", {leisureNo : leisureNo});
	    	} else{
	    		$.pageChange("/water/leisure/view.do", {leisureNo : leisureNo});	    		
	    	}	
	    },
	    selectAllItems: function() {
			var self = this;
			if (self.selectAll) {
	       		self.selectItem = self.filteredJjim.map(item => item.productNo);
	      	} else {
	        	self.selectItem = [];
	      	}
	    },
	    // 분야 별로 TAB 이동
	    setActiveTab(tab) {
	        var self = this;
	        self.selectAll = false;
	        self.selectItem = [];
	        self.activeTab = tab;
	    }
	}, // methods
	created : function() {
		var self = this;
		self.userId = "${sessionId}";
		self.fnGetList();
	}, // created
	computed: {
		// 제품 목록에 따라 분류
		filteredJjim() {
	    	return this.jjim.filter(item => item.productKind === this.activeTab);
	  	}
	}
});
</script>