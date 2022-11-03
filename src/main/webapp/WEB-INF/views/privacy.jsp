<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>

<html>
<head>
    <title>개인정보 처리방침</title>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    .thisPage_title {
        margin-bottom: 50px;
    }

</style>
<body>
<%--    내비게이션--%>
<nav>
    <ul class="navi">
        <li class="naviMenu"><a href="<c:url value='/'/>">HOME</a></li>
        <li class="naviMenu"><a href="<c:url value='/pic/list'/>">Photos</a></li>
        <li class="naviMenu"><a href="<c:url value='/pic/list'/>">illustrations</a></li>
        <li class="naviMenu"><a href="<c:url value='/board/list'/>">자유게시판</a></li>
        <li class="naviMenu"><a href="<c:url value='/login/login'/>">${isLogined? 'Logout':'Login'}</a></li>
        <li class="naviMenu" ${isLogined? 'hidden="hidden"':''}><a
                href="<c:url value='/register/form'/>">${isLogined? '':'sign up'}</a></li>
        <li class="naviMenu" id="naviMenu_sessionId">${sessionScope.id}${isLogined?'님':''}</li>
    </ul>
</nav>

<%--    본문--%>
<article>
    <div class="thisPage_title">개인정보 처리방침</div>
    <p>이 개인정보 처리방침은 수집하는 항목, 정보를 수집하는 이유, 정보를 관리, 삭제하는 방식에 대한 이해를 돕기 위한 것입니다.</p>

    <p>발효일: 2022년 9월 15일</p>

    <p><b>1. 개인정보 수집 항목</b> <br>
        아이디, 비밀번호, 이름, 이메일, 쿠키, 서비스 이용 기록</p>


    <p><b>2. 개인정보를 수집하는 이유</b><br>
        본 사이트는 포트폴리오 제출 목적으로 만들어진 사이트로서
        더 나은 포트폴리오 작성을 위해 개인정보가 이용될 수 있습니다.</p>


    <p><b>3. 개인정보 수집 방법</b><br>
        회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우
        해당 개인정보를 수집합니다.
        고객센터(nasb258@gmail.com)를 통한 상담 과정에서 웹페이지, 메일, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.</p>


    <p><b>4. 개인정보 파기</b><br>
        회원 가입자로부터 수집 받은 개인 정보는 상업적인 목적으로 쓰이거나
        제 3자에게 제공하지 않으며 목적(포트폴리오 제출, 평가) 달성 후에는 지체없이 파기합니다.</p>


    <p><b>5. 개인정보 관리</b><br>
        개인정보 제공에 대한 우려를 이해하고 있기에 회원가입 없이 사이트를 구경할 수 있는
        샘플 아이디와 비밀번호를 제공하고 있습니다.</p>
</article>

<%--    푸터--%>
<footer>
    <a href="<c:url value='/about/website'/>">사이트 소개</a>
    <a href="<c:url value='/about/terms'/>">이용약관</a>
    <a href="<c:url value="/about/privacy"/>">개인정보 처리방침</a>
    <a href="<c:url value="/"/>">고객센터: nasb258@gmail.com</a>
</footer>

</body>
</html>
