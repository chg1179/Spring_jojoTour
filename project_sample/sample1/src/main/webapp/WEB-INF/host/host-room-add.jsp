<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../../css/basic/host-edit-style.css" rel="stylesheet"/>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	table{
		margin : 30px auto;
		border : 1px solid black;
		border-collapse: collapse;
		font-size : 14px;
		padding:5px 10px;
	}

	th, td {
		border : 1px solid gray;
		padding: 30px 12px;
	}
	th{
		background-color:#f2f2f2;
	}
	h3{
		margin: 50px auto;
		text-align: center;
		margin-bottom: 30px;
	}
	h2{
		margin: 50px auto;
		text-align: center;
		margin-bottom: 30px;
		color:black;
	}
	img {
		 max-width: 600px; /* 최대 너비를 800px로 설정 */
		 height: auto; /* 높이를 자동으로 조절하여 비율 유지 */
	}
	.btnbtn{
		text-align: center;
		margin-bottom:50px;
	}
	.container{
		width:1100px;
		background-color:white;
		border-radius:6px;
		box-shadow:0px 0px 10px rgba(0, 0, 0, 0.2);
		padding: 1px;
	    margin: 50px auto;
	    
	}
	body{
		background-color:#f2f2f2
	}
	.container input{
		background: none;
	    width: 50%;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
	.filebox .upload-name {
	    display: inline-block;
	    height: 40px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 50%;
	    color: #999999;
	}
	.filebox label {
	    display: inline-block;
	    padding: 10px 10px;
	    color: #fff;
	    vertical-align: middle;
	    background-color: #999999;
	    cursor: pointer;
	    height: 20px;
	    margin-left: 5px;
	}
	
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
	select{
		background: none;
	    width: 20%;
	    margin-top: 10px;
	    font-size: 16px;
	    line-height: 1;
	    color: rgba(0, 0, 0, 0.56);
	    border: 1px solid rgba(0, 0, 0, 0.08);
	    height: 40px;
	    padding: 2px;
	    border-radius: 4px;
	    font-family: 'Jeju Gothic', sans-serif;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
			<h2>객실 등록</h2>
			<table>
				<tbody>
					<tr>
						<th>객실 유형</th>
						<td><input type="text"  v-model="info.roomName" maxlength="30" name="roomName" id="roomName"></td>
					</tr>
					<tr>
						<th>객실 금액</th>
						<td><input type="text" v-model="info.roomPrice" maxlength="10" name="roomPrice" id="roomPrice"></td>
					</tr>
					<tr>
						<th>할인율(%)</th>
						<td><input type="text" v-model="sales" maxlength="2" placeholder="0" name="roomSales" id="roomSales"  @keyup="fnPercent"></td>
					</tr>
					<tr>
						<th>인원</th>
						<td>
							<select v-model="peopleMaxValue" >
								<option :key="index" :value="item.value" v-for="(item, index) in selectList">{{item.text}}</option>
							</select>
						</td>
					<tr>
					<tr>		
						<th>상세정보이미지</th>
						<td>
							<div class="filebox">
							    <input class="upload-name" id="fileYName" placeholder="첨부파일" readonly>
							    <a href="javascript:;" v-if="fileYFlg" @click="fnDelFile('Y')"><i class="fa-solid fa-xmark fa-2xs"></i></a>
							    <label for="fileY" >이미지선택</label> 
							    <input type="file" accept=".gif, .jpg, .png" id="fileY" name="fileY" @change="fnFlgChange('Y')">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btnbtn">
				<button @click="fnRoomAdd(info.roomNo)" class="btn-dark">객실 등록</button>
				<button @click="fnBack" class="btn-red">취소</button>
			</div>
		</div>
		
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		peopleMaxValue : "",
		uId : "${sessionId}",
		status : "${sessionStatus}",
		stayNo : "${map.stayNo}",
		status : "${sessionStatus}",
		serviceNo : 0,
		sales : "",
		info : {},
		selectList : [
			{value:"1", text : "1 명"},			
			{value:"2", text : "2 명"},			
			{value:"3", text : "3 명"},			
			{value:"4", text : "4 명"},			
			{value:"5", text : "5 명"},			
			{value:"6", text : "6 명"},			
			{value:"7", text : "7 명"},			
			{value:"8", text : "8 명"},			
			{value:"9", text : "9 명"},			
			{value:"10", text : "10 명"},			
				
		],
		fileYFlg : false
	},// data
	methods : {
		
		// 룸 추가
		fnRoomAdd : function(roomNo){
			var self = this;
			if(self.info.roomName==""){
				alert("객실 유형을 입력해주세요.");
				return;
			}
			
			var regex = new RegExp(/^[0-9]+$/);
			if(self.info.roomPrice==""){
				alert("객실 금액을 입력해주세요.");
				return;
			}
			if(!regex.test(self.info.roomPrice)){
				alert("객실 금액은 숫자만 입력해주세요.");
				return;
			}
			if(self.info.roomPrice < 1000){
				alert("렌트 금액은 1000원 이상으로 입력해주세요.");
				return;
			}
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("할인율은 숫자만 입력해주세요.");
					return;
				}
			}
			if(self.sales < 0 || self.sales >= 100){
				alert("할인율은 0~99 사이의 숫자만 입력해주세요.");
				return;
			}
			if(self.peopleMaxValue==""){
				alert("최대 인원을 선택해주세요.");
				return;
			}
			var fileCheck = document.getElementById("fileY").value;
			if(!fileCheck){
				alert("상세정보 이미지를 첨부해 주세요");
				return;
			}
			if(!confirm("객실을 등록하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			
			self.info.roomSales = (100 - self.sales) / 100; 
			var param = self.info;
			var param = {
				roomName : self.info.roomName,
				roomPrice : self.info.roomPrice,
				peopleMax : self.peopleMaxValue,
				roomSales : self.info.roomSales,
				stayNo : self.stayNo,
				uId : self.uId,
				roomNo : roomNo,
			};
			$.ajax({
                url : "roomAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	var form = new FormData();
	       	        form.append( "files",  $("#fileY")[0].files[0]);
	       	     	form.append( "roomNo",  data.roomNo); // 제품 pk
	       	     	console.log(data.roomNo);
	           		self.upload(form);
	           		
            		alert("객실이 등록되었습니다.");
            		$.pageChange("../host/room.do", {stayNo : self.stayNo});
            		self.selectServiceList = [];
                }
            }); 
		},

		// 파일 업로드
		upload : function(form){
		   	var self = this;
		        $.ajax({
		            url : "roomFileUpload.dox"
		          , type : "POST"
		          , processData : false
		          , contentType : false
		          , data : form
		          , success:function(response) { 
		       	   
		          }
		      });
		},
		
		//파일이 선택됐는지 확인 (선택됐다면 x버튼이 나온다.)
		fnFlgChange : function(){
			var self = this;
			var fileCheck = document.getElementById("fileY").value;
			
			if(!fileCheck){
				document.getElementById("fileYName").value = "";
				self.fileYFlg = false;
				return;
			} else{
				document.getElementById("fileYName").value = $("#fileY")[0].files[0].name;
				self.fileYFlg = true;
				return;
			}
			
		},
		// 파일 삭제
		
		fnDelFile : function(){
			var self = this;
			document.getElementById("fileY").value = "";
			document.getElementById("fileYName").value = "";
		}, 
		fnBack : function(){
        	var self = this;
			$.pageChange("../host/room.do", {stayNo : self.stayNo}); 
        },
        fnPercent : function(){ // 할인율 0~100 제한
			var self = this;
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.sales)){
				if(!(self.sales=="")){
					alert("할인율은 숫자만 입력해주세요.");
					self.sales = 0;
					return;
				}
			}
			if(self.sales >= 100){
				alert("100보다 낮은 숫자를 입력해주세요.");
				self.sales = 0;
			} else if(self.sales < 0){
				alert("0보다 큰 숫자를 입력해주세요.");
				self.sales = 0;
			}
		},
		
		
	}, // methods
	created : function() {
		var self = this;
		if(self.status !== "H"){
			alert("호스트만 접근할 수 있습니다.");
			location.href="../../main.do";
		} 
		
	}// created
});
</script>