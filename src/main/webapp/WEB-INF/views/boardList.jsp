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
        alert("삭제되었습니다.")
    }
    if (msg === "deleteX") {
        alert("삭제에 실패했습니다.")
    }
    if (msg === "registerOk") {
        alert("성공적으로 등록되었습니다.")
    }
    if (msg === "registerX") {
        alert("등록에 실패했습니다.")
    }
</script>

<%--내비게이션--%>
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
<%--본문--%>

<article>
    <div class="thisPage_title">자유 게시판</div>
    <div class="board_search">
        <label><input type="text" id="keyword" name="keyword" size="90" placeholder=" 검색어를 입력해주세요">
            <button type="button" id="searchBtn">검색</button>
        </label><br>
        <span id="board_search_result">${searchedCnt}${isEmptyKeyword ? "":" 개의 검색결과를 찾았습니다."}</span>
    </div>
    <table style="text-align: center">
        <tr>
            <th name="bno" id="bno">번호</th>
            <th name="title" id="title">제목</th>
            <th name="content" id="content">내용</th>
            <th name="writer" id="writer">작성자</th>
            <th name="regDate" id="regDate">등록일</th>
            <th name="viewCnt" id="viewCnt">조회수</th>
            <th name="commentCnt" id="commentCnt">댓글 수</th>
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
            href="<c:url value='/board/list?page=${ph.beginPage-1}&pageSize=${ph.pageSize}${isEmptyKeyword?"":"&keyword="}${keyword}'/>">[이전]</c:if></a>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}"><a
                href="<c:url value='/board/list?page=${i}&pageSize=${ph.pageSize}${isEmptyKeyword?"":"&keyword="}${keyword}'/>">
            &ensp;${i}&ensp; </a></c:forEach>
        <c:if test="${ph.showNext}"><a
            href="<c:url value='/board/list?page=${ph.endPage+1}&pageSize=${ph.pageSize}${isEmptyKeyword?"":"&keyword="}${keyword}'/>">[다음]</c:if></a>
    </div>
    <div>
        <button type="button" id="goListBtn">전체 글보기</button>
        <a href="<c:url value='/board/write'/>">
            <button id="writeBtn">글쓰기</button>
        </a>
    </div>
</article>

<%--푸터--%>
<footer>
    <a href="<c:url value='/about/website'/>">사이트 소개</a>
    <a href="<c:url value='/about/terms'/>">이용약관</a>
    <a href="<c:url value="/about/privacy"/>">개인정보 처리방침</a>
    <a href="<c:url value=''/>">고객센터: nasb258@gmail.com</a>
</footer>

<script>
    $(document).ready(function () {
        // [구현] 키워드 검색 기능
        $("#searchBtn").on("click", function () {
            let keyword = $("input[name=keyword]").val();
            location.href = '<c:url value="/board/list?page=${ph.page}&pageSize=${ph.pageSize}&keyword="/>' + keyword;
        });

        // [구현] 처음 페이지로 가기
        $("#goListBtn").click(function () {
            location.href = '<c:url value="/board/list"/>';
        });
    });
</script>

</body>
</html>
