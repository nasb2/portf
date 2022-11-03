<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>

<html>
<head>
    <title>사이트 소개</title>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    #introduction {
        margin-top: 50px;
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
    <div class="thisPage_title">사이트 소개</div>
    <div id="introduction">

        <p>본 사이트는 픽사베이(<a href="https://pixabay.com">https://pixabay.com/</a>),
            게티이미지뱅크(<a href="https://www.gettyimagesbank.com/">https://www.gettyimagesbank.com/</a>) 와 같은
            프리 저작권 이미지 공유 사이트 입니다.
            사이트 내 사진, 일러스트는 픽사베이에서 이미지 소스를 가져와 2차 배포하였으며 픽사베이 사이트에서
            이미지 저작권으로부터 자유로움을 확인하였습니다.</p>

        <p>블로그 포스팅, 회사 PPT 작성 ... 우리는 많은 상황에서 사진이나 이미지를 필요로 합니다.
            특히 온라인 뉴스 기사에서 자주 볼 수 있는 사진은 비용을 지불하고 구매한 사진이 다수를 차지할 정도로 질 좋은 사진에 대한 수요는 꾸준합니다.
            본 사이트 또한 출처를 따로 표기하지 않아도 되는 이미지를 방문자에게 제공할 목적으로 만들어 졌으며 앞으로 새로운 기능을 업데이트할 것을 약속합니다.</p>

        <p>본 사이트를 이용하기 위해서는 회원가입 하도록 권장하고 있습니다만
            개인정보 제공에 대한 우려를 이해하고 있기에 로그인 없이 사이트를 구경할 수 있는
            샘플 아이디와 비밀번호를 제공하고 있습니다.</p><br>

        <p>
            샘플 아이디 : abc1 또는 abc2 <br>
            비밀번호 : 1234
        </p>
    </div>
</article>

<%--    푸터--%>
<footer>
    <a href="<c:url value='/about/website'/>">사이트 소개</a>
    <a href="<c:url value='/about/terms'/>">이용약관</a>
    <a href="<c:url value="/about/privacy"/>">개인정보 처리방침</a>
    <a href="<c:url value='/'/>">고객센터: nasb258@gmail.com</a>
</footer>
</body>
</html>
