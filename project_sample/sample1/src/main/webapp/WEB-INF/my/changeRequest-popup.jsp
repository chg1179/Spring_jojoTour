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
<title>요구사항 수정</title>
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
			<h2><span style="color:#213555">ㅣ</span>요청사항 수정</h2>
			<br><hr style="width:77%;float:left;"><br>
			<div class="wrap">
				<textarea rows="3" cols="50" v-model="request" maxlength="200" placeholder="요청사항이 있는 경우 자유롭게 입력해 주세요."></textarea>
			</div>
			<br>
			<div><input type="button" @click="fnSubmit" value="수정하기" class="btn1"></div>
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
			
			if(!confirm("요청사항을 수정하시겠습니까?")){
	        	alert("취소되었습니다.");
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
                	// 요청사항 업데이트 후 팝업 창 종료
                	alert("수정이 완료되었습니다.");
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