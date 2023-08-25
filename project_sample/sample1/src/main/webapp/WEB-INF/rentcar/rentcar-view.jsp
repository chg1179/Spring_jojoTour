<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
		#app{
		margin: 20px auto;
	    max-width: 1200px;
	    background-color: #fff;
	    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	    padding: 20px;
	    border-radius: 5px;
		}
		body {
			font-family: 'Jeju Gothic', sans-serif;
			font-weight: lighter;
		}
        .condiv {
        	display: flex; 
    		justify-content: center;
            
        }
        .linediv {
        	display: flex;
        	padding: 20px;
            box-sizing: border-box;
            flex-direction : column;
        }
        
        
		.mainimg {
			width : auto;
			height : 500px;
		}
		.dediv {
			
			 text-align: left;
		}
		.btn {
			color : white;
			width: 400px;
			height : 60px;
			border : 1px solid #213555;
			background: #213555;
			border-radius : 8px;
			font-size: 30px;
		}
		.datebtn{
    color: white;
    width: 40px;
    height: 23px;
    border: 1px solid #213555;
    background: #213555;
    border-radius: 8px;
    font-size: 12px;
		
		}
		    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }
	hr {
	  height: 10px;
	  border: 0;
	  box-shadow: 0 10px 10px -10px #bbb inset;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<h1 style="color: #213555; text-align: center; margin-top: 40px; margin-bottom: 30px;">���� �󼼺���</h1>
			<hr>
			<div class="condiv">
			<p v-for="item in imgList">
				<img :src="item.imgPath" alt="" class="mainimg" style="border-radius: 4px;">
			</p>
			<span class="linediv">
				<span>���� �̸� : {{info.rentName}}</span> 
				<br>
				
				<span style="color : red; font-size: 20px; padding-left : 10px;">{{sales}}%
				<span style="color : black;  font-size: 24px;  padding-left : 10px;">{{info.rentPrice * info.rentSales}}</span></span>
				<span style="font-size: 16px; color : grey; text-decoration : line-through;">{{info.rentPrice}}</span>
				<br><br><br>
				<div class="check-date">
					<div>
						<input type="date" name="checkInDate" v-model="checkInDate"> ~
						<input type="date" name="checkOutDate" v-model="checkOutDate">
						<button @click="fnCheck" class="datebtn" style="cursor: pointer;">�˻�</button>
					</div>
				</div>
				<br>
				<span> ���� ���� : {{info.rentKind}}</span>
				<br>
				<ul>�μ���� :
					<li>{{info.rAddr}}</li>
					<li>{{info.rDetailAddr}}</li>
				</ul>
				<br>
				<span > ��ϳ�¥ : {{info.rInsertTime}}</span>
				<br><br><br><br>
				<span v-if="!isWished">
					<a @click="fnWish(info.rentNo)" href="javascript:;">
						<i class="fa-regular fa-heart fa-bounce fa-2x" style="color: #ff0000;"></i>���ϱ�
					</a>
				</span>
				<span v-else>
					<a @click="fnDelWish(info.rentNo)" href="javascript:;">
						<i class="fa-solid fa-heart fa-bounce fa-2x " style="color: #ff0000;"></i>������
					</a>
				</span>
				<span><input type="button" value="��ٱ���" class="btn" @click="fnCart"></span>
		
			</span>
		</div>
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
		uId : "${sessionId}",
		isWished:false,
		checkInDate : "",
		checkOutDate : ""
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
			var param = {rentNo : rentNo, uId:self.uId};
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ� �߰��Ǿ����ϴ�.");
                	self.isWished=true;
                	self.fnGetList();
                }
    
            });

		},
		fnDelWish : function(rentNo){
			var self = this;
			var param = {rentNo : rentNo, uId:self.uId};
			$.ajax({
                url : "jjimDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ��� �����Ǿ����ϴ�.");
                	self.isWished=false;
                	self.fnGetList();
                }
    
            });

		},
		fnCart : function(){
			var self = this;
			if(self.uId == ""){
				alert("�α��� �� �̿� ������ �����Դϴ�.");
				return;
			}
			if(self.checkInDate == ""){
				alert("���� ��¥�� �������ּ���");
				return;
			}
			if(self.checkOutDate == ""){
				alert("�ݳ� ��¥�� �������ּ���");
				return;
			}
			if(!self.checkInDate || new Date(self.checkInDate) < new Date()){
				alert("��ȿ���� ���� ��¥�Դϴ�. ���� ���� ��¥�� �������ּ���.");
				location.reload();
				return;
			}
			if (new Date(self.checkInDate) > new Date(self.checkOutDate)) {
			    alert("�ݳ� ��¥�� ���� ��¥���� ���� �� �� �����ϴ�. �ٽ� �������ּ���");
			    location.reload();
			    return;
			}
			
			if(!confirm("��ٱ��Ͽ� �����ðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				location.reload();
				return;
			}
			var param = {rentNo : self.rentNo, uId: self.uId,checkInDate : self.checkInDate , checkOutDate : self.checkOutDate}
			$.ajax({
                url : "addRentCar.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
	                	alert("�߰��Ǿ����ϴ�");
						location.reload();
                }
            }); 
		},
		fnCheck:function(){
			alert("Ȯ�εǾ����ϴ�");
		}

	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>