<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>adminbar</title>
<style>
    
    a{
        text-decoration: none;
        color: inherit;
    }
    #adminbar {
    	
        position: float;
        top: 200px;
        height: 100%;
        background-color: rgba(255, 255, 255, 0);
    }
    #adminbar_container{
        float: left;
        margin-top : 100px;
        margin-left : 50px;
        height: 600px;
        width : 300px;
        
       
    }
    .adminbar_btn_box a{
        display: block;
        width: 100%;
        box-sizing: border-box;
        text-align: left;
        padding: 20px;
        height: 50px;
        line-height: 10px;
        border-bottom : 1px solid #ccc;
        font-size: 16px;
        font-weight: 500;
        position: relative;
         font-size : 18px;
    }
</style>
</head>
<body>
	<div id="adminbar">
		<div id="adminbar_container">
           
            <div class="adminbar_btn_box">
                <a href="javascript:;" class="page_btn user" @click="fnUser">회원관리</a>
                <a href="javascript:;" class="page_btn pack" @click="fnPackage">패키지 관리</a>
                <a href="javascript:;" class="page_btn packreq" @click="fnPackageReq">패키지 신청 관리</a>
            </div>
        </div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#adminbar',
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
		},
		fnUser : function(){
			location.href="/admin/user.do";
		},
		fnPackage : function(){
			location.href="/admin/packagelist.do";
		},
		fnPackageReq : function(){
			location.href="/admin/packagereq.do";
		}
	},
	created : function() {
		var self = this;
		/* self.fnGetList(); */
	}// created
});
</script>