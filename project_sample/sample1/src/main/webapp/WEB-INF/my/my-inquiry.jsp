<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../css/my/my-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title></title>
<style>
	.inquiry{
		background-color : buttonface;
	}
    .inquiry::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right : 0;
      }
	  *{
		margin: 0;
		padding: 0;
	  }
	  #inquiry_container{
		display: flex;
	    justify-content: center;
	    margin-top: 50px;
	    margin-bottom: 368px;
	  }
	  .inquiry_wrap table, .inquiry_wrap tr, .inquiry_wrap th, .inquiry_wrap td{
		border-collapse: collapse;
	  }
	  .inquiry_wrap th, .inquiry_wrap td{
		border-bottom: 1px solid #ccc;
		border-top: 1px solid #ccc;
		padding: 10px 20px;
		text-align: center;
	  }
	  .inquiry_btn{
		display: flex;
		align-items: center;
		justify-content: center;
		margin-top: 20px;
	  }
	  .inquiry_btn button{
		padding: 10px 40px;
		background-color: #505050;
		cursor: pointer;
		color: #fff;
		font-weight: bold;
		border: none;
		transition-duration: 0.5s;
	  }
	  .inquiry_btn button:hover{
        background-color: #213555;
	  }
	  .inquiry_th_title{
		width: 300px;
	  }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="inquiry_container">
			<div class="inquiry_wrap">
				<div class="coreTxt"><span class="bar">ㅣ</span> 1:1 문의 내역</div>
				<table>
					<tr>
						<!-- <th>선택</th> -->
						<th>게시글 번호</th>
						<th class="inquiry_th_title">제목</th>
						<th>조회수</th>
						<th>등록날짜</th>
					</tr>
					<tr v-for="(item, index) in list" v-if="item.delyn =='N'">
						<!-- <td>
							<input v-if="index == 0" type="radio" :value="item.iNo" @input="changeINo(item)" name="iNo" checked="checked">
							<input v-else type="radio" :value="item.iNo" @input="fnIContent(item)" name="iNo">
						</td> -->
						<td>{{item.iNo}}</td>
						<td><a href="javascript:;" @click="fnIContent(item.iNo)">{{item.iTitle}}</a></td>
						<td>{{item.iHits}}</td>
						<td>{{item.iWriteTime}}</td>
					</tr>
				</table>
				<!-- <div class="inquiry_btn">
					<button @click="fnRemove">삭제하기</button>
				</div> -->
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "inquiry.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) {
                	self.list = data.list;
                	console.log(self.list);
                }
            }); 
		},
		fnIContent : function(iNo){
			var self = this;
			$.pageChange("../inquiry/view.do", {iNo : iNo, uId : self.userId});
		},
		changeINo : function(item){
			var self = this;
			self.iNo = item.iNo;
		},
		fnRemove : function(){
			var self = this;
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			var param = {iNo : self.iNo};
			$.ajax({
                url : "i_remove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("삭제 되었습니다.");
                	self.fnGetList();
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