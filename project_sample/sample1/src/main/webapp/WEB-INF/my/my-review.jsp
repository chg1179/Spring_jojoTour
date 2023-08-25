<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.review{
		background-color : buttonface;
	}
    .review::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<h2>���� �̿��ı� {{reviewCnt}}��</h2>
		<table>
			<tr>
				<th></th>
				<th>��ȣ</th>
				<th>���̵�</th>
				<th>ī�װ�</th>
				<th>����</th>
				<th>�ۼ���¥</th>
				<th>������¥</th>
				<th>����</th>
				<th>��ȸ��</th>
				<th>��õ��</th>
			</tr>
			<tr v-for="(item, index) in list" v-if="item.delyn == 'N'">
				<td>
					<input v-if="index == 0" type="radio" :value="item.rNo" @input="changeRNo(item)" name="rNo" checked="checked">
					<input v-else type="radio" :value="item.rNo" @input="changeRNo(item)" name="rNo">
				</td>
				<td>{{index+1}}</td>
				<td>{{userId}}</td>
				<td>
					<div v-if="item.productKind == 'STAY'">����</div>
					<div v-else-if="item.productKind == 'RENT'">��Ʈī</div>
					<div v-else>����</div>


				</td>
				<td><div v-html="item.rContent"></div></td>
				<td>{{item.rWriteTime}}</td>
				<td>{{item.rUpdateTime}}</td>
				<td>{{item.rStar}}</td>
				<td>{{item.rHits}}</td>
				<td>{{item.recommend}}</td>
			</tr>
		</table>
		<button @click="fnEdit">�����ϱ�</button>
		<button @click="fnRemove">�����ϱ�</button>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}",
		reviewCnt : "",
		rNo : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "userReview.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
                	self.reviewCnt = data.reviewCnt;
                	console.log(data.list.length);
                	console.log(self.list);
                	if(data.list.length > 0){
                		self.rNo = self.list[0].rNo;
                	}
                }
            }); 
		},
		changeRNo : function(item){
			var self = this;
			self.rNo = item.rNo;
			console.log(item);
		},
		fnRemove : function(){
			var self = this;
			if(!confirm("���� �����Ͻðڽ��ϱ�?")){
				return;
			}
			var param = {rNo : self.rNo};
			$.ajax({
                url : "r_remove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("���� �Ǿ����ϴ�.");
                	self.fnGetList();
                }
            });
		},
		fnEdit : function(){
			var self = this;
			$.pageChange("/review/edit.do", {rNo : self.rNo});
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>