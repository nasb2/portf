<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<html>
<head>
    <title>사진 목록 페이지</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    #wrapper {
        display: grid;
        height: 680px;
        grid-template-columns: repeat(3, 1fr);
        grid-gap: 30px 10px;
    }

    #form_notice {
        padding: 30px 0 16px 0;
        color: steelblue;
        font-size: 17px;
        font-weight: bold;
    }

    .card {
        width: 300px;
        height: 300px;
        box-shadow: 2px 2px 5px #515151;
        overflow: hidden;
        position: relative;
    }

    .container {
        width: 330px;
        height: 400px;
    }

    img {
        width: 300px;
        height: 300px;
        padding: 0 0 10px 0;
    }

    .card .text {
        position: absolute;
        top: 300px;
        width: 289px;
    }

    .container:hover {
        transform: translateY(-100px);
    }

    .text {
        font-size: 22px;
        font-weight: bold;
        padding: 30px 0 0 9px;
    }

    .text > .pWriter {
        font-size: 15px;
    }

    .navigation {
        width: 1020px;
        text-align: center;
        font-size: 22px;
    }

    #uploadBtn {
        float: right;
        width: 110px;
        height: 50px;
        margin-top: 5px;
        border: 1px solid #e5e8eb;
        background-color: #e5e8eb;
        border-radius: 10px;
        box-shadow: 1px 1px 2px #b8b8ba;
        text-align: center;
    }

    #uploadBtn:hover {
        background-color: steelblue;
        box-shadow: none;
        color: white;
    }

    .navigationFont {
        width: 800px;
        margin: 0 auto;
    }
</style>
<body>
<script>
    let msg = "<c:out value='${msg}'/>";
    if (msg === "UPLOAD_OK") alert("성공적으로 등록되었습니다.");
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
    <div class="thisPage_title">사진 업로드 게시판</div>
    <div id="form_notice">! 사진을 클릭하면 상세 페이지로 이동합니다</div>
    <div id="wrapper">
        <c:forEach items="${list}" var="pictureDto" end="${list.size()}">
            <div class="card">
                <div class="container">
                    <div class="image">
                        <a href="<c:url value='/pic/read?pno=${pictureDto.pno}'/>">
                            <img src="<c:out value='${pictureDto.filepath}'/>"
                                 alt="<c:out value='${pictureDto.originalFilename}'/>">
                        </a>
                        <div class="text"><span><c:out value="${pictureDto.title}"/></span>
                            <div class="pWriter"><c:out value="${pictureDto.writer}"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="navigation">
        <button type="button" id="uploadBtn">사진 올리기</button>
        <br>
        <div class="navigationFont"><c:if test="${ph.showPrev}"><a
                href="<c:url value='/pic/list?page=${ph.beginPage-1}&pageSize=${ph.pageSize}'/>">&ensp; < </a></c:if>
            <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}"><a
                    href="<c:url value='/pic/list?page=${i}&pageSize=${ph.pageSize}'/>">
                &ensp;${i}&ensp; </a></c:forEach>
            <c:if test="${ph.showNext}"><a
                    href="<c:url value='/pic/list?page=${ph.endPage+1}&pageSize=${ph.pageSize}'/>"> &ensp;> </a></c:if>
        </div>
    </div>
</article>

<%--자바스크립트--%>
<script>
    $(document).ready(function () {
        $("#uploadBtn").on("click", function () {
            location.href = '<c:url value="/pic/upload"/>';
        });

    });

    function hoverBackgroundColor() {
        $("button").hover(function () {
                $(this).css("background-color", "steelblue").css("box-shadow", "none").css("color", "white");
            }, function () {
                $(this).css("background-color", "#e5e8eb").css("box-shadow", "1px 1px 2px #b8b8ba").css("color", "black");
            }
        );
    }

</script>
</body>
</html>
