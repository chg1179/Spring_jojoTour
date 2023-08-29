<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../../css/detail-img.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>���� ���� �� ������</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
		body {
		  font-family: 'Jeju Gothic', sans-serif;
	      background-color: #f0f0f0;
	      margin: 0;
	      padding: 0;
		}
		
        .condiv {
        	display: flex; 
    		justify-content: center;
            
        }
        .linediv {
        	display: flex;
        	padding: 20px;
            box-sizing: border-box;
            flex-direction : column;
        }
        input[type=button]{
        	
        }
        
		.mainimg {
			width : auto;
			height : 500px;
		}
		.dediv {
			
			 text-align: left;
		}
		.btn {
			color : white;
			width: 300px;
			height : 60px;
			border : 1px solid #213555;
			background: #213555;
			border-radius : 8px;
			font-size: 30px;
			font-family: 'Jeju Gothic', sans-serif;
			
		}
		       	#app{
		margin: 20px auto;
	    max-width: 1200px;
	    background-color: #fff;
	    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	    padding: 20px;
	    border-radius: 5px;
		}
					hr {
	  height: 10px;
	  border: 0;
	  box-shadow: 0 10px 10px -10px #bbb inset;
	}
	
	
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
	<div id="app">
	<h1 style="color: #213555; text-align: center; margin-top: 40px; margin-bottom: 30px;">���� �󼼺���</h1>
		<hr>
		<div class="condiv">
		<img :src="info.imgPath" class="mainimg" style="border-radius: 4px;">
			<span class="linediv">
				<span style="font-size: 30px;">{{info.leisureName}}</span>
				
				<br>
				<span style="color : red; font-size: 20px; padding-left : 10px;">{{100-info.leisureSales*100}}% 
					<span style="color : black;  font-size: 24px;  padding-left : 10px;">{{info.leisurePrice * info.leisureSales | comma }}��</span></span>
				<span style="font-size: 16px; color : grey; text-decoration : line-through;">{{info.leisurePrice | comma }}��</span>
				<br><br><br><br><br>
				<span > ���� ���� : {{info.cName}}</span>
				<br>
				<span > ��ġ : {{info.lAddr}}{{info.lDetailAddr}}</span>
				<br>
				<span > ��ϳ�¥ : {{info.lInsertTime}}</span>
				<br><br><br><br>
				<span v-if="!isWished">
					<a @click="fnWish(info.leisureNo)" href="javascript:;">
						<i class="fa-regular fa-heart fa-bounce fa-2x" style="color: #ff0000;"></i>
					</a>
				</span>
				<span v-else>
					<a @click="fnDelWish(info.leisureNo)" href="javascript:;">
						<i class="fa-solid fa-heart fa-bounce fa-2x " style="color: #ff0000;"></i>
					</a>
				</span>
				<span><input type="button" value="��ٱ���" class="btn" @click="fnCart"></span>
			</span>	
		</div>
		<div class="detail_container">
			<div class="detail_wrap">
				<h2>�� �̹���</h2>
				<div class="detail_img_box">
					<img alt="" :src="detailImg.imgPath">
				</div>
				<button class="detail_btn">���ĺ���</button>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
Vue.filter('comma', function(value) {
	  if (!value) return '';
	  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	});
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		leisureNo : "${map.leisureNo}",
		info : {},
		uId : "${sessionId}",
		isWished:false,
		detailImg : ""
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {leisureNo : self.leisureNo};
			$.ajax({
                url : "leisureInfo.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.info;
                	self.info.imgPath = "../"+self.info.imgPath; 
                	self.detailImg = data.detailImg;
                	self.detailImg.imgPath = "../"+self.detailImg.imgPath;
                	self.fnCheckHeart();
                }
            }); 
		},
		fnCheckHeart : function(){
			var self = this;
			var param = {
				uId : self.uId,
				productKind : "LEISURE",
				productNo : self.leisureNo
			};
			$.ajax({
                url : "../../checkHeart.dox",
                dataType:"json",
                type : "POST",
                data : param,
                success : function(data) { 
                	// �ߺ��� ������ true
                	if(data.jjimCnt > 0){
                		self.isWished = true;
                	}
                }
            }); 
		},
		fnWish : function(leisureNo){
			var self = this;
			if(this.uId=="" || this.uId == null){
        		alert("�α��� �� �̿��� �����մϴ�.");
        		location.href="/login.do";
        		return;
        	} 
			var param = {leisureNo : leisureNo, uId:self.uId};
			$.ajax({
                url : "/leisure/jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ� �߰��Ǿ����ϴ�.");
                	self.isWished=true;
                	self.fnGetList();
                }
    
            });

		},
		fnDelWish : function(leisureNo){
			var self = this;
			var param = {leisureNo : leisureNo, uId:self.uId};
			$.ajax({
                url : "/leisure/jjimDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ��� �����Ǿ����ϴ�.");
                	self.isWished=false;
                	self.fnGetList();
                }
    
            });

		},
		fnCart : function(){
			var self = this;
			if(this.uId=="" || this.uId == null){
        		alert("�α��� �� �̿��� �����մϴ�.");
        		location.href="/login.do";
        		return;
        	} 
			
			if(!confirm("��ٱ��Ͽ� �����ðڽ��ϱ�?")){
				alert("��ҵǾ����ϴ�.");
				location.reload();
				return;
			}
			var param = {leisureNo : self.leisureNo, uId: self.uId}
			$.ajax({
                url : "/leisureAddCart.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�߰��Ǿ����ϴ�");
					location.reload();
                }
            }); 
			
		}
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	}// created
});
$(document).ready(function(){
    $('.detail_btn').click(function(){
        var detailWrap = $('.detail_wrap');
        if (detailWrap.css('height') === '400px') {
            detailWrap.css({
                height : 'auto'
            });
            $(this).html('�ݱ�');
        } else {
            detailWrap.css({
                height : '400px'
            });
            $(this).html('���ĺ���');
        }
    });
});
</script>