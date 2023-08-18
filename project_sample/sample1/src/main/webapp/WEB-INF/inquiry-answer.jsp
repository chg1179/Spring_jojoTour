<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
    table {
        border: 1px solid black;
        border-collapse: collapse;
        text-align: center;
    }
    th, td {
        border: 1px solid black;
        padding: 5px 10px;
    }
</style>
</head>
<body>
    <div id="app">
        <label>제목 : <input v-model="info.iTitle"></label>
        <div>
            <br>
            <vue-editor v-model="info.iContent"></vue-editor>
        </div>
        <br>
        <button @click="fnAdd">등록</button>
        
        <ul>
            <li v-for="item in list" :key="item.iNo">
                {{ item.iTitle }}
                <button @click="toggleReplyForm(item.iNo)">답글 달기</button>
                <div v-if="showReplyForm === item.iNo">
                    <input type="text" v-model="newReply" placeholder="답글 내용">
                    <button @click="addReply(item.iNo, item.parentNo)">답글 등록</button>
                </div>
                <ul>
                    <li v-for="reply in item.replies" :key="reply.iNo">
                        {{ reply.title }}
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>
<script>
console.log(Vue);
Vue.use(Vue2Editor);
const VueEditor = Vue2Editor.VueEditor;
var app = new Vue({
    el: '#app',
    data: {
        list: [],
        uId: "${sessionId}",
        iNo: "${map.iNo}",
        info: {
            iTitle: "<답변완료>",
            iContent: "항상 감사합니다^^"
        },
        parentNo: "",
        newReply: '', // 새 답글 내용
        showReplyForm: null
    },
    components: {VueEditor},
    methods: {
        fnAdd: function () {
            var self = this;
            var param = self.info;
            param.uId = self.uId;
            param.parentNo = self.parentNo;
            $.ajax({
                url: "answer.dox",
                dataType: "json",
                type: "POST",
                data: param,
                success: function (data) {
                    alert("등록 완료");
                    location.href = "list.do";
                }
            });
        },
        fnGetList: function () {
            var self = this;
            var param = {iNo: self.iNo, kind: "UPDATE"};
            $.ajax({
                url: "view.dox",
                dataType: "json",
                type: "POST",
                data: param,
                success: function (data) {
                    self.info = data.info;
                    self.parentNo = data.info.iNo;
                }
            });
        },
        toggleReplyForm(postId) {
            this.showReplyForm = (this.showReplyForm === postId) ? null : postId;
            this.newReply = ''; // 답글 폼을 열 때마다 초기화
        },
        addReply(postId, iNo) {
            if (this.newReply === '') {
                return; // 빈 답글은 등록하지 않음
            }
            // 서버에 답글 추가 요청을 보내는 코드
            // 여기서는 간략히 처리한다고 가정
            this.list.push({
                iNo: this.list.length + 1,
                iNo: iNo,
                iTitle: this.newReply,
                replies: []
            });
            this.newReply = ''; // 답글 등록 후 초기화
        }
    }, // methods
    created: function () {
        var self = this;
        if (self.iNo != "") {
            self.fnGetList();
        }
    }
});
</script>