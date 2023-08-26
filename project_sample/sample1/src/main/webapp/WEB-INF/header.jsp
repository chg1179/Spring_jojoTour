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
            margin:10px;
        }
		img {
		    width: 150%;
		    height: 110%;
		}
        header{
        	background-color : #213555;
            /* background: linear-gradient(30deg, #FA163F, #0FABBC 55%); */
            position : fixed;
            width : 100%;
            z-index : 999;
        }
        .header_empty_box{
        	height : 100px;
        }
        #header_box{
            display: flex;
            justify-content: space-between;
            padding: 20px 5px;
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
            width: 161px;
            border: 1px solid;
            border-radius: 10px;
            background-color: #fff;
            padding: 5px;
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
	                <a href="javascript:;" @click="fnLogo"><img src="/img/header/logo2.png" alt="logo"></a>
	            </div>
	            <div class="header_menu">
	                <div class="header_inner">
	                    <ul class="f_header">
	                        <li v-if="status==''">
	                        	<a href="javascript:;" @click="fnLogin">�α���</a>
	                        </li>
	                        <li v-if="status==''">
	                        	<a href="javascript:;" @click="fnJoin">ȸ������</a>
	                        </li>
	                        <li v-else>
	                        	<a href="javascript:;" @click="fnLogout">�α׾ƿ�</a>
	                        </li>
	                        <li v-if="status == 'H' || status == 'U'">
	                        	<a href="javascript:;" @click="fnMyHome">����Ȩ</a>
	                        </li>
	                        <li><a href="javascript:;" @click="fnJJim">����</a></li>
	                        <li><a href="javascript:;" @click="fnCart">��ٱ���</a></li>
	                        <li v-if="status == 'H'">
	                        	<a href="javascript:;" @click="fnProduct">��ǰ����</a>
	                        </li>
	                        <li v-if="status == 'A'">
	                        	<a href="javascript:;" @click="fnAdminPage">���� ������</a>
	                        </li>
	                    </ul>
	                    <ul class="s_header">
	                        <li class="stay">
	                            <a href="javascript:;" @click="fnStay">����</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkStayKind('HOTEL')">ȣ��</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('MOTEL')">����</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('GUEST')">�Խ�Ʈ�Ͽ콺</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('PENSION')">���</a></li>
	                                <li><a href="javascript:;" @click="checkStayKind('CAMPING')">ķ��</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_rentCar">
	                            <a href="javascript:;" @click="fnRentCar">����ī</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkKind('SMALL')">������</a></li>
	                                <li><a href="javascript:;" @click="checkKind('MIDDLE')">������</a></li>
	                                <li><a href="javascript:;" @click="checkKind('LARGE')">������</a></li>
	                                <li><a href="javascript:;" @click="checkKind('VAN')">������</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_water_leisure">
	                            <a href="javascript:;" @click="fnWaterLeisure">���� ����</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkWaterKind('SNORKE')">������</a></li>
	                                <li><a href="javascript:;" @click="checkWaterKind('SURFING')">����</a></li>
	                                <li><a href="javascript:;" @click="checkWaterKind('YACHT')">��Ʈ</a></li>
	                                <li><a href="javascript:;" @click="checkWaterKind('JETSKI')">��Ʈ��Ű</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_land_leisure">
	                            <a href="javascript:;" @click="fnGroundLeisure">���� ����</a>
	                            <ul>
	                                <li><a href="javascript:;" @click="checkGroundKind('ATV')">ATV</a></li>
	                                <li><a href="javascript:;" @click="checkGroundKind('GLIDER')">�䷯�۶��̵�</a></li>
	                                <li><a href="javascript:;" @click="checkGroundKind('HORSE')">�¸�</a></li>
	                            </ul>
	                        </li>
	                        <li class="header_board">
	                            <a href="javascript:;" @click="fnNotice">�Խ���</a>
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
	                                <li><a href="/terms.do">��� �� ��å</a></li>
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
        	location.href="/login.do";
        },
        fnJoin : function(){
        	location.href="/join/select.do";
        },
        fnCart : function(){
        	if(this.status=="" || this.status == null){
        		alert("�α��� �� �̿��� �����մϴ�.");
        		location.href="/login.do";
        		return;
        	} 
        	location.href="/cart.do";
        },
        fnLogo : function(){
        	location.href="/main.do";
        	/* ../main.do�� ���� ��ΰ� �ѹ� ���ļ� ���� */
        },
        fnLogout : function(){
        	location.href="/logout.do";
        },
        fnNotice : function(){
        	location.href="/notice/list.do";
        },
        fnFAQ : function(){
        	location.href="/faq/list.do";
        },
        //���� ������
        fnAdminPage : function(){
        	location.href="/admin/user.do";
        },
        //��ǰ����������
        fnProduct : function(){
        	location.href="/host/main.do";
        },
        fnMyHome : function(){
        	location.href="/my/order.do";
        },
        fnInquiry : function(){
            location.href="/inquiry/list.do";
        },
        fnFree : function(){
        	location.href="/free/list.do";
        },
        fnReview : function(){
        	location.href="/review/list.do";
        },
        fnRentCar : function(){
        	location.href="/rentcar.do";
        },
		checkKind : function(kind){
			$.pageChange("/rentcar.do", {rentKind : kind});
		},
        fnJJim : function(){
        	if(this.status=="" || this.status == null){
        		alert("�α��� �� �̿��� �����մϴ�.");
        		location.href="/login.do";
        		return;
        	} 
        	location.href="/my/jjim.do";
        },
        fnWaterLeisure : function(){
        	location.href="/water/leisure.do";
        },
		checkWaterKind : function(kind){
			$.pageChange("/water/leisure.do", {leisureKind : kind});
		},
        fnGroundLeisure : function(){
        	location.href="/ground/leisure.do";
        },
		checkGroundKind : function(kind){
			$.pageChange("/ground/leisure.do", {leisureKind : kind});
		},
		fnStay : function(){
			location.href="/stay.do";
		},
		checkStayKind : function(kind){
			var self = this;
			$.pageChange("/stay.do", {stayKind : kind});
		},
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>