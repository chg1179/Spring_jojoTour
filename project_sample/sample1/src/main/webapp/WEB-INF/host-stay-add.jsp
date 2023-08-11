<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>숙박 관리 페이지</title>
<style>
	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 10px 20px;
	}
	a {
		
	}
</style>
</head>
<body>
	<div id="app">
	숙소 업체 추가 페이지
		<!-- <table>
		<tbody>
			<tr>
				<th>
					업체 기본 정보
				</th>
				<td>
					<div>
						<span>업체명</span>
						<span>
							<input type="text" v-model="stayName" :value="item.productName" name="productName">
						</span>
					</div>
					<div>
						<span>업체 주소</span>
						<span>
							<input type="text" v-model="pAddr" :value="item.pAddr" name="productName" placeholder="업체 주소를 입력하세요.">
							<button @click="">주소 검색</button>
						</span>
					</div>
					<div>
						<span>
							<input type="text" v-model="pDetailAddr" :value="item.pDetailAddr" placeholder="나머지 주소를 입력해주세요.">
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
						<select>
							<option>호텔</option>
						</select>
					</span> 숙소 유형 조인해서 select option으로 가져오기
				</td>
			</tr>
			<tr>
				<th>
					편의시설
					<br>
					서비스 안내				
				</th>
				<td>
					<span>편의시설</span> 서비스 타입 테이블과 조인해서 받아온 값 체크박스에 넣기
				</td>
			</tr>
		</tbody>
		</table> -->
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		productName : "",
		pAddr : "",
		pDetailAddr : ""

	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {productName : self.productName , pAddr : self.pAddr, pDetailAddr : self.pDetailAddr};
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	console.log(self.list);
                	
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