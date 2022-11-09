<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<html>
<head>
    <title>Free Download: Pick your Best Photos!</title>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    #homeText {
        width: 800px;
        margin: 20px 0 5px 0;
        font-size: 17px;
    }

    article {
        height: 800px;
    }

    img {
        width: 200px;
        height: 200px;
        float: left;
        margin: 0 5px 5px 0;
        border: 1px solid #e5e8eb;
    }

    .showPic {
        width: 1100px;
        margin: 0 auto;
    }

    #morePicBox {
        display: inline-block;
        width: 200px;
        height: 200px;
        background-color: steelblue;
        border: 1px solid steelblue;
    }

    #morePicBoxText {
        display: inline-block;
        width: 150px;
        padding: 30px 0 0 10px;
        font-size: 19px;
    }

    #morePicBoxText > a {
        color: white;
        font-weight: bold;
    }

</style>
<body>
<%--내비게이션--%>
<nav>
    <ul class="navi">
        <li class="naviMenu"><a href="<c:url value='/'/>">오늘의사진</a></li>
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
    <div class="thisPage_title">「오늘의사진」에 오신 것을 환영합니다</div>
    <div id="homeText">「오늘의사진」 is beautiful & free photos download site. Pick your Best photos! It's all free. To look
        around our site, all you have to do is just sign up for our site.
    </div>
    <div class="form_notice">! 쿠키를 허용해주세요.
        <br>
        ! 우리 사이트는 인터넷 익스플로러 브라우저에서는 제대로 작동하지 않습니다.
    </div>
    <div class="showPic">
        <c:forEach items="${list}" var="pictureDto" end="13">
            <img src="<c:out value='${pictureDto.filepath}'/>"
                 alt="<c:out value='${pictureDto.originalFilename}'/>">
        </c:forEach>
        <span id="morePicBox">
            <span id="morePicBoxText">
                <a href="<c:url value='/pic/list'/>">더 많은 사진을 보고싶다면?</a>
            </span>
        </span>
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
