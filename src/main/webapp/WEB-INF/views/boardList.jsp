<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<c:set var="isEmptyKeyword" value="${empty keyword}"/>
<html>
<head>
    <title>Free Download: Pick your Best Photos!</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    article {
        height: 800px;
        margin-bottom: 120px;
    }

    table, th, td {
        border-collapse: collapse;
        padding: 10px;
        font-size: 16px;
        border-style: none;
        border-bottom: 1px solid #ccc;
    }

    tr:nth-child(odd) {
        background-color: #efedf2;
    }

    tr:nth-child(even) {
        background-color: white;
    }

    tr:first-child {
        background-color: white;
    }

    th {
        border-style: none;
        border-bottom: solid 2px steelblue;
    }

    .board_search {
        margin: 50px auto;
        text-align: center;
    }

    #keyword {
        width: 500px;
        height: 42px;
        background: white;
        border: 1px solid #b6b7b9;
        outline-color: steelblue;
        border-radius: 5px;
        font-size: 15px;
    }

    #board_search_result {
        width: 616px;
        padding: 9px 0;
        float: left;
    }

    table {
        width: 950px;
        margin: 0 auto;
    }

    tr > #bno {
        width: 50px;
    }

    tr > #content {
        width: 190px;
    }

    tr > #title {
        width: 120px;
    }

    tr > #regDate {
        width: 120px;
    }

    tr > #writer {
        width: 70px;
    }

    #viewCnt, #commentCnt {
        width: 45px;
    }

    .board_navi {
        text-align: center;
        padding-top: 20px;
        font-size: 17px;
    }

    #goListBtn, #writeBtn {
        float: right;
        margin-right: 10px;
    }

</style>
<body>
<script>
    let msg = "${msg}";
    if (msg === "deleteOk") {
        alert("?????????????????????.")
    }
    if (msg === "deleteX") {
        alert("????????? ??????????????????.")
    }
    if (msg === "registerOk") {
        alert("??????????????? ?????????????????????.")
    }
    if (msg === "registerX") {
        alert("????????? ??????????????????.")
    }
</script>

<%--???????????????--%>
<nav>
    <ul class="navi">
        <li class="naviMenu"><a href="<c:url value='/'/>">HOME</a></li>
        <li class="naviMenu"><a href="<c:url value='/pic/list'/>">Photos</a></li>
        <li class="naviMenu"><a href="<c:url value='/pic/list'/>">illustrations</a></li>
        <li class="naviMenu"><a href="<c:url value='/board/list'/>">???????????????</a></li>
        <li class="naviMenu"><a href="<c:url value='/login/login'/>">${isLogined? 'Logout':'Login'}</a></li>
        <li class="naviMenu" ${isLogined? 'hidden="hidden"':''}><a
                href="<c:url value='/register/form'/>">${isLogined? '':'sign up'}</a></li>
        <li class="naviMenu" id="naviMenu_sessionId">${sessionScope.id}${isLogined?'???':''}</li>
    </ul>
</nav>
<%--??????--%>

<article>
    <div class="thisPage_title">?????? ?????????</div>
    <div class="board_search">
        <label><input type="text" id="keyword" name="keyword" size="90" placeholder=" ???????????? ??????????????????">
            <button type="button" id="searchBtn">??????</button>
        </label><br>
        <span id="board_search_result">${searchedCnt}${isEmptyKeyword ? "":" ?????? ??????????????? ???????????????."}</span>
    </div>
    <table style="text-align: center">
        <tr>
            <th name="bno" id="bno">??????</th>
            <th name="title" id="title">??????</th>
            <th name="content" id="content">??????</th>
            <th name="writer" id="writer">?????????</th>
            <th name="regDate" id="regDate">?????????</th>
            <th name="viewCnt" id="viewCnt">?????????</th>
            <th name="commentCnt" id="commentCnt">?????? ???</th>
        </tr>
        <c:forEach var="boardDto" items="${list}">
            <tr>
                <td name="bno"><c:out value="${boardDto.bno}"/></td>
                <td name="title" style="text-align: left">
                    <a href="<c:url value='/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}'/>">
                        <span id="maxlengthTitle${boardDto.bno}">
                            <c:out value="${boardDto.title}"/>
                        </span>
                    </a>
                </td>
                <td name="content" style="text-align: left">
                    <a href="<c:url value='/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}'/>">
                        <c:out value="${boardDto.content}"/>
                    </a>
                </td>
                <td name="writer"><c:out value="${boardDto.writer}"/></td>
                <td name="regDate"><fmt:formatDate value="${boardDto.regDate}" pattern="yyyy. MM. dd HH:mm"/></td>
                <td name="viewCnt"><c:out value="${boardDto.viewCnt}"/></td>
                <td name="commentCnt"><c:out value="${boardDto.commentCnt}"/></td>
            </tr>
        </c:forEach>
    </table>

    <div class="board_navi">
        <c:if test="${ph.showPrev}"><a
            href="<c:url value='/board/list?page=${ph.beginPage-1}&pageSize=${ph.pageSize}${isEmptyKeyword?"":"&keyword="}${keyword}'/>">[??????]</c:if></a>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}"><a
                href="<c:url value='/board/list?page=${i}&pageSize=${ph.pageSize}${isEmptyKeyword?"":"&keyword="}${keyword}'/>">
            &ensp;${i}&ensp; </a></c:forEach>
        <c:if test="${ph.showNext}"><a
            href="<c:url value='/board/list?page=${ph.endPage+1}&pageSize=${ph.pageSize}${isEmptyKeyword?"":"&keyword="}${keyword}'/>">[??????]</c:if></a>
    </div>
    <div>
        <button type="button" id="goListBtn">?????? ?????????</button>
        <a href="<c:url value='/board/write'/>">
            <button id="writeBtn">?????????</button>
        </a>
    </div>
</article>

<%--??????--%>
<footer>
    <a href="<c:url value='/about/website'/>">????????? ??????</a>
    <a href="<c:url value='/about/terms'/>">????????????</a>
    <a href="<c:url value="/about/privacy"/>">???????????? ????????????</a>
    <a href="<c:url value=''/>">????????????: nasb258@gmail.com</a>
</footer>

<script>
    $(document).ready(function () {
        // [??????] ????????? ?????? ??????
        $("#searchBtn").on("click", function () {
            let keyword = $("input[name=keyword]").val();
            location.href = '<c:url value="/board/list?page=${ph.page}&pageSize=${ph.pageSize}&keyword="/>' + keyword;
        });

        // [??????] ?????? ???????????? ??????
        $("#goListBtn").click(function () {
            location.href = '<c:url value="/board/list"/>';
        });
    });
</script>

</body>
</html>
