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
	#wrapper {position:relative;min-height:100%;min-width: 1150px;}
	#footer { left:0; bottom:0; width:100%;height:250px;background:#2b2d2e;}
	#footer .area_comp {overflow:hidden;width:1100px;margin:0 auto;padding-top:48px;}
	#footer .area_comp .cs_comp {float:left;width:275px;}
	#footer .area_comp .cs_comp .tit_cs {display:block;font-weight:normal;font-size:14px;line-height:16px;color:#f5f5f5;}
	#footer .area_comp .cs_comp .txt_tel {display:block;margin-top:15px;font-weight:normal;font-size:22px;line-height:22px;color:#f5f5f5;}
	#footer .area_comp .cs_comp .txt_tel .ico_tel {width:20px;height:22px;margin-right:12px;background-position:-55px 0;vertical-align:top;}
	#footer .area_comp .cs_comp .list_cs {overflow:hidden;margin-top:15px;}
	#footer .area_comp .cs_comp .list_cs dt {float:left;font-size:12px;margin-bottom:6px;line-height:14px;color:#707070;}
	#footer .area_comp .cs_comp .list_cs dd {display:block;overflow:hidden;margin-left:58px;margin-bottom:6px;font-size:13px;line-height:14px;color:#707070;}
	#footer .area_comp .cs_comp .list_cs dd span{font-size:11px;}
	#footer .area_comp .cs_comp .list_cs dt.gcl_block{display: none}
	#footer .area_comp .cs_comp .list_cs dd.gcl_block{display: none }
	#footer .area_comp .cs_comp .list_cs dt.name_time {color:#c0c0c1;}
	#footer .area_comp .cs_comp .list_cs dd.info_time {color:#c0c0c1;}
	
	#footer .policy_comp {float:left; width:825px; position: relative;}
	#footer .policy_comp .list_policy {overflow:hidden;}
	#footer .policy_comp .list_policy li {float:left;}
	#footer .policy_comp .list_policy .link_policy {float:left;font-size:14px;line-height:15px;*line-height:17px;color:#fff;opacity:0.7;vertical-align:top;}
	#footer .policy_comp .list_policy .txt_bar {float:left;width:1px;height:10px;margin:3px 8px 0;background-color:#414243;}
	#footer .policy_comp .txt_policy {display:block;margin-top:20px;font-size:11px;line-height:20px;color:#999;}
	#footer .policy_comp .txt_policy .link_license {font-size:12px;color:#999;}
	#footer .policy_comp address {display:block;margin-top:18px;font-size:12px;line-height:14px;color:#999;}
	
	#footer .policy_comp .list-sns {position: absolute; top: 0; right: 0; display: flex; column-gap: 16px;}
	#footer .policy_comp .list-sns li a {display: inline-block;}
	#footer .policy_comp .list-sns li a img {display: inline-block; border: 0px; width: 20px; height: 20px; opacity: 0.7;}
	
	#footer .policy_comp .ctf_wrap{ margin:16px 0 0 0; display: block; float: right;}
	#footer .policy_comp .ctf_wrap li{float:left}
	#footer .policy_comp .ctf_wrap li img {float:left}
	#footer .policy_comp .ctf_wrap li span {font-size: 11px;  color: #999; padding:0 10px ; float:left; line-height:1.5; }
	#footer .policy_comp .ctf_wrap li a {color:#999;text-decoration:none;}
	#footer .policy_comp .ctf_wrap li a:active, #footer .policy_comp .ctf_wrap li a:hover {text-decoration:underline;}
	#footer .policy_comp .ctf_wrap .r_line{border-right:solid 1px #414243 }

	table{
		border : 1px solid black;
		border-collapse: collapse;
		text-align : center;
	}
	th, td {
		border : 1px solid black;
		padding : 5px 10px;
	}
	ul{
	   list-style:none;
	   }
	
</style>
</head>
<body>
	<div id="foot">
		<div id="wrapper">
		<div id="footer">
		<div class="area_comp">
			
			<div class="cs_comp"> <strong class="tit_cs">������</strong> <span class="txt_tel"><span class="ico_comm ico_tel"></span><span class="tel_num">032-521-8889</span></span>
				<dl class="list_cs">
					<dt class="name_time gcl_none">��ð�</dt>
					<dd class="info_time gcl_none">09:30~22:00</dd>
					<dt class="name_time">���ɽð�</dt>
					<dd class="info_time">13:10~14:20</dd>
					<dd class="info_time"><span>(���ɽð����� �������� �������� �ʽ��ϴ�.)</span></dd>
					<dt>��Ʈ����</dt>
					<dd>010-2242-7850(�ָ� �� ������ �޹�)</dd>
					<dt class="gcl_none">��ü<!--/����--></dt>
					<dd class="gcl_none">010-2242-7850</dd>
				</dl>
			</div>
			
			<div class="policy_comp">
				<ul class="list-sns">
					<li><a href="https://bu.tjoeun.co.kr/" target="_blank"><img src="https://www.jeju.com/images/com/facebook_logo.svg" alt="�������� ���̽��� �ٷΰ���"></a></li>
					<li><a href="https://bu.tjoeun.co.kr/" target="_blank"><img src="https://www.jeju.com/images/com/naver_logo.svg" alt="�������� ���̹� ��α� �ٷΰ���"></a></li>
					<li><a href="https://www.instagram.com/jejucom_no.1" target="_blank"><img src="https://www.jeju.com/images/com/instagram_logo.svg" alt="�������� �ν�Ÿ�׷� �ٷΰ���"></a></li>
				</ul>
				<ul class="list_policy">
					<li> <a href="" class="link_policy">ȸ��Ұ�</a> <span class="txt_bar"></span> </li>
					<li> <a href="" class="link_policy">�������</a> <span class="txt_bar"></span> </li>
					<li> <a href="" class="link_policy">����������޹�ħ</a> <span class="txt_bar"></span> </li>
					<li> <a href="" class="link_policy">�̿���</a> <span class="txt_bar"></span> </li>
					<li> <a href="" class="link_policy">�����ź�</a> </li>
				</ul>
				<p class="txt_policy"> ����ڹ�ȣ: 540-81-01170 [<a href="" onclick="" class="link_license">���������Ȯ��</a>] | ����Ǹž��Ű��� �� 2023-��õ���-04699ȣ | ���������� �� 2018-77ȣ | ��ǥ��: ������  | ������������å����: �̽��� <br>
					�ּ�: (����)��õ������ ���� ������ 1336, (����, �����̼�Ÿ�� 7F) | ��ȣ�� : �ֽ�ȸ�� �������� <br> ��ǥ��ȭ: 1544-3100 | �ѽ�: 064-749-4488  | �̸���: web@jeju.com</p>
				<address>
				Copyright (c) JOJOTOUR.COM. All rights reserved.
				</address>
			</div>
		
		</div>
		</div>
		</div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#foot',
	data : {
	},// data
	methods : {
		
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>