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
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		���� �󼼺���
	<div>
		<p>No : {{info.rentNo}}</p> 
		<p>���� �̸� : {{info.rentName}}</p> 
		<p>���� ���� : {{info.rentKind}}</p> 
		<p v-for="item in imgList">�� �̹��� : {{item.imgName}}
			<img :src="item.imgPath" alt="">
		</p>
		
		<p>��Ʈ�ݾ� : {{info.rentPrice}} / ������ : {{sales}}%</p>
		<p>���ε� ���� : {{info.rentPrice * info.rentSales}}</p> 
		<p>�μ���� : {{info.rAddr}} {{info.rDetailAddr}}</p> 
		
	</div>
		<span><button @click="fnWish(info.rentNo)">���ϱ�</button></span>
		<span><button>�����ϱ�</button></span>
		<span><button @click="fnBack">�ڷΰ���</button></span>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		status : "${sessionStatus}",
		info : {},
		rentNo : "${map.rentNo}",
		rCnt : "${map.rCnt}",
		sales : 0,
		imgList : [],
		wishlist: [],
		uId : "${sessionId}"
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "rentCarInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.rentcarinfo;
                	self.sales = 100 - (self.info.rentSales * 100);
                	self.fnGetImgList();
                }
            }); 
		},
		fnGetImgList : function(){
			var self = this;
			var param = {rentNo : self.rentNo};
			$.ajax({
                url : "carImgList.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	self.imgList = data.carImgList;
                	// �� ��η� ��� ��� ����
                	for(var i=0;i< self.imgList.length;i++){
                		self.imgList[i].imgPath = "../"+self.imgList[i].imgPath; 
                	}
                }
            }); 
		},
		fnWish : function(rentNo){
			var self = this;
			if(!confirm("���Ͽ� �߰��Ͻðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				return;
			}
			var param = {rentNo : rentNo, uId:self.uId};
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ� �߰��Ǿ����ϴ�.");
                	console.log(rentNo);
                	self.fnGetList();
                }
    
            });

		},
		fnBack : function(){
			var self = this;
			location.href = "rentcar.do";
		}

	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>