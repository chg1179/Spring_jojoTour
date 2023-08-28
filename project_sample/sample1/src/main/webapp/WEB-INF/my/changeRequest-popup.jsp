<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/board/board-style.css" rel="stylesheet"/>
<link href="../../css/board/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>�䱸���� ����</title>
<style>
	.wrap input, textarea {
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    background: none;
	    width: 78%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 150px;
	    padding: 10px;
	    border-radius: 4px;
	}
	.btn1{
	    
	}
	#container{
	margin-left: 50px;
	}
</style>
</head>
<body>
	<div id="app">
		<div id="container">
		<br>
			<h2><span style="color:#213555">��</span>��û���� ����</h2>
			<br><hr style="width:77%;float:left;"><br>
			<div class="wrap">
				<textarea rows="3" cols="50" v-model="request" maxlength="200" placeholder="��û������ �ִ� ��� �����Ӱ� �Է��� �ּ���."></textarea>
			</div>
			<br>
			<div><input type="button" @click="fnSubmit" value="�����ϱ�" class="btn1"></div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		productKind : "${map.productKind}",
		productNo : "${map.productNo}",
		request : "${map.request}"
	},// data
	methods : {
		fnSubmit : function(){
			var self = this;
			
			if(!confirm("��û������ �����Ͻðڽ��ϱ�?")){
	        	alert("��ҵǾ����ϴ�.");
	          	return;
	        }
			
			var param = {
					productKind : self.productKind,
					productNo : self.productNo,
					request : self.request
				};
			$.ajax({
                url : "/editRequest.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	// ��û���� ������Ʈ �� �˾� â ����
                	alert("������ �Ϸ�Ǿ����ϴ�.");
                	window.close();
                	window.opener.location.reload();
                }
            });
		}
	}, // methods
	created : function() {
	} // created
});
</script>