<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="../../css/basic/btn-style.css" rel="stylesheet"/>
<link href="../css/basic/custom-table-style.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	#app{
		display: flex;
	    flex-direction: column;
	    min-height: 80vh;
	}
	.container {
		flex: 1;
		margin-top: 60px;
		margin-bottom: 60px;
	}
	.container h3{
		text-align: center;
	}
	tr, td, th{
		padding: 20px;
	}
	h3{
		margin-top: 100px;
		margin-bottom: 0px;
		text-align: center;
	}
	.btn-con{
		margin-bottom: 300px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="container">
			<h3>객실 등록</h3>
			<table class=" table custom-table table-striped table-bordered ">
				<thead>
					<tr>
						<th>선택</th>
						<th>No.</th>
						<th>객실 타입</th>
						<th>객실 가격</th>
						<th>남은 객실</th>
						<th>최대 수용 인원</th>
						<th>패키지 신청</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(item, index) in list">
						<td>
							<input v-if="index==0" type="radio" :value="item.roomNo" @input="changeRoomNo(item.roomNo)" name="roomNo" checked="checked">
							<input v-else type="radio" :value="item.roomNo" @input="changeRoomNo(item.roomNo)" name="roomNo">
						</td>
						<td>{{item.roomNo}}</td>
						<td>{{item.roomName}}</td>
						<td>{{item.roomPrice}}원</td>
						<td>{{item.roomResidue}}</td>
						<td>{{item.peopleMax}}명</td>
						<td>
							<span v-if="item.state=='A'">
								<div>신청이 완료되었습니다.</div>
								<div>취소는 1:1 문의를 남겨주세요.</div>
							</span>
							<button v-else-if="item.state=='D'" @click="fnPackDel(item.roomNo)" class="btn-red">취소</button>
							<button v-else @click="fnPackAdd(item.roomNo)" class="btn-dark">신청</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="btn-con">
			<span><button @click="fnAdd" class="btn-dark">객실 추가</button></span>
			<span><button @click="fnView" class="btn-dark">객실 상세 정보</button></span>
			<span><button @click="fnRemove" class="btn-red">객실 삭제</button></span>
			<span><button @click="fnBack" class="btn-dark">되돌아가기</button></span>
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
		roomNo : "",
		uId : "${sessionId}",
		stayNo : "${map.stayNo}",
		stayName : "${map.stayName}"
		
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {stayNo : self.stayNo, uId : self.uId};
			$.ajax({
                url : "roomList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.roomList;
                	console.log(self.list);
                	if(self.list.length > 0){ //리스트의 첫 번째 값을 디폴트로 체크하고, 해당 pk 값을 받아온다.
                        self.roomNo = self.list[0].roomNo;
                    } 
                }
            }); 
		},
		
		// 객실 추가
		fnAdd : function(){
			var self = this;
			console.log(self.stayNo);
			$.pageChange("roomAdd.do", {stayNo : self.stayNo});
		},
		
		// 객실 상세 정보
		fnView : function (){
			var self = this;
			console.log(self.roomNo);
			console.log(self.stayNo);
			$.pageChange("roomView.do", {roomNo : self.roomNo, stayNo : self.stayNo});
			
		},
		
		// 객실 삭제
		fnRemove : function(){
			var self = this;
			if(!confirm("해당 객실을 삭제하시겠습니까?")){
				alert("취소되었습니다.");
				return;
			}
			var param = {roomNo : self.roomNo};
			$.ajax({
                url : "roomRemove.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("해당 객실이 삭제되었습니다.");
                	self.fnGetList();
                	
                }
            }); 
		},
		changeRoomNo : function(roomNo){ //라디오박스를 선택할 때 마다 pk 값 변경
        	var self = this;
        	self.roomNo = roomNo;
        },
        fnPackAdd : function(roomNo){
			var self = this;
			console.log(roomNo);
			if(!confirm("패키지를 신청하시겠습니까?")){
	        	alert("신청이 취소되었습니다.");
	          	return;
	        }
			var param = {roomNo : roomNo};
			$.ajax({
                url : "roomPackAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	alert("패키지 신청이 완료되었습니다.");
                	self.fnGetList();
                }
			});
        },
        fnPackDel : function(roomNo){
			var self = this;
			if(!confirm("패키지 신청을 취소하시겠습니까?")){
	        	alert("변경이 취소되었습니다.");
	          	return;
	        }
			var param = {roomNo : roomNo};
			$.ajax({
                url : "roomPackDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) {
                	console.log(roomNo);
                	alert("패키지 신청이 취소되었습니다.");
                	self.fnGetList();
                }
			});
        },
        fnBack : function(){
        	location.href = "../host/stay.do";
        }
        
		
 	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>