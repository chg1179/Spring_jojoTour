<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>List Page</title>
<style>
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
	
	img {
	 margin : 10px auto;
	 width : 250px;
	 height : 250px; 
	}
</style>
</head>
<body>
	<div id="app">
		
			<button @click="fnUser"> ȸ�� ����
				<img src="../img/userlist/userbw.png" alt="ȸ�� ����">
			</button>
			<button @click="fnHost"> ȣ��Ʈ ����
				<img src="../img/userlist/hostbw.png" alt="ȣ��Ʈ ����">
			</button>
		
	</div>
</body>
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
                    // ȸ�� ���� �������� �̵�
                    window.location.href = "/user-list.do";
                },
                fnHost: function() {
                    // ȣ��Ʈ ���� �������� �̵�
                    window.location.href = "/host-list.do";
                }
            },
            created : function() {
        		var self = this;
        		console.log(self.status);
        		if(self.status != 'A'){
        			alert("���� ����");
        			location.href="../main.do";
        		} 
        		self.fnGetList();
        	}// created
        });
    </script>
</body>