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
		<button @click="fnUser"> ȸ�� ����</button>
		<button @click="fnHost"> ȣ��Ʈ ����</button>
	</div>
</body>
</html>
<script>
        var app = new Vue({
            el: '#app',
            methods: {
                fnUser: function() {
                    // ȸ�� ���� �������� �̵�
                    window.location.href = "/user-list.do";
                },
                fnHost: function() {
                    // ȣ��Ʈ ���� �������� �̵�
                    window.location.href = "/host-list.do";
                }
            }
        });
    </script>
</body>