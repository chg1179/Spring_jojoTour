<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>�ֹ���ȣ �� �� ����</title>
<style>
	.order{
		background-color : buttonface;
	}
    .order::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
	#page_order_container{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100vh;
		margin-top: -200px;
	}
	.page_order_booking_box{
		display: flex;
		justify-content: space-around;
		text-align: center;
	}
	.page_order_booking_box{
		border-top: 1px solid;
		border-bottom: 1px solid #ccc;
	}
	.page_order_booking_box>div{
		padding: 0 70px;
	}
	.page_order_booking_box>div:nth-child(2){
		border-right: 1px solid #ccc;
		border-left: 1px solid #ccc;

	}
	.page_order_booking_box div div{
		margin: 20px 0;
	}
	.page_order_booking_box span{
		font-size: 30px;
		font-weight: bold;
	}
	table, tr, th, td{
		border: 1px solid;
		border-collapse: collapse;
	}
	.page_order_wrap table{
		margin-top: 30px;
		text-align: center;
	}
	.page_order_wrap table th, .page_order_wrap table td{
		padding : 5px 20px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="page_order_container">
			<div class="page_order_wrap">
				<h2>���� ����</h2>
				<table>
					<tr>
						<th>�ֹ���ȣ</th>
						<th>��ǰ��ȣ</th>
						<th>������</th>
						<th>��ǰ����</th>
						<th>�ο�</th>
						<th>�ݾ�</th>
						<th>�������</th>
						<th v-if="flg">��ҿ���</th>
					</tr>
					<tr v-for="item in list">
						<td>{{item.orderNo}}</td>
						<td>{{item.productNo}}</td>
						<td>{{item.sReserveDate}}</td>
						<td>{{item.productKind}}</td>
						<td>{{item.people}}��</td>
						<td>{{item.payment}}��</td>
						<td v-if="item.useYnc == 'Y'">���Ϸ�</td>
						<td v-else-if="item.useYnc == 'N'">����Ϸ�</td>
						<td v-else>��ҿϷ�</td>
						<td v-if="item.useYnc == 'N'"><button @click="bookingCancel(item.productNo)">����ϱ�</button></td>
					</tr>
				</table>
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
		orderNo : "${map.orderNo}",
		list : [],
		listAccept : [],
		listCompletion : [],
		listCancel : [],
		userId : "${sessionId}",
		flg : false
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "/order.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.list;
                	self.listAccept = data.listAccept;
                	self.listCompletion = data.listCompletion;
                	self.listCancel = data.listCancel;
                	var i = 0;
                	for(i=0;i<self.list.length;i++){
                		if(self.list[i].useYnc == 'N'){
                			self.flg = true;
                			return;
                		}
                	}
                	if(i == self.list.length){
             			self.flg = false;
             		}
                	console.log(self.list);
                	console.log(self.flg);
                }
            }); 
		},
		bookingCancel : function(productNo){
			var self = this;
			if(!confirm("���� ����Ͻðڽ��ϱ�?")){
				return;
			}
			var param = {userId : self.userId, productNo : productNo};
			$.ajax({
                url : "/bookingCancel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("��ҵǾ����ϴ�.");
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