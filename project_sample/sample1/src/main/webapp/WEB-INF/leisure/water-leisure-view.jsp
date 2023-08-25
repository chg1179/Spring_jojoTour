<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>

		body {
			      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
		}
       	#app{
		margin: 20px auto;
	    max-width: 1200px;
	    background-color: #fff;
	    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	    padding: 20px;
	    border-radius: 5px;
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
	<h1 style="color: #213555; text-align: center; margin-top: 40px; margin-bottom: 30px;">레저 상세보기</h1>
		<hr>
		<div class="condiv">
		<img :src="info.imgPath" class="mainimg" style="border-radius: 4px;">
			<span class="linediv">
				<span style="font-size: 30px;">{{info.leisureName}}</span>
				
				<br>
				<span style="color : red; font-size: 20px; padding-left : 10px;">{{100-info.leisureSales*100}}% 
					<span style="color : black;  font-size: 24px;  padding-left : 10px;">{{info.leisurePrice * info.leisureSales}}원</span></span>
				<span style="font-size: 16px; color : grey; text-decoration : line-through;">{{info.leisurePrice}}원</span>
				<br><br><br><br><br>
				<span > 레저 종류 : {{info.cName}}</span>
				<br>
				<span > 위치 : {{info.lAddr}}{{info.lDetailAddr}}</span>
				<br>
				<span > 등록날짜 : {{info.lInsertTime}}</span>
				<br><br><br><br>
				<span v-if="!isWished">
					<a @click="fnWish(info.leisureNo)" href="javascript:;">
						<i class="fa-regular fa-heart fa-bounce fa-2x" style="color: #ff0000;"></i>찜하기
					</a>
				</span>
				<span v-else>
					<a @click="fnDelWish(info.leisureNo)" href="javascript:;">
						<i class="fa-solid fa-heart fa-bounce fa-2x " style="color: #ff0000;"></i>찜해제
					</a>
				</span>
				<span><input type="button" value="장바구니" class="btn" @click="fnCart(info)"></span>
			</span>	
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
		leisureNo : "${map.leisureNo}",
		info : {},
		uId : "${sessionId}",
		isWished:false,
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	self.info.imgPath = "../"+self.info.imgPath; 
                	console.log(self.info);
                }
            }); 
		},
		fnWish : function(leisureNo){
			var self = this;
			var param = {leisureNo : leisureNo, uId:self.uId};
			$.ajax({
                url : "/leisure/jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 목록에 추가되었습니다.");
                	self.isWished=true;
                	self.fnGetList();
                }
    
            });

		},
		fnDelWish : function(leisureNo){
			var self = this;
			var param = {leisureNo : leisureNo, uId:self.uId};
			$.ajax({
                url : "/leisure/jjimDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("찜 목록에서 해제되었습니다.");
                	self.isWished=false;
                	self.fnGetList();
                }
    
            });

		},
		fnCart : function(info){
			var self = this;
			if(self.uId == ""){
				alert("로그인 후 이용 가능한 서비스입니다.");
				return;
			}
			
			var found = self.list.some(function (item) {
		        return item.leisureNo = self.leisureNo;
		    });
		
			if(found){
				if(!confirm("이미 장바구니에 담긴 상품입니다. 장바구니에서 확인하시겠습니까?")){
					alert("취소됨")
					return;
				}else{
					window.location.href = "/cart.do";
		            return;
				}
			}
		  
			if(!confirm("장바구니에 담으시겠습니까?")){
				alert("취소되었습니다.");
				location.reload();
				return;
			}
			
			var param = {leisureNo : self.leisureNo, uId: self.uId}
			$.ajax({
                url : "/leisureAddCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("추가되었습니다");
					location.reload();
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