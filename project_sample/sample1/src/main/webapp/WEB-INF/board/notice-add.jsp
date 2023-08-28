<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<link href="../../css/board/board-style.css" rel="stylesheet"/>
<link href="../../css/board/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>공지사항 글 추가</title>
<style>
   body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }

    #app {
      margin: 35px auto;
      max-width: 1000px;
      background-color: #fff;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 5px;
    }

    .WritingHeader {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .WritingHeader h2 {
      font-size: 24px;
      color: #333;
    }

    input[type="text"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .vue-editor {
      border: 1px solid #ccc;
      border-radius: 5px;
      padding: 10px;
      font-size: 16px;
      height:825px;
    }

    button[disabled] {
      background-color: #ccc;
      cursor: not-allowed;
    }
    .ql-container.ql-snow {
    border: 1px solid #ccc;
    height: 750px;
	}
	 .search-wrap {
      display: flex;
      align-items: center;

    }

    #mySelect {
      margin-right: 10px;
            height: 40px;
    }
    select:hover {
    border-color: #555;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
		<div class="WritingWrap">
			<div class="WritingHeader">
			    <h2>공지사항 글쓰기</h2>
			        <div class="tool_area">
			          <button v-if="nNo === ''" @click="fnAdd" class="btn1">등록</button>
			          <button v-else @click="fnEdit" class="btn1">수정</button>
			          <button @click="fnBack" class="btn1">뒤로가기</button>
			        </div>
		    </div>
		<input type="text" id="myInput" v-model="info.nTitle" placeholder="제목">
		<br>
		<br>
		<div class="vue-editor">
			<vue-editor v-model="info.nContent"></vue-editor>
		</div>
		<br>
		
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
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
		uId:"${sessionId}",
		nNo : "${map.nNo}",
		info : {
			nTitle : "",
			nContent : ""
		}	
	},// data
	components: {VueEditor},
	methods : {
		fnAdd : function(){
			var self = this;
			if(self.info.nTitle.trim() == ""){
				alert("제목을 입력해주세요.");
				return;
				}
			
			if(self.info.nContent.trim() == ""){
				alert("내용을 입력해주세요.");
				return;
			}
			 var param = self.info;
			 param.uId = self.uId;
			$.ajax({
                url : "add.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
					alert("등록 완료");
					location.href = "list.do";
                }
            }); 
		},
	     fnGetList : function(){
				var self = this;
				var param = {nNo : self.nNo, kind : "UPDATE"};
				$.ajax({
	                url : "view.dox",
	                dataType:"json",	
	                type : "POST",
	                data : param,
	                success : function(data) { 
	                	self.info = data.info;
	                }
	            }); 
			},
 			fnEdit : function(){
				var self = this;
				if(self.info.nTitle == ""){
					alert("제목을 입력해주세요.");
					return;
					}
				
				if(self.info.nContent == ""){
					alert("내용을 입력해주세요.");
					return;
				}
				var param = self.info;
				$.ajax({
	                url : "edit.dox",
	                dataType:"json",	
	                type : "POST",
	                data : param,
	                success : function(data) { 
	                	alert("수정되었습니다");
	                	location.href = "list.do";
	                }
	            }); 
			},
			fnBack : function(){
				if(confirm("취소하시겠습니까?")){
					location.href = "list.do";
				}
			}
		
	}, // methods
	created : function() {
		var self = this;
		if(self.nNo != ""){
			self.fnGetList();
		}

	}// created
});
</script>