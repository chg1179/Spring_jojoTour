<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
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
	���� ��ü �߰� ������
		<!-- <table>
		<tbody>
			<tr>
				<th>
					��ü �⺻ ����
				</th>
				<td>
					<div>
						<span>��ü��</span>
						<span>
							<input type="text" v-model="stayName" :value="item.productName" name="productName">
						</span>
					</div>
					<div>
						<span>��ü �ּ�</span>
						<span>
							<input type="text" v-model="pAddr" :value="item.pAddr" name="productName" placeholder="��ü �ּҸ� �Է��ϼ���.">
							<button @click="">�ּ� �˻�</button>
						</span>
					</div>
					<div>
						<span>
							<input type="text" v-model="pDetailAddr" :value="item.pDetailAddr" placeholder="������ �ּҸ� �Է����ּ���.">
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					���� ����				
				</th>
				<td>
					<span>
						<select>
							<option>ȣ��</option>
						</select>
					</span> ���� ���� �����ؼ� select option���� ��������
				</td>
			</tr>
			<tr>
				<th>
					���ǽü�
					<br>
					���� �ȳ�				
				</th>
				<td>
					<span>���ǽü�</span> ���� Ÿ�� ���̺�� �����ؼ� �޾ƿ� �� üũ�ڽ��� �ֱ�
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