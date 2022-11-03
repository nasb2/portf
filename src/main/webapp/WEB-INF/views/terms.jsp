<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<html>
<head>
    <title>이용약관</title>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    .thisPage_title {
        margin-bottom: 50px;
    }
</style>
<body>
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
    <div class="thisPage_title">이용약관</div>
    <div>
        <p>사이트를 자유롭게 이용하셔도 되지만 <b>악의적인 사용</b>을 자제해주세요. T_T</p>
        <p>부정적인 사용 예시) </p>
        <p>반복적인 회원가입</p>
        <p>반복적인 글쓰기</p>
        <p>게시판 비속어 사용 등</p>
    </div>

</article>

<%--푸터--%>
<footer>
    <a href="<c:url value='/about/website'/>">사이트 소개</a>
    <a href="<c:url value='/about/terms'/>">이용약관</a>
    <a href="<c:url value="/about/privacy"/>">개인정보 처리방침</a>
    <a href="<c:url value=''/>">고객센터: nasb258@gmail.com</a>
</footer>
</body>
</html>
