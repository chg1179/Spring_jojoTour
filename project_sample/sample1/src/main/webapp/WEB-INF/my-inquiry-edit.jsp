<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
	<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	#review_container{
		width : 60%;
		float : left;
	}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
	 		<div id="inquiry_container">
			<div>
				<vue-editor class="v_editor" v-model="info.iContent"></vue-editor>
			</div>
			<button @click="fnEdit">수정완료</button>
			<button @click="fnCancle">취소하기</button>
		</div>
	</div>
</body>
</html>
<script>
console.log(Vue);
Vue.use(Vue2Editor);
const VueEditor = Vue2Editor.VueEditor;
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		iNo : "${map.iNo}",
		info : {
			iTitle : "",
			iContent : ""
			
		}
	},// data
    components: {
    	VueEditor
   	},
	methods : {
		fnGetList : function(){
			var self = this;			
			var param = {iNo : self.iNo};
			$.ajax({
                url : "inquiryInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	console.log(data);
                }
            }); 
		},
		fnEdit : function(){
			var self = this;			
			var param = self.info;
			console.log(self.info);
			$.ajax({
                url : "inquiryEdit.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert("수정되었습니다.");
					location.href="../inquiry.do";
                }
            }); 
		},
		fnCancle : function(){
			location.href="../inquiry.do";
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>