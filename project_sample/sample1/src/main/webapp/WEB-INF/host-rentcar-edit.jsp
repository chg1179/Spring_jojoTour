<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>렌트카 제품 추가 및 수정 페이지</title>
<style>
</style>
</head>
<body>
	<div id="app">
		<div>
			<!-- <input type="text" hidden/>
			<input class="txt_input" type="text" v-model="productNo" id="pNo" disabled>
			<label class="li_label" for="pNo">제품 번호</label> -->
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		info : {},
		productNo : "${map.productNo}"
	},// data
	methods : {
		fnGetInfo : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "rentCarInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.carinfo;
                }
            }); 
		}
	}, // methods
	created : function() {
		var self = this;
		//self.fnGetInfo();
	}// created
});
</script>