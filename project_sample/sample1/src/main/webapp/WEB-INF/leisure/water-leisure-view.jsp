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
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
		body {
			font-family: 'Jeju Gothic', sans-serif;
			font-weight: lighter;
		}
        #app {
        	
   			
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
	
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<h1 style="color: #213555; text-align: center; margin-top: 40px; margin-bottom: 30px;">상세보기</h1>
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
				<br><br><br><br><br><br><br><br>
				<span><input type="button" value="장바구니" class="btn" @click="fnCart"></span>
			</span>	
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		leisureNo : "${map.leisureNo}",
		info : {},
		uId : "${sessionId}"
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
		fnCart : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo, uId: self.uId}
			$.ajax({
                url : "/leisureAddCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("장바구니에 추가됨");
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