<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
		*{
            margin: 0;
            padding: 0;
        }
        ul,li{
            list-style: none;
        }
        a{
            text-decoration: none;
            color: inherit;
        }
        img{
            width: 100%;
            height: 100%;
        }
        #header_box{
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background-color: #FF264D;
            box-sizing: border-box;
        }
        .logo_box{
            width: 80px;
            height: 80px;
        }
        .header_menu{
            display: flex;
            align-items: top;
            color: #fff;
        }
        .header_menu ul{
            display: flex;
            justify-content: end;
        }
        .header_menu ul li{
            margin-right: 20px;
        }
        .f_header{
            font-size: 12px;
            margin-bottom: 30px;
            font-weight: 700;
        }
        .s_header{
            font-size: 20px;
            font-weight: 700;
            cursor: context-menu;
        }
        .s_header>li{
            position: relative;
        }
        
        .s_header>li:hover ul{
            display: block;
        }
        .s_header>li ul{
            display: block;
            position: absolute;
            color: black;
            width: 120px;
            border: 1px solid;
            border-radius: 10px;
            background-color: #fff;
            padding: 10px;
            display: none;

        }
        .s_header>li ul li{
            margin-bottom: 5px;
        }
        .s_header>li ul li:hover{
            color: #FF264D;
        }
        .more ul{
            right: 0;
        }
        .more ul li{
            width: 200px;
        }
</style>
</head>
<body>
<div id="app">
	<header id="header_box">
        <div class="logo_box">
            <img src="img/header/logo.jpg" alt="logo">
        </div>
        <div class="header_menu">
            <div class="header_inner">
                <ul class="f_header">
                    <li><a href="javascript:;" @click="fnLogin">�α���</a></li>
                    <li><a href="javascript:;" @click="fnJoin">ȸ������</a></li>
                    <li><a href="javascript:;">��ٱ���</a></li>
                </ul>
                <ul class="s_header">
                    <li class="booking">�����ϱ�
                        <ul>
                            <li><a href="javascript:;">���ھ���</a></li>
                            <li><a href="javascript:;">����ī</a></li>
                            <li><a href="javascript:;">����</a></li>
                        </ul>
                    </li>
                    <li class="board">�Խ���
                        <ul>
                            <li><a href="javascript:;">��������</a></li>
                            <li><a href="javascript:;">1:1����</a></li>
                            <li><a href="javascript:;">�����Խ���</a></li>
                        </ul>
                    </li>
                    <li class="more">������
                        <ul>
                            <li><a href="javascript:;">�̺�Ʈ</a></li>
                            <li><a href="javascript:;">��� �� ��å</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </header>
</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "list.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	self.list = data.list;
                }
            }); 
        },
        fnLogin :function(){
        	location.href="userLogin.do";
        },
        fnJoin : function(){
        	location.href="userJoin.do";
        }
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
</script>