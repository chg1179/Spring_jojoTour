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
	.jjim{
		background-color : buttonface;
	}
    .jjim::after{
        content: ">";
        position: absolute;
        color: rgb(28, 111, 235);
        font-size: 30px;
        top: 0;
        right: 0;
    }
	*{
		margin: 0;
		padding: 0;
	}
	#my_jjim_container{
		margin: 50px 50px;
	}
	.my_jjim_box{
		display: flex;
		justify-content: center;
		width: 1000px;
		margin-top : 50px;
	}
	.my_jjim_box > div{
		width: 25%;
		border-top : 1px solid #686868;
		border-bottom : 1px solid #686868;
		border-right : 1px solid #ccc;
		height : 150px;
	}
	.my_jjim_box > div:last-child{
		border-right: none;
	}
	.my_jjim_box > div > p{
		text-align: center;
		margin-top: 20px;
		font-weight: bold;
		font-size: 20px;
		color: #414141;
	}
	.my_jjim_box > div > div{
		text-align: center;
		margin-top: 10px;
		font-weight: bold;
		margin-top: 60px;
		color : #5c5c5c;
	}
	@media (max-width : 1400px){
		.my_jjim_box{
			width: 600px;
		}
	}
	
	@media (max-width : 1000px){
		.my_jjim_box{
			width: 500px;
		}
	}
	.btn1{
	  background-color: white;
	  font-size: 12px;
	  border: lightgrey solid 1px;
	  padding: 7px;
	  border-radius: 5px;
	  cursor: pointer;
	  margin-left: auto;
	}
	.button-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
    margin-bottom: 50px;
	}
	  table {
	    border-collapse: collapse;
	    width: 100%;
	    float: left;
	    width : 1200px
	    
	  }
	  th, td {
	    border: 1px solid #686868;
	    padding: 8px;
	    text-align: center;
	  }
	  th {
	    background-color: #f2f2f2;
	    color: #414141;
	  }
	  .cart__list__orderbtn{
	  display: inline-block;
	  padding: 6px 12px;;
	  font-size: 10px;
	  font-weight: 400;
		border:1px solid #eee;
	  color: black;
	  border-radius: 5px;
	  cursor: pointer;
	  }
	  .cart__list__orderbtn:hover{
	  background-color : #E7AA8D; /* 호박색 (마우스 호버 시 색 변경) */
	  transform: scale(1.05);
	  color: white;
	  }
	  .cart__list__detail{
	  
	  }
</style>
</head>
<body>
<jsp:include page="../header.jsp" flush="true"></jsp:include>
<jsp:include page="my-page.jsp" flush="true"></jsp:include>
	<div id="app">
  <div id="my_jjim_container">
    <h2>찜목록</h2>
    <div class="button-container">
      <div> 
        <button @click="fnRemove" class="btn1">삭제하기</button>
      </div>
    </div>
    <table>
      <tr class="cart__list__detail">
      	<th><input type="checkbox" v-model="selectAll" @change="selectAllItems"></th>
        <th>상품정보</th>
        <th>찜한제품</th>
        <th>할인된 금액</th>
      </tr>
      <tr v-for="(item, index) in jjim" :key="index">
      	<td><input type="checkbox" v-model="selectItem" :value="item.productNo"></td>
        <td v-for="item in imgList">{{item.imgName}}
          <a @click="fnView(item.productNo)" href="javascript:;">
            {{item.productNo}}번
            <span v-if="item.productKind == 'STAY'"> {{item.roomName}}</span>
            <span v-if="item.productKind == 'RENT'"> {{item.rentName}}</span>
            <span v-if="item.productKind == 'LEISURE'"> {{item.leisureName}}</span>
          </a>
        </td>
        <td>
          <div v-if="item.productKind == 'STAY'">숙박</div>
          <div v-if="item.productKind == 'RENT'">렌트카</div>
          <div v-if="item.productKind == 'LEISURE'">레저</div>
        </td>
        <td>
          <div v-if="item.productKind == 'RENT'">
          <del>가격 : {{item.rentPrice}}</del>
          {{item.rentPrice*item.rentSales}}</div>
          <div v-if="item.productKind == 'STAY'">
          <del>가격 : {{item.roomPrice}}</del>
          {{item.roomPrice*item.roomSales}}</div>
          <div v-if="item.productKind == 'LEISURE'">
          <del>가격 : {{item.leisurePrice}}</del>
          {{item.leisurePrice*item.leisureSales}}</div>
          <button class="cart__list__orderbtn">주문하기</button>
        </td>
      </tr>
    </table>
  </div>
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		userId : "${sessionId}",
		jjim:[],
		selectItem : [],
		selectAll: false,
		imgList:[]
	},// data
	methods : {
		fnGetList : function(){
			var self = this;
			var param = {userId : self.userId};
			$.ajax({
                url : "/my/jjim.dox",
                dataType:"json",	
                type : "POST",
                data : param,
                success : function(data) { 
                	self.jjim = data.jjim;
                	console.log(self.jjim);
                }
            }); 
		},
		fnRemove : function(){
			var self = this;
        	if(!confirm("정말 삭제하시겠습니까?")){
        		return;
        	}
        	var noList = JSON.stringify(self.selectItem);
			var param = {selectItem : noList};
            $.ajax({
                url : "removeJjimCheck.dox",
                dataType:"json",	
                type : "POST", 
                data : param,
                success : function(data) { 
                	self.fnGetList();
                	self.selectItem = [];
                	alert("삭제되었습니다.");

                }
            }); 
		},
		fnView : function(){
				var self = this;
	    },
	       selectAllItems: function() {
	            var self = this;
	            if (self.selectAll) {
	                self.selectItem = self.jjim.map(item => item.productNo);
	            } else {
	                self.selectItem = [];
	            }
	        }
		
	}, // methods
	created : function() {
		var self = this;
		self.userId = "${sessionId}";
		self.fnGetList();
	}// created
});
</script>