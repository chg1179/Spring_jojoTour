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
	.jjim{
		background-color : buttonface;
	}
    .jjim::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
	*{
		margin: 0;
		padding: 0;
	}
	#my_jjim_container{
		margin: 50px 50px;
	}
	.my_jjim_box{
		display: flex;
		justify-content: center;
		width: 1000px;
		margin-top : 50px;
	}
	.my_jjim_box > div{
		width: 25%;
		border-top : 1px solid #686868;
		border-bottom : 1px solid #686868;
		border-right : 1px solid #ccc;
		height : 150px;
	}
	.my_jjim_box > div:last-child{
		border-right: none;
	}
	.my_jjim_box > div > p{
		text-align: center;
		margin-top: 20px;
		font-weight: bold;
		font-size: 20px;
		color: #414141;
	}
	.my_jjim_box > div > div{
		text-align: center;
		margin-top: 10px;
		font-weight: bold;
		margin-top: 60px;
		color : #5c5c5c;
	}
	@media (max-width : 1400px){
		.my_jjim_box{
			width: 600px;
		}
	}
	
	@media (max-width : 1000px){
		.my_jjim_box{
			width: 500px;
		}
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
		<div id="my_jjim_container">
			<h2>찜목록</h2>
			<div>
				<span><input type="checkbox" >전체선택</span>
				<span><button>삭제하기</button></span>
			</div>
		
			<div class="my_jjim_box" v-for="(item, index) in jjim" :key="index">
				<div class="jjim_num">
					<p>
						<span><input type="checkbox"></span>
						주문번호
					</p> 
					<div>{{item.productNo}}번</div>
				</div>
				<div class="jjim_product">
					<p>찜한제품</p>
					<div v-if="item.productKind == 'STAY'">숙박</div>
					<div v-if="item.productKind == 'RENT'">렌트카</div>
					<div v-if="item.productKind == 'LEISURE'">레저</div>
				</div>
				<div class="jjim_pay">
					<p>결제금액</p>
					<div>100{{item.payment}}</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}",
		jjim:""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "/my/jjim.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.jjim = data.jjim;
                	console.log(self.jjim);
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