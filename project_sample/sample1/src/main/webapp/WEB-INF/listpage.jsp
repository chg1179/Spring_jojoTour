<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="EUC-KR">
<title>List Page</title>
<style>
	
</style>
</head>
<body>
	<div id="app">
		<button @click="fnUser"> 회원 관리</button>
		<button @click="fnHost"> 호스트 관리</button>
	</div>
</body>
</html>
<script>
        var app = new Vue({
            el: '#app',
            methods: {
                fnUser: function() {
                    // 회원 관리 페이지로 이동
                    window.location.href = "/user-list.do";
                },
                fnHost: function() {
                    // 호스트 관리 페이지로 이동
                    window.location.href = "/host-list.do";
                }
            }
        });
    </script>
</body>