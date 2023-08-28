<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>AdminBar</title>
<style>
    *{
        margin: 0;
        padding: 0;
    }
    a{
        text-decoration: none;
        color: inherit;
    }
    #adminbar_container{
        float: left;
        margin : 50px;
        border: 1px solid #ccc;
    }
    .adminbar_title{
        width: 200px;
        background-color: #213555;
        text-align: center;
        padding: 5px;
        box-sizing: border-box;
        color: #fff;
        font-weight: bold;
        height: 70px;
        font-size: 24px;
        line-height: 60px;
    }
    .adminbar_btn_box a{
        display: block;
        width: 200px;
        box-sizing: border-box;
        text-align: left;
        padding: 5px;
        height: 50px;
        line-height: 40px;
        border: 1px solid #ccc;
        font-size: 16px;
        font-weight: 500;
        position: relative;
    }
</style>
</head>
<body>
	<div id="adminbar">
		<div id="adminbar_container">
            <div class="adminbar_title">����������</div>
            <div class="adminbar_btn_box">
                <a href="javascript:;" class="page_btn user" @click="fnUser">ȸ������</a>
                <a href="javascript:;" class="page_btn pack" @click="fnPackage">��Ű�� ����</a>
                <a href="javascript:;" class="page_btn packreq" @click="fnPackageReq">��Ű�� ��û ����</a>
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
	}// created
});
</script>