<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	.container {
		display: flex;
		justify-content: center;
		margin-top: 30px;
	}
	.container h3{
		text-align: center;
		padding: 14px;
	}
	.host-table{
		width: 1000px;
		border-top: 1px solid black;
		border-botton: 1px solid black;
		border-collapse: collapse;
	}
	
	.host-table a {
		color: #333;
		display: inline-block;
		line-height : 1.4;
	}
	.host-table a:hover{
		text-decoration: underline;
	}
	
	.host-table th, .host-table td{
		text-align: center;
		padding: 14px 0;
		border-bottom: 1px solid black;
		border-left: 1px solid #ccc; 
		border-right: 1px solid #ccc; 
	}
	.host-table th:first-child,
	.host-table td:first-child {
		border-left: none;
	}

	.host-table th:last-child,
	.host-table td:last-child {
		border-right: none;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<div class="container">
		<h3>숙소 방 등록 페이지</h3>
		
	</div>
		<div class="container">
			<table class="host-table">
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
						<td>{{item.roomPrice}}</td>
						<td>{{item.roomResidue}}</td>
						<td>{{item.peopleMax}}명</td>
						<td>
							<span v-if="item.state=='A'">
								<div>신청이 완료되었습니다.</div>
								<div>취소는 1:1 문의를 남겨주세요.</div>
							</span>
							<button v-else-if="item.state=='D'" @click="fnPackDel(item.roomNo)">취소</button>
							<button v-else @click="fnPackAdd(item.roomNo)">신청</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="container">
			<span><button @click="fnAdd">객실 추가</button></span>
			<span><button @click="fnView">객실 상세 정보</button></span>
			<span><button @click="fnRemove">객실 삭제</button></span>
		</div>
	</div>
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
		
 	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>