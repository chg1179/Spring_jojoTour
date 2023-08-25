<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>List Page</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
	#app {
		margin : 20px auto;
		text-align: center;
	}
	#app button {
		margin : 50px;
		width : 300px;
		height : 300px;
		border : 1px solid #dddddd;
		border-radius : 10px;
		background-color: "#dddddd";
		transition: background-color 0.3s;
	}
	#app button:hover{
		background-color: white;
	}
	
	#thumb {
	 margin : 10px auto;
	 width : 200px;
	 height : 200px; 
	}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="adminbar.jsp" flush="true"></jsp:include>
	<div id="app">
		<h1 style="color : #f8852a; text-align: center; margin-top: 30px; font-weight : 20;">회원 관리</h1>
			<button @click="fnUser"> <div style="font-size : 20px">유저 관리</div>
				<img src="../img/userlist/userbw.png" alt="회원 관리" id="thumb">
			</button>
			<button @click="fnHost"> <div style="font-size : 20px">호스트 관리</div>
				<img src="../img/userlist/hostbw.png" alt="호스트 관리" id="thumb">
			</button>
		
	</div>
</body>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
</html>
<script>
        var app = new Vue({
            el: '#app',
            data : {
        		status : "${sessionStatus}"
        	},// data
            methods: {
            	fnGetList : function(){
        			var self = this;
        			var param = {};
        			$.ajax({
                        url : "list.dox",
                        dataType:"json",	
                        type : "POST",
                        data : param,
                        success : function(data) { 
                        	self.list = data.list;
                        	
                        }
                    }); 
        		},
                fnUser: function() {
                    // 회원 관리 페이지로 이동
                    window.location.href = "/user-list.do";
                },
                fnHost: function() {
                    // 호스트 관리 페이지로 이동
                    window.location.href = "/host-list.do";
                }
            },
            created : function() {
        		var self = this;
        		console.log(self.status);
        		if(self.status != 'A'){
        			alert("권한 없음");
        			location.href="../main.do";
        		} 
        		//self.fnGetList();
        	}// created
        });
    </script>
</body>