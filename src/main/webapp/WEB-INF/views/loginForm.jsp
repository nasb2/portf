<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<c:set var="isCookie" value="${not empty cookie.id.value}"/>
<html>
<head>
    <title>Free Download: Pick your Best Photos!</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    form {
        display: flex;
        flex-direction: column;
        width: 1000px;
        margin: 100px auto;
        text-align: center;
    }

    #form_id {
        float: left;
        width: 660px;
        margin-top: 10px;
    }

    #form_pwd {
        float: left;
        width: 675px;
    }

    #id, #pwd {
        width: 400px;
        height: 40px;
        margin: 5px 0 20px 0;
        padding-left: 1px;
        border: 1px solid #b6b7b9;
        border-radius: 8px;
        font-size: 1em;
    }

    #pwd {
        margin: 5px 0 10px 129px;
    }

    button {
        width: 400px;
        height: 50px;
        margin: 0 auto;
        font-size: 15px;
    }

    button:hover {
        font-size: larger;
    }

    input[type=checkbox] {
        position: relative;
        top: 10px;
        width: 30px;
        height: 30px;
    }

    #errorMsg {
        margin: 5px 0 0 100px;
        color: red;
        font-size: 17px;
        font-weight: bold;
    }
</style>

<body>

<script>
    let msg = "<c:out value='${msg}'/>";
    if (msg === "LOGIN_REQ") {
        alert("로그인이 필요합니다.");
    }
</script>

<%--내비게이션--%>
<nav>
    <ul class="navi">
        <li class="naviMenu"><a href="<c:url value='/'/>">HOME</a></li>
        <li class="naviMenu"><a href="<c:url value='/pic/list'/>">Photos</a></li>
        <li class="naviMenu"><a href="<c:url value='/pic/list'/>">illustrations</a></li>
        <li class="naviMenu"><a href="<c:url value='/board/list'/>">자유게시판</a></li>
        <li class="naviMenu"><a href="<c:url value='/login/login'/>">${isLogined? 'Logout' : 'Login'}</a></li>
        <li class="naviMenu" ${isLogined? 'hidden="hidden"':''}><a
                href="<c:url value='/register/form'/>">${isLogined? '':'sign up'}</a></li>
        <li class="naviMenu" id="naviMenu_sessionId">${sessionScope.id}${isLogined?'님':''}</li>
    </ul>
</nav>

<%--본문--%>
<article>
    <div class="thisPage_title">로그인</div>
    <form action="<c:url value='/login/login'/>" method="POST">
        <div class="form_notice">! 아이디와 비밀번호를 정확하게 입력해주세요.
        </div>
        <label for="id">
            <div id="form_id">아이디</div>
            <br>
            <input type="text" id="id" name="id" placeholder=" 아이디를 입력하세요" maxlength="13" required><br>
        </label>
        <label for="pwd">
            <div id="form_pwd">비밀번호</div>
            <br>
            <input type="password" id="pwd" name="pwd" placeholder=" 비밀번호를 입력하세요" maxlength="13" required>
            <span id="login_remember"><input type="checkbox" name="rememberId" ${isCookie? "checked='checked'":""}>아이디 기억</span>
            <div id="errorMsg" style="display: none">아이디 또는 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.</div>
        </label>
        <label>
            <input type="text" name="url" value="${requestScope.url}" hidden>
        </label>
        <label>
            <input type="text" name="bno" value="${param.bno}" hidden>
        </label>
        <label>
            <input type="text" name="pno" value="${param.pno}" hidden>
        </label><br>
        <button type="submit" id="loginBtn">로그인</button>
        <br>
        <div><a href="<c:url value='/register/form'/>">잠깐! 아직 회원이 아니신가요?</a></div>

    </form>
</article>

<%--푸터--%>
<footer>
    <a href="<c:url value='/about/website'/>">사이트 소개</a>
    <a href="<c:url value='/about/terms'/>">이용약관</a>
    <a href="<c:url value="/about/privacy"/>">개인정보 처리방침</a>
    <a href="<c:url value=''/>">고객센터: nasb258@gmail.com</a>
</footer>

<%--자바스크립트--%>
<script>
    $(document).ready(function () {

        if (${isCookie}) {
            $("#id").attr("value", "${cookie.id.value}");
        }

        if (${msg=='loginFailed'}) {
            $("#errorMsg").css("display", "block");

        }
    });

</script>

</body>
</html>
