<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-1.12.4.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../css/stay/stay-main.css" rel="stylesheet"/>
<meta charset="EUC-KR">
<title>���� ������</title>

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
		font-family: 'Jeju Gothic', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f2f2f2;
    }
	a{
		text-decoration: none;
		color: red;
	}
	.stay-name a{
		color: black;
		cursor: pointer;
	}
	/* ���� ��Ÿ�� */
	.banner_box {
		background: url(../../img/stay/background_img_stay.jpg) no-repeat;
		background-size: cover;
		height: 444px;
		position: relative;
	}
	
	.banner_text {
		text-align: center;
		font-size: 40px;
		font-weight: 400px;
		line-height: 400px;
		color: #fff;
		margin: 10px;
	}
	
	.banner_img {
		display: flex;
		justify-content: center;
		margin-bottom: 50px;
	}
	
	.banner_img>img {
		width: 600px;
	}
	
	.banner_start {
		text-align: center;
		font-weight: 700;
		color: #fff;
		margin-bottom: 30px;
	}
	
	.banner_question {
		width: 200px;
		height: 50px;
		margin: 0 auto;
		display: block;
		background-image: url(../img/main/icon_question.svg);
		background-repeat: no-repeat;
		background-color: #F86F03;
		background-position: 10px;
		border: none;
		color: #fff;
		font-size: 20px;
		cursor: pointer;
	}
	
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"></jsp:include>
<div id="app">
	<div class="banner_box">
		<p v-if="stayKind == ''" class="banner_text">����</p>
		<p v-else-if="stayKind == 'HOTEL'" class="banner_text">ȣ��</p>
		<p v-else-if="stayKind == 'MOTEL'" class="banner_text">����</p>
		<p v-else-if="stayKind == 'PENSION'" class="banner_text">���</p>
		<p v-else-if="stayKind == 'GUEST'" class="banner_text">�Խ�Ʈ�Ͽ콺</p>
		<p v-else class="banner_text">ķ��</p>
	</div>
	<div class="stay-container">
		<div class="filter">
		
			<h2><i class="fa-solid fa-filter"></i> ������</h2>
            <div class="btn-wrap">
                <span><button @click="fnReset">�ʱ�ȭ</button></span> 
            </div>
    
            <div class="stay-search">
                <h4>�˻�</h4>
                <div class="name-input">
                    <input style="font-family: 'Jeju Gothic', sans-serif;" type="text" v-model="stayKeyword" placeholder="�˻� Ű���带 �Է����ּ���" @input="fnSearch">
                </div>
            </div>

            <div class="service-list">
            	<h4>���ǽü�</h4>
                <div v-for="item in serviceList">
                    <label><input type="checkbox" v-model="selectServiceList" :value="item.serviceNo" @change="fnSearch">{{item.serviceName}}</label>
                </div>
            </div>
		</div>
		<div class="stay-list-con">
			<div class="stay-type">
	            <select style="font-family: 'Jeju Gothic', sans-serif;" v-model="stayKind" @change="fnSearch">
	                <option value="" selected disabled hidden>::��ü::</option>
	                <option value="">::��ü::</option>
	                <option value="HOTEL">ȣ��</option>
	                <option value="MOTEL">����</option>
	                <option value="PENSION">���</option>
	                <option value="GUEST">�Խ�Ʈ�Ͽ콺</option>
	                <option value="CAMPING">ķ��</option>
	            </select>
       		</div>
            <div class="stay-list"  v-if ="stayKind == ''" v-for="item in list">
                <div class="stay-img-box">
				    <a @click="fnDetail(item.stayNo)">
				        <div class="image-wrapper">
				            <img :src="item.imgPath" alt="�����̹���">
				        </div>
				    </a>
				</div>
                
                <div class="stay-info">
                	<span class="caption">�ǽð� ����</span>
                   	<p class="stay-name" >
                   		<a @click="fnDetail(item.stayNo)">{{item.stayName}}</a>
                   	</p>
                    <p class="stay-address">
	                    {{item.cName}} | {{item.sAddr}}
                    </p>
                     <!-- ���ϱ� -->
                    <span v-if="item.jjimcheck > 0">
		               <a @click="fnJjimDel(item.stayNo)" href="javascript:;">
		               	  <!-- ������Ʈ -->
		                  <i class="fa-solid fa-heart"></i>	
		               </a>
		            </span>
		            <span v-else-if="item.jjimcheck != 1">
		               <a @click="fnJjim(item.stayNo)" href="javascript:;">
		               	  <!-- ����Ʈ -->
		                  <i class="fa-regular fa-heart"></i>
		               </a>
		            </span>
                    <div class="stay-price">
	                    <p>{{item.minPrice | comma }}<span style="font-size:18px; font-weight: normal;">��~</span></p>
	                    <p style="font-weight: normal; font-size:15px; color: #b3b3b3;">(����/����� ����)</p>
                    </div>
                </div>
               	
            </div>
            <div class="stay-list"  v-if ="stayKind == item.stayKind" v-for="item in list">
                <div class="stay-img-box">
				    <a @click="fnDetail(item.stayNo)">
				        <div class="image-wrapper">
				            <img :src="item.imgPath" alt="�����̹���">
				        </div>
				    </a>
				</div>
               <div class="stay-info">
                	<span class="caption">�ǽð� ����</span>
                   	<p class="stay-name">{{item.stayName}}</p>
                    <p class="stay-address">
	                    {{item.cName}} | {{item.sAddr}}
                    </p>
                    <!-- ���ϱ� -->
                    <span v-if="item.jjimcheck == 1">
		               <a @click="fnJjim(item.stayNo)" href="javascript:;">
		               	  <!-- ������Ʈ -->
		                  <i class="fa-solid fa-heart"></i>	
		                  
		               </a>
		            </span>
		            <span v-else>
		               <a @click="fnJjimDel(item.stayNo)" href="javascript:;">
		               	  <!-- ����Ʈ -->
		                  <i class="fa-regular fa-heart"></i>
		               </a>
		            </span>
                    <div class="stay-price">
	                    <p>{{item.minPrice | comma }}<span style="font-size:18px; font-weight: normal;">��~</span></p>
	                    <p style="font-weight: normal; font-size:15px; color: #b3b3b3;">(����/����� ����)</p>
                    </div>
                </div>
            </div>
             <div v-if="list.length == 0" class="empty-list-placeholder">
		        <!-- �� ��Ͽ� �÷��̽�Ȧ�� ���� -->
		        ����� �����ϴ�.
		    </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</html>
<script>
Vue.filter('comma', function(value) {
	  if (!value) return '';
	  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	});
var app = new Vue({
	el : '#app',
	data : {
		serviceList : [],
		list : [],
		selectServiceList : [],
		stayKeyword : "",
		info : {},
		stayKind : "${map.stayKind}",
		uId : "${sessionId}",
		imgList : []
	},// data
	methods : {
		// ���� ����Ʈ 
		fnGetList : function(){
			var self = this;
			var param = {stayKeyword : self.stayKeyword, uId : self.uId, stayNo : self.stayNo};
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                	console.log(self.list);
                	
                	self.serviceList = data.serviceList;
                	console.log(self.serviceList);
                	
                }
            }); 
		},
		fnGetInfo : function(){
			var self = this;
			var param = {};
			$.ajax({
                url : "stayView.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.info = data.stayInfo;
                }
            }); 
		},
		
		fnDetail : function(stayNo){
			var self = this;
			console.log(stayNo);
			$.pageChange("/stay/view.do", {stayNo : stayNo , productKind : "STAY"}); 
		},
		fnReset : function(){
			var self = this;
			self.stayKeyword = "";
			self.selectServiceList = [];
			self.fnSearch();
		},
		fnSearch : function(){
			var self = this;
			var noServiceList = JSON.stringify(self.selectServiceList);
			var param = {
				stayKeyword : self.stayKeyword,
				selectServiceList : noServiceList
			};
			console.log(self.selectServiceList);
			console.log(self.list);
			$.ajax({
                url : "stayList.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.list = data.stayList;
                }
            }); 
		},
		fnJjim : function(stayNo){
			var self = this;
			if(self.uId == ""){
				alert("�α��� �� �̿� ������ �����Դϴ�.");
				return;
			}
			var param = {stayNo : stayNo, uId : self.uId};
			console.log(stayNo);
			$.ajax({
                url : "jjimAdd.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ��Ͽ� �߰��Ǿ����ϴ�.");
                	console.log(stayNo);
                	self.fnGetList();
                }
            }); 
		},
		fnJjimDel : function(stayNo){
			var self = this;
			var param = {stayNo : stayNo, uId : self.uId};
			console.log(stayNo);
			$.ajax({
                url : "jjimDel.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	alert("�� ���� �Ǿ����ϴ�.");
                	console.log(stayNo);
                	self.fnGetList();
                }
            }); 
		},
		
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
	//	self.fnGetImgList();
	}// created
});


$(document).ready(function(){
    $('.slide_btn').click(function(){
        $('#slide_wrap').animate({
            left: -600
        }, function(){
            $('#slide_wrap').css({left: 0}).find('img').first().appendTo('#slide_wrap');
        });
    });
    function time(){
        auto = setInterval(function(){
            $('.slide_btn').trigger('click');
        },3000);
    }    
    time();
});

</script>