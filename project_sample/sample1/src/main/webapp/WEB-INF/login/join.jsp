<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="EUC-KR">
<title>ȸ�� ����</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	body {
	font-family: 'Jeju Gothic', sans-serif;
	font-weight: lighter;
	}
    #join_container{
        height: 100vh;
        background-color: #eee;
    }
    .join_inner_con{
        background-color: #213555;
        margin-top: 100px;
        margin-bottom: 100px;
        border : 1px solid #213555;
         border-top-right-radius: 6px;
   		 border-top-left-radius: 6px;
   		 box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }
    .join_inner_con input{
	    width: 400px;
	    height: 35px;
	    margin: 10px 10px;
	    outline: none;
	    border: 1px solid;
	    padding: 5px 10px;
	    border-radius: 6PX;
	    margin-bottom: 5px;
	    border : 1px solid #213555;
    }
    .join_inner_box{
        background-color: #f5f6f7;
        padding-top : 20px;
    }
    .join_title{
        text-align: center;
        margin: 15px;
    }
    .join_check_wrap{
        position: relative;
        display: flex;
        align-items: center;
        margin: 0px 25px;
    }
    .join_check{
	position: absolute;
    bottom: -15px;
    font-size: 16px;
    width: 250px;
    margin-left: 10px;
    left: 22px;
    }

    #join_container, .join_tab, .join_addr, .join_btn{
        display: flex;
        justify-content: space-around;
        align-items: center;
    }
    .join_tab input{
        display: none;
    }
    .join_btn{
       padding-bottom: 5px;
    }
    .join_btn button{
        width: 200px;
        margin: 5px 0;
        outline: none;
        border: none;
        background-color: rgb(82, 82, 82);
        height: 30px;
        border-radius: 6px;
        color: #fff;
        font-weight: 700;
        cursor: pointer;
            padding: 20px;
    padding-bottom: 35px;
    }
    .join_btn button:hover{
        background-color: #FFA41B;
    }
    .join_inner_main{
    
    }
</style>
</head>
<body>
   <jsp:include page="../header.jsp" flush="true"></jsp:include>
   <div id="app">
       <div id="join_container">
       		<div class="join_inner_main">
           <div class="join_inner_con">
           
               <h1 class="join_title"><span style="color : white;"><i class="fa-regular fa-paper-plane"></i> JOJO TOUR</span></h1>
               <div class="join_inner_box">
                   <div class="join_input_wrap">
                       <div class="join_check_wrap">
                           <span><i class="fa-solid fa-user"></i> </span>
                           <label><input type="text" v-model="user.userId" @keyup="fnCheck" maxlength="15" placeholder="���̵�"></label>
                           <span class="join_check" v-if="user.userId != ''">{{message}}</span>
                       </div>
                           <div style="margin-left:25px"><i class="fa-solid fa-lock"></i><label><input type="password" v-model="user.pw1" maxlength="15" placeholder="��й�ȣ"></label></div>
                           <div style="margin-left:25px"><i class="fa-solid fa-lock"></i><label><input type="password" v-model="user.pw2" maxlength="15" placeholder="��й�ȣ Ȯ��"></label></div><br><br>
                           <div style="margin-left:25px"><i class="fa-regular fa-user"></i><label><input type="text" v-model="user.name" maxlength="8" placeholder="�̸�"></label></div>
                           <div style="margin-left:25px"><i class="fa-regular fa-user"></i><label><input type="text" v-model="user.nickName" maxlength="20" placeholder="�г���"></label></div>
                           <div style="margin-left:25px"><i class="fa-regular fa-calendar-check"></i><label><input type="date" v-model="user.birth" id="birth"></label></div>
                           <div style="margin-left:26px"><i class="fa-solid fa-mobile-screen"></i><label><input type="text" v-model="user.phone" maxlength="11" id ="phone" placeholder="�ڵ��� ��ȣ"></label></div>
                           <div style="margin-left:22px"><i class="fa-regular fa-envelope"></i><label><input type="text" v-model="user.email" maxlength="30" placeholder="�̸���"></label></div>
   
                           
                               
                           <div><label class="join_btn" style="margin-top: 16px"><button @click="fnSearchAddr">�ּ� �˻�</button></label></div>
                           <div v-if="user.addr != ''" style="margin-left:25px"><i class="fa-solid fa-location-dot"></i><label><input disabled type="text" v-model="user.addr"></label></div>
                           <div v-if="user.zipNo != ''" style="margin-left:25px"><i class="fa-solid fa-location-dot"></i><label><input disabled type="text" v-model="user.zipNo"></label></div>
                           <div v-if="user.addrDetail != ''" style="margin-left:25px"><i class="fa-solid fa-location-dot"></i><label><input type="text" v-model="user.addrDetail"></label></div>
                           
                   </div>
                   <div class="join_btn"><button @click="fnJoin" style="margin-bottom:25px">�����ϱ�</button></div>
               </div>
           </div>
           </div>
       </div>
   </div>
   <jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>
<script>
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	app.fnResult(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo);
} 
var app = new Vue({
	el : '#app',
	data : {
		user : {
			userId : "",
			pw1 : "",
			pw2 : "",
			name : "",
			phone : "",
			birth : "",
			addr : "",
			addrDetail : "",
			nickName : "",
			email : "",
			zipNo : "",
			status : "${map.status}"
		},
		upAndDown : "${map.upAndDown}",
		joinFlg : false,
		message : ""
	},// data
	methods : {
		fnJoin : function(){
			var self = this;
			var birth = document.querySelector('#birth').value;
			var age = birth.split("-");
			var now = new Date();
			var year =  now.getFullYear() - parseInt(age[0],10);
	        var month = (now.getMonth()+1) - parseInt(age[1],10);
	        var day = parseInt(age[2],10);
	        self.user.phone = self.user.phone.replaceAll("-", "");
			if(self.user.userId == ""){
				alert("���̵� �Է��ϼ���.");
				return;
			}
			if (self.user.userId.match(/\s/)) {
			    alert("���̵� ������ ������ �� �����ϴ�.");
			    return;
			}
		    var regex = /^[a-zA-Z0-9]+$/;
		    if (!regex.test(self.user.userId)) {
			    alert("���̵�� �����ڿ� ���ڸ��Է��� �� �ֽ��ϴ�.");
		        self.joinFlg = false;
		        return;
		    }
			if(self.user.pw1 == ""){
				alert("�н����带 �Է��ϼ���.");
				return;
			}
			if(self.user.pw1.length < 8){
				alert("��й�ȣ�� 8�ڸ� �̻� �Է��ϼ���.");
				return;
			}
			if (self.user.pw1.match(/\s/)) {
			    alert("��й�ȣ�� ������ ������ �� �����ϴ�.");
			    return;
			}
			if(self.user.pw1 != self.user.pw2){
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				return;
			}

			if(self.user.name == ""){
				alert("�̸��� �Է��ϼ���.");
				return;
			}
			if (self.user.name.match(/\s/)) {
			    alert("�̸��� ������ ������ �� �����ϴ�.");
			    return;
			}
			if (self.user.nickName.match(/\s/)) {
			    alert("�г��ӿ� ������ ������ �� �����ϴ�.");
			    return;
			}
			if(self.user.birth == ""){
				alert("��������� �Է��ϼ���.");
				return;
			}
	        if(month < 0 || (month == 0 && now.getDate() <= day)){
	              year--;
	          }
	        if(self.upAndDown == "up"){
		        if(year < 14){
		            alert("�� 14�� �̻� ������ �����մϴ�.");
		            return;
		         }
	        } else if(self.upAndDown == "down"){
		        if(year >= 14){
		            alert("�� 14�� �̸��� ������ �����մϴ�.");
		            return;
		         }
	        }
			if(self.user.addr == ""){
				alert("�ּҸ� �Է��ϼ���.");
				return;
			}
			
			if(self.user.phone == ""){
				alert("�ڵ��� ��ȣ�� �Է��ϼ���.");
				return;
			}
			var regex = new RegExp(/^[0-9]+$/);
			if(!regex.test(self.user.phone)){
				alert("����ó�� ���ڸ� �Է����ּ���.");
				return;
			}
			
			if(self.user.email == ""){
				alert("�̸��� �ּҸ� �Է��ϼ���.");
				return;
			}
			regex = new RegExp(/^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/);
			if (!regex.test(self.user.email)) {
			    alert("�̸��� �ּҸ� ��Ȯ�ϰ� �Է��ϼ���.");
			    return;
			}
			var nparmap = { userId: self.user.userId , nickName : self.user.nickName, email : self.user.email};
		    $.ajax({
		        url: "check.dox",
		        dataType: "json",    
		        type: "POST", 
		        data: nparmap,
		        success: function(data) {
		            if (data.cnt > 0) {
		                alert("�ߺ��� ���̵� �ֽ��ϴ�. �ٸ� ���̵� �������ּ���.");
		                return;
		            } else if(data.nickCnt > 0){
		                alert("�ߺ��� �г����� �ֽ��ϴ�. �ٸ� �г����� �������ּ���.");
		                return;
		            } else if(data.emailCnt > 0){
		                alert("�ߺ��� �̸����� �ֽ��ϴ�. �ٸ� �̸����� �������ּ���.");
		                return;
		            } else {
		                var nparmap = self.user;
		                $.ajax({
		                    url: "add.dox",
		                    dataType: "json",    
		                    type: "POST", 
		                    data: nparmap,
		                    success: function(data) {
		                        alert(self.user.nickName + "�� ������ ȯ���մϴ�.\n ����Ʈ 5,000���� �����Ǿ����ϴ�.");
		                        location.href = "main.do";
		                    }
		                });
		            }
		        }
		    });
		},
		fnCheck : function(){
			var self = this;
		    var userId = self.user.userId;
		    var regex = /^[a-zA-Z0-9]+$/;

		    if (!regex.test(userId)) {
		        self.message = "�����ڿ� ���ڸ� �Է� �����մϴ�.";
		        self.joinFlg = false;
		        return;
		    }
		    if (userId.match(/\s/)) {
		        self.message = "������ ������ �� �����ϴ�.";
		        self.joinFlg = false;
		        return;
		    }
			var nparmap = {userId : self.user.userId};
            $.ajax({
                url : "check.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	if(data.cnt > 0){
                		self.message = "�ߺ��� ���̵� ����";
                	} else {
                		self.message = "��� ����";
                		self.joinFlg = true;
                	}
                }
            });
		},
		fnSearchAddr : function (){
			var self = this;
    		var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    		window.open("addr.do", "test", option);
		},
		fnResult : function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		var self = this;
    		self.user.addr = roadAddrPart1;
    		self.user.addrDetail = addrDetail;
    		self.user.zipNo = zipNo;
    		// �ܼ� ���� �� ���� �� ���� �ʿ��Ѱ� ������ ���� �˴ϴ�.
    		console.log(roadFullAddr);
    		console.log(roadAddrPart1);
    		console.log(addrDetail);
    		console.log(engAddr);
    		console.log(zipNo);
    	}
	}, // methods
	created : function() {
		var self = this;
	}// created
});
</script>