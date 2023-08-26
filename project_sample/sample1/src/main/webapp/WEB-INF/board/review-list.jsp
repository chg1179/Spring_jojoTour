<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link href="../css/paging-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
   #review_list_wrap{
   	margin-top: 100px;
   }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="review_list_wrap">
			<table>
				<tr>
					<th>No.</th>
					<th>별점</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>등록날짜</th>
				</tr>
				<tr v-for="item in list">
					<th>{{item.rNo}}</th>
					<th style="text-align : left;">
						<div v-if="item.rStar == '1'">☆</div>
						<div v-if="item.rStar == '2'">☆☆</div>
						<div v-if="item.rStar == '3'">☆☆☆</div>
						<div v-if="item.rStar == '4'">☆☆☆☆</div>
						<div v-if="item.rStar == '5'">☆☆☆☆☆</div>
					</th>
					<th><a href="javascript:;" @click="fnRContent(item.rNo)">{{item.rTitle}}</a></th>
					<th>{{item.uId}}</th>
					<th>{{item.rHits}}</th>
					<th>{{item.rWriteTime}}</th>
				</tr>
			</table>
			<div v-if="userId != '' && userId != null"><button @click="fnWrite">후기작성</button></div>
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
		rNo : "",
        selectPage: 1,
        pageCount: 1,
        cnt : 0

	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var startNum = ((self.selectPage-1) * 10);
	        var lastNum = 10;
	        var param = {startNum : startNum, lastNum : lastNum};
			$.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
                    self.cnt = data.cnt;
                    self.pageCount = Math.ceil(self.cnt / 10);

                	console.log(data);
                	if(data.list.length > 0){
                		self.rNo = self.list[0].rNo;
                	}
                }
            }); 
		},
    	fnSearch : function(pageNum){
          var self = this;
          self.selectPage = pageNum;
          var startNum = ((pageNum-1) * 10);
          var lastNum = 10;
          var nparmap = {startNum : startNum, lastNum : lastNum};
          $.ajax({
             url : "list.dox",
             dataType : "json",
             type : "POST",
             data : nparmap,
             success : function(data) {
                self.list = data.list;
                self.cnt = data.cnt;
                self.pageCount = Math.ceil(self.cnt / 10);
             }
          });
        },
		fnRContent : function(rNo){
			$.pageChange("../review/view.do", {rNo : rNo});
		},
		fnWrite : function(){
			var self = this;
			$.pageChange("../review/add.do", {userId : self.userId});
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>