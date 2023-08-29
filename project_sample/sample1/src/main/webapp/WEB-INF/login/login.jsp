   <%@ page language="java" contentType="text/html; charset=EUC-KR"
       pageEncoding="EUC-KR"%>
   <!DOCTYPE html>
   <html>
   <head>
   <script src="../js/jquery.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   <meta charset="EUC-KR">
   <title>로그인</title>
   <style>
   @import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
   body {
   font-family: 'Jeju Gothic', sans-serif;
   font-weight: lighter;
   }
       *{
           margin: 0;
           padding: 0;
       }
       h1{
             margin-bottom : 35px;
             font-size:3em;
       }
       a{
           text-decoration: none;
           color: inherit;
       }
       #login_container{
           display: flex;
           flex-direction: column;
           
           align-items: center;
           height: 90vh;
            background-color: #eee; 
            margin-top: 165px
/*            background-image:url('https://tvstore-phinf.pstatic.net/20201124_289/1606182617321ComBh_JPEG/00086.jpg');
             background-size: cover; */
       }
      .login_header {
          display: flex;
          justify-content: center;
          margin-bottom: 20px; /* 헤더와 로그인 박스 사이에 간격 추가 */
          color:#213555 ;
      }
       .login_box{
           background-color: white;
           width: 520px;
/*            border: 0.1px solid #213555; */
            margin: 0 auto;
            border-radius: 6px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2)
       }
       .login_tab{
           display: flex;
       }
       .login_tab label{
           display: block;
           cursor: pointer;
           box-sizing: border-box;
           margin-bottom: 20px;
           width: 100%;
           text-align: center;
           padding: 15px 0;
           /* border : 1px solid #213555; */
       }
       .login_tab label:last-child{
          border-right : none;
       }
       .login_tab input{
           display: none;
       }
       .login_tab label{
           background-color: #f8f9fa;
       }
       .login_tab input:checked + label{
             color : white;
           background-color: #213555;
       }
       .login_background{
           display: flex;
           align-items: center;
           justify-content: center;
           padding: 22px 28px;
       }
       .login_num, .login_id, .login_pwd{
           margin: 10px 0;
       }
      .login_back_inner div input {
          width: 300px;
          padding: 10px 23px;
          border-radius: 6px;
          border: 1px solid;
          outline: none;
              height: 20px;
      }
       .login_button{
          display : flex;
          justify-content: center;
       }
       .login_button button{
          width: 100%;
          background-color: #213555;
          border: none;
          color: white;
          height: 45px;
          border-radius: 6px;
          font-weight: 700;
          margin: 20px 0;
          cursor: pointer;
       }
       .login_a{
           display: flex;
           justify-content: space-between;
           margin-top: 10px;
           margin-bottom: 30px;
       }
       .fa-regular, .far {
          font-weight: 400;
          margin-right: 5px;
      }
      .fa-solid, .fas {
       font-weight: 900;
       margin-right: 5px;
   }
   body{
   background-color:#eee;
   }
   .login_main {
       text-align: center;
       width: 1100px;
       height: 650px;
        background-color: #f4f4f4; 
       padding: 50px 1px;
       border-radius: 6px;
       box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
   }
   
   .loading_active{
         position : absolute;
         top : 0;
         left : 0;
            display: flex;
            justify-content: center;
            align-items: center;
            width : 100%;
            height: 100%;
            background-color: rgba(211, 211, 211, 0.4);
            z-index : 1000;
        }
        .loading_active .loading{
            /* border: 1px solid black; */
            width: 50px;
            height: 50px;
            border-radius: 50%;
            position: absolute;
            top: 33%;
            left : 43%;
        }
        .loading_active span{
            display: inline-block;
            background-color: black;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            position: absolute;
            animation: load 1.6s linear infinite;
        }
        .loading_active span:nth-child(1){
            top: 0;
            left: calc(50% - 5px);
            animation-delay: 0s;
        }
        .loading_active span:nth-child(2){
            top: calc(15% - 1.5px);
            left: calc(85% - 8.5px);
            animation-delay: 0.2s;

        }
        .loading_active span:nth-child(3){
            top: calc(50% - 5px);
            left: calc(100% - 10px);
            animation-delay: 0.4s;
        }
        .loading_active span:nth-child(4){
            left: calc(85% - 8.5px);
            top: calc(85% - 8.5px);
            animation-delay: 0.6s;
        }
        .loading_active span:nth-child(5){
            top: calc(100% - 10px);
            left: calc(50% - 5px);
            animation-delay: 0.8s;
        }
        .loading_active span:nth-child(6){
            top: calc(85% - 8.5px);
            left: calc(15% - 1.5px);
            animation-delay: 1s;
        }
        .loading_active span:nth-child(7){
            top: calc(50% - 5px);
            left: 0;
            animation-delay: 1.2s;
        }
        .loading_active span:nth-child(8){
            top: calc(15% - 1.5px);
            left: calc(15% - 1.5px);
            animation-delay: 1.4s;
        }
        @keyframes load{
            0%{
                opacity: 0;
            }
            100%{
                opacity: 1;
            }
        }
        .loading_btn{
            display: none;
        }

   </style>
   </head>
   <body>
      <jsp:include page="../header.jsp" flush="true"></jsp:include>
      <div id="app">
          <div id="login_container">
         
                <span style="color:orange;">w e l c o m e</span>
                <h1 style="color:#213555;"><i class="fa-solid fa-plane-departure fa-bounce"></i>JOJO TOUR</h1>
              <div class="login_box">
                  <div class="login_tab">
                      <input type="radio" name="selectLogin" id="user" @input="checkStatus('U')" checked="checked">
                      <label for="user"  style="border-top-left-radius: 4px;">일반회원</label>
                      <input type="radio" name="selectLogin" id="host" @input="checkStatus('H')">
                      <label for="host">호스트</label>
                      <input type="radio" name="selectLogin" id="admin" @input="checkStatus('A')">
                      <label for="admin"  style="border-top-right-radius: 4px;">관리자</label>
                  </div>
                  <div class="login_background">
                      <div class="login_back_inner">
                          
                          <div class="login_id_pw">
                          <span>
                          <i class="fa-solid fa-user"></i>
                          </span>
                              <label><input v-model="userId" placeholder="아이디"></label>
                          </div>
                          <div class="login_pwd">
                          <span>
                          <i class="fa-solid fa-lock"></i>
                          </span>
                              <label><input type="password" v-model="pwd" placeholder="패스워드"  @keyup.enter="fnLogin"></label>
                          </div>
                          
                          <div class="login_button">
                              <button @click="fnLogin">로그인</button>
                          </div>
                          <div class="login_a">
                              <a href="javascript:;" @click="fnSearch">아이디/비밀번호 찾기</a>
                              <a href="javascript:;" @click="fnJoin">회원가입</a>
                          </div>
                      </div>
                  </div>
              </div>
         
          </div>
          
       <div class="loading_active">
           <div class="loading">
               <span></span>
               <span></span>
               <span></span>
               <span></span>
               <span></span>
               <span></span>
               <span></span>
               <span></span>
               <img src="../img/cart/loading.png" style="position: absolute; top: -34px; left: -27px; z-index: -1">
           </div>
       </div>
    <div class="loading_btn">사라져</div>
      </div>
      <jsp:include page="../footer.jsp" flush="true"></jsp:include>
   </body>
   </html>
   <script>
   var app = new Vue({
      el : '#app',
      data : {
         list : [],
         userId : "",
         pwd : "",
         status: "",
         user : ""
      },// data
      methods : {
         fnGetList : function(){
            var self = this;
            var param = {};
            $.ajax({
                   url : "loginCheck.dox",
                   dataType:"json",   
                   type : "POST",
                   data : param,
                   success : function(data) { 
                      self.status = "U";
                   }
               }); 
         },
         fnLogin : function(){
            var self = this;
            var param = {userId : self.userId, pwd : self.pwd, status : self.status};
            $.ajax({
                   url : "login.dox",
                   dataType:"json",    
                   type : "POST",
                   data : param,
                   success : function(data) {
                      console.log(data);
                      if(data.success){
                         alert(data.message);
                         location.href="main.do"; 
                      } else {
                         alert(data.message);
                      }
                   }
               }); 
         },
         fnSearch : function(){
            location.href='id-search.do';
         },
         fnJoin : function(){
            location.href='join/select.do';
         },
         checkStatus : function(status){ //라디오박스를 선택할 때 마다 status 값 변경
              var self = this;
              self.status = status;
           }
      }, // methods
      created : function() {
         var self = this;
          self.fnGetList();
      }// created
   });
    $(document).ready(function(){
       setTimeout(function(){
           $('.loading_btn').click(function(){
           $('.loading_active').fadeOut();
       });
           $('.loading_btn').trigger('click');
       },2500);
   }); 
   </script>