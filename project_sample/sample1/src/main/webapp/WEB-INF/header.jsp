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
        header{
            background-color: #F86F03;
            position : fixed;
            width : 100%;
            z-index : 1;
        }
        .header_empty_box{
        	height : 100px;
        }
        #header_box{
            display: flex;
            justify-content: space-between;
            padding: 10px;
            box-sizing: border-box;
            margin: 0 auto;
        }
        .logo_box{
            width: 80px;
            height: 80px;
        }
        .header_menu{
            display: flex;
            align-items: top;
            color: #FFF6F4;
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
        .f_header>li>a:hover{
            color: yellow;
        }
        .s_header{
            font-size: 18px;
            font-weight: 700;
            cursor: context-menu;
        }
        .s_header>li{
            position: relative;
        }
        .s_header>li>a:hover{
            color: yellow;
        }
        
        .s_header>li:hover ul{
            display: block;
        }
        .s_header>li ul{
            display: block;
            position: absolute;
            color: black;
            width: 130px;
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
            color: #F86F03;
        }
        .header_more ul{
            right: 0;
        }
        .header_more ul li{
            width: 200px;
        }
</style>
</head>
<body>
	<div id="header">
	    <header>
	        <div id="header_box">
	            <div class="logo_box">
	                <a href="javascript:;" @click="fnLogo"><img src="/img/header/logo.jpg" alt="logo"></a>
	            </div>
	            <div class="header_menu">
	                <div class="header_inner">
	                    <ul v-if="status == ''"class="f_header">
	                        <li><a href="javascript:;" @click="fnLogin">�α���</a></li>
	                        <li><a href="javascript:;" @click="fnJoin">ȸ������</a></li>
	                        <li><a href="javascript:;">��ٱ���</a></li>
	                    </ul>
	                    <ul v-else-if="status == 'A'" class="f_header">
	                        <li><a href="javascript:;" @click="fnLogout">�α׾ƿ�</a></li>
	                        <li><a href="javascript:;" @click="fnAdminPage">���� ������</a></li>
	                        <li><a href="javascript:;">��ٱ���</a></li>
	                    </ul>
	                    <ul v-else-if="status == 'H'" class="f_header">
	                        <li><a href="javascript:;" @click="fnLogout">�α׾ƿ�</a></li>
	                        <li><a href="javascript:;" @click="fnMyHome">����Ȩ</a></li>
	                        <li><a href="javascript:;" @click="fnProduct">��ǰ����</a></li>
	                        <li><a href="javascript:;">��ٱ���</a></li>
	                    </ul>
	                    <ul v-else class="f_header">
	                        <li><a href="javascript:;" @click="fnLogout">�α׾ƿ�</a></li>
	                        <li><a href="javascript:;" @click="fnMyHome">����Ȩ</a></li>
	                        <li><a href="javascript:;">��ٱ���</a></li>
	                    </ul>
	                    <ul class="s_header">
	                        <li class="stay">
	                            <a href="javascript:;">���ھ���</a>
	                            <ul>
	                                <li><a href="javascript:;">ȣ��</a></li>
	                                <li><a href="javascript:;">����</a></li>
	                                <li><a href="javascript:;">�Խ�Ʈ�Ͽ콺</a></li>
	                                <li><a href="javascript:;">���</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_rentCar">
	                            <a href="javascript:;">����ī</a>
	                            <ul>
	                                <li><a href="javascript:;">������</a></li>
	                                <li><a href="javascript:;">������</a></li>
	                                <li><a href="javascript:;">������</a></li>
	                                <li><a href="javascript:;">������</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_water_leisure">
	                            <a href="javascript:;">���� ����</a>
	                            <ul>
	                                <li><a href="javascript:;">������</a></li>
	                                <li><a href="javascript:;">����</a></li>
	                                <li><a href="javascript:;">��Ʈ</a></li>
	                                <li><a href="javascript:;">��Ʈ��Ű</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_land_leisure">
	                            <a href="javascript:;">���� ����</a>
	                            <ul>
	                                <li><a href="javascript:;">ATV</a></li>
	                                <li><a href="javascript:;">�䷯�۶��̵�</a></li>
	                                <li><a href="javascript:;">��Ÿ��</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_board">
	                            <a href="javascript:;">�Խ���</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="fnNotice">��������</a></li>
	                                <li><a href="javascript:;" @click="fnFAQ">FAQ �Խ���</a></li>
	                                <li><a href="javascript:;" @click="fnInquiry">1:1����</a></li>
	                                <li><a href="javascript:;" @click="fnFree">�����Խ���</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_more">
	                            <a href="javascript:;">������</a>
	                            <ul>
	                                <li><a href="javascript:;">�̺�Ʈ</a></li>
	                                <li><a href="javascript:;">��� �� ��å</a></li>
	                            </ul>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </header>
	    <div class="header_empty_box"></div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#header',
	data : {
		status : "${sessionStatus}"
	},// data
	methods : {
        fnLogin :function(){
        	location.href="../login.do";
        },
        fnJoin : function(){
        	location.href="../join/select.do";
        },
        fnLogo : function(){
        	location.href="/main.do";
        	/* ../main.do�� ���� ��ΰ� �ѹ� ���ļ� ���� */
        },
        fnLogout : function(){
        	location.href="../logout.do";
        },
        fnNotice : function(){
        	location.href="../notice/list.do";
        },
        fnFAQ : function(){
        	location.href="../faq/list.do";
        },
        //���� ������
        fnAdminPage : function(){
        	location.href="../admin/main.do";
        },
        //��ǰ����������
        fnProduct : function(){
        	location.href="/host/main.do";
        },
        fnMyHome : function(){
        	location.href="/my/change.do";
        },
        fnInquiry : function(){
            location.href="../inquiry/list.do";
        },
        fnFree : function(){
        	location.href="../free/list.do";
        }
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>