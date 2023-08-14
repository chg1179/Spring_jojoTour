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
	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div id="app">
		숙소 업체 추가 페이지
		<table>
			<tbody>
				<tr>
					<th>
						객실 정보
					</th>
					<td>
						<div>
							<span>객실명</span>
							<span>
								<input type="text" v-model="info.roomName" name="roomName">
							</span>
						</div>
						<div>
							<span>인원</span>
							<span>
								<select v-model="selectPeopleMax">
									<option value="">선택하세요</option>
									<option v-for="">선택하세요</option>
								</select>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						숙소 유형				
					</th>
					<td>
						<span>
							<select v-model="selectStayType">
								<option value="">선택하세요</option>
								<option v-for="stayType in typeList" :value="stayType.cKind">{{stayType.cName}}</option>
							</select>
						</span>
					</td>
				</tr>
				<tr>
					<th>
						편의시설
						<br>
						서비스 안내
					</th>
					<td>
						<div v-for="item in serviceList">
							<label><input type="checkbox" :value="item.serviceName">{{item.serviceName}}</label>
						</div>					
					</td>
				</tr>
			</tbody>
		</table>
		<button @click="fnStayAdd">숙소 등록</button>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : []
	},// data
	methods : {
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
                	console.log(self.list);
                }
            }); 
		}
		
	}, // methods
	created : function() {
		var self = this;
//		self.fnGetList();
	}// created
});
</script>