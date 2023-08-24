<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/board-style.css" rel="stylesheet"/>
<link href="../../css/board-btn-style.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>FAQ게시판 글쓰기</title>
<style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
    }

    #app {
      margin: 20px auto;
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

    .tool_area button {
      background-color: #007bff;
      color: #fff;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    .tool_area button:hover {
      background-color: #0056b3;
    }

    input[type="text"] {
      width: 97%;
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
      height:800px;
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
			        <h2>FAQ게시판 글쓰기</h2>
		        <div class="tool_area">
		          <button v-if="fNo === ''" @click="fnAdd">등록</button>
		          <button v-else @click="fnEdit">수정</button>
		          <button @click="fnBack">뒤로가기</button>
		        </div>
		    </div>
	
		<div class="search-wrap">
        
	      	<select id="mySelect">
				<option value="<숙박>">숙박</option>
				<option value="<렌트>">렌트</option>
				<option value="<레저>">레저</option>
				<option value="<패키지>">패키지</option>
				<option value="<포인트>">포인트</option>
				<option value="<기타문의>">기타문의</option>
			</select>
			<input type="text" id="myInput" v-on:change="handleSelectChange"  v-model="info.fTitle" placeholder="제목">	
      	</div>
			<br>
	      <div class="vue-editor">
	        <vue-editor v-model="info.freeContent"></vue-editor>
	      </div>
	<br>
	
	
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
		uId:"${sessionId}",
		fNo : "${map.fNo}",
		info : {
			fTitle : "",
			fContent : ""
		}	
	},// data
	components: {VueEditor},
	methods : {
		fnAdd : function(){
			var self = this;
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
				var param = {fNo : self.fNo, kind : "UPDATE"};
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
				location.href = "list.do";
			}
		
	}, // methods
	mounted: function() {
	      const selectElement = document.getElementById('mySelect');
	      const inputElement = document.getElementById('myInput');

	      selectElement.addEventListener('change', function() {
	          inputElement.value = this.value;
	      });
	   },
	created : function() {
		var self = this;
		if(self.fNo != ""){
			self.fnGetList();
		}

	}// created
});
</script>