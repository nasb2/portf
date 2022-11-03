<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<c:set var="isLoginedPerson" value="${sessionScope.id eq boardDto.writer}"/>
<c:set var="sessionId" value="${sessionScope.id}"/>
<html>
<head>
    <title>Free Download: Pick your Best Photos!</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    ul {
        padding: 0;
    }

    ul > li {
        padding-bottom: 3px;
    }

    form {
        margin-bottom: 0;
        padding-top: 40px;
    }

    input {
        width: 556px;
        height: 37px;
        border: 1px solid #e5e8eb;
        background: #e5e8eb;
        outline-color: steelblue;
    }

    .formInfo {
        display: inline-block;
        width: 150px;
        text-align: center;
        font-weight: bold;
    }

    label[id*="label"] {
        display: inline-block;
        padding: 1px;
        border: 1px solid #e9e8e8;
        background-color: #e5e8eb;
    }

    #labelTitle, #title {
        background-color: white;
    }

    textarea {
        background-color: white;
        border: 1px solid #e9e8e8;
        outline-color: steelblue;
        resize: none;
    }

    #modBtn {
        margin-left: 489px;
    }

    #delBtn, #modBtn, #listBtn, #regBtn {
        width: 70px;
        height: 40px;
    }

    .commentList {
        padding-bottom: 100px;
    }

    .commentForm {
        padding-bottom: 5px;
    }

    #commentCnt {
        width: 100px;
        padding: 6px 0;
        border: 1px solid #e9e8e8;
        background-color: #e5e8eb;
        border-radius: 10px 10px 0 0;
        text-align: center;
        font-weight: bold;
    }

    #commentSendBtn {
        width: 80px;
        height: 40px;
        margin-left: 3px;
        position: absolute;
        border-radius: 8px;
    }

    #commentListCommenter, #replyListCommenter {
        display: inline-block;
        width: 60px;
        height: 25px;
        border: 1px solid #e9e8e8;
        background-color: #e5e8eb;
        border-radius: 10px 10px 0 0;
        text-align: center;
        font-size: 17px;
        font-weight: bold;
    }

    div[id*="comeHereReply"] {
        width: 1000px;
    }

    div[id*="comeHereReply"] > ul {
        padding-top: 12px;
    }

    #showReply, #replyListClose {
        width: 105px;
        height: 30px;
        margin-right: 5px;
        border: 1px solid #e5e8eb;
        background-color: #e5e8eb;
        border-radius: 0 0 10px 10px;
    }

    #replyListClose {
        width: 60px;
    }

    input[id*="comment"] {
        background-color: white;
    }

    #cDelBtn, button[id*='cModBtn'], #replyBtn, #replyRegBtn, #replyFormRemoveBtn {
        width: 50px;
        height: 30px;
        margin-left: 6px;
        border-radius: 6px;
    }

    #replyRegBtn, #replyFormRemoveBtn {
        margin: 0 2px 0 0;
    }

    textarea[name=reply] {
        margin: 15px 0 0 50px;
        border: 2px solid lightsteelblue;
    }

    button {
        box-shadow: 2px 2px 4px #b8b8ba;
    }

</style>
<body style="overflow: auto">
<script>
    let msg = "<c:out value='${msg}'/>";
    if (msg === "modifyOk") {
        alert("수정되었습니다.")
    }
    if (msg === "modifyX") {
        alert("수정에 실패했습니다.")
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
    <div class="thisPage_title">게시물 읽기</div>
    <div>
        <form id="form">
            <label id="labelBno"><span class="formInfo">글번호</span>
                <input type="text" id="bno" name="bno"
                       value="<c:out value='${boardDto.bno}'/>" readonly="readonly"></label><br>
            <label id="labelTitle"><span class="formInfo">제목</span>
                <input type="text" id="title" name="title"
                       value="<c:out value='${boardDto.title}'/>" readonly="readonly" maxlength="70"></label>
            <label id="labelWriter"><span class="formInfo">작성자</span>
                <input type="text" id="writer" name="writer"
                       value="<c:out value='${boardDto.writer}'/>" readonly="readonly"><br></label>
            <label><textarea name="content" id="content" readonly="readonly" rows="16" cols="99"><c:out
                    value='${boardDto.content}' escapeXml="true"/></textarea></label><br>
            <button id="regBtn" type="button" hidden="hidden">등록</button>
            <button id="modBtn" type="button">수정</button>
            <button id="delBtn" type="button">삭제</button>
            <button id="listBtn" type="button">목록</button>
        </form>

        <div class="commentSpace">
            <div id="commentCnt"><c:out value="${boardDto.commentCnt}"/>개의 댓글</div>
            <div class="commentForm">
                <label><textarea cols="70" rows="5" name="comment" placeholder="댓글을 입력하려면 로그인 해주세요."></textarea></label>
                <button type="button" id="commentSendBtn">등록</button>
            </div>

            <div class="commentList"></div>
            <div id="replyForm" style="display: none">
                <label>
                    <textarea name="reply" placeholder="댓글을 입력해주세요." cols="98" rows="5"></textarea>
                </label>
                <button type="button" id="replyRegBtn">등록</button>
                <button type="button" id="replyFormRemoveBtn">닫기</button>
            </div>
        </div>
    </div>
</article>

<%--자바스크립트--%>
<script>
    $(document).ready(function () {
        let form = $("#form");
        let commentList = $(".commentList");

        modeChange(); // 쓰기 모드일 때 페이지 변경
        showCommentList(); // 댓글 리스트 불러오기

        // 로그인한 사람과 글쓴 사람이 다를 경우 수정, 삭제버튼 숨기기
        if (!<c:out value="${isLoginedPerson}"/>) {
            $("#modBtn").attr("hidden", true);
            $("#delBtn").attr("hidden", true);
            $("#listBtn").css("margin-left", "630px");
        }

// [CRUD] 게시글
// [CRUD] 등록
        $("#regBtn").on("click", function () {
            if (confirm("등록하시겠습니까?")) {
                form.attr("method", "POST").attr("action", "<c:url value='/board/write'/>");
                form.submit();
            }
        });

// [CRUD] 게시글 삭제
        $("#delBtn").on("click", function () {
            if (confirm("정말 삭제하시겠습니까?")) {
                form.attr("method", "POST").attr("action", "<c:url value='/board/delete?page=${page}&pageSize=${pageSize}'/>");
                form.attr("bno", "<c:out value='${boardDto.bno}'/>");
                form.submit();
            }
        });

// [CRUD] 게시글 수정
        $("#modBtn").on("click", function () {
            $(".thisPage_title").html("게시물 수정하기");
            $("#title").attr("readonly", false).css("border", "2px solid steelblue").focus();
            $("#content").attr("readonly", false).css("border", "2px solid steelblue").focus();
            $("#modBtn").attr('class', 'modBtn2').html("수정완료");

            $(".modBtn2").on("click", function () {
                if (confirm("수정하시겠습니까?")) {
                    form.attr("method", "POST").attr("action", "<c:url value='/board/modify?page=${page}&pageSize=${pageSize}'/>");
                    form.submit();
                    return;
                }
                $("#modBtn").removeAttr("class");
            });
        });

        $("#listBtn").on("click", function () {
            location.href = "<c:url value="/board/list?page=${page}&pageSize=${pageSize}"/>";
        });

// [CRUD] 댓글
// [CRUD] 등록
        $("#commentSendBtn").click(function () {
            let comment = $("textarea[name=comment]").val().trim();
            $.ajax({
                type: 'POST',
                url: '<c:url value="/comment?bno="/>' + bno,
                headers: {"content-type": "application/json"},
                data: JSON.stringify({comment: comment}),
                success: function (result) {
                    if (result === "LOGIN_ERR") {
                        alert("댓글을 등록하려면 로그인이 필요합니다.");
                        location.href = '<c:url value="/login/login?bno="/>' + bno;
                    } else if (result === "EMPTY_ERR") {
                        $("textarea[name=comment]").val("");
                        alert("댓글을 입력해주세요.");
                    } else if (result === "WRT_ERR") {
                        alert("댓글 등록에 실패했습니다.");
                    } else {
                        $("#commentCnt").html(result + "개의 댓글");
                        showCommentList();
                    }
                },
                error: function () {
                    alert("죄송합니다. 댓글 등록에 실패했습니다.");
                }
            })
        });

// [CRUD] 댓글 삭제
        commentList.on("click", "#cDelBtn", function () {
            let cno = $(this).parents("ul").attr("data-cno");
            let pcno = $(this).parents("ul").attr("data-pcno");
            let bno = $(this).parents("ul").attr("data-bno");
            if (confirm("삭제하시겠습니까?")) {
                $.ajax({
                    type: 'DELETE',
                    url: '<c:url value="/comment/"/>' + cno + "?bno=" + bno,
                    success: function (result) {
                        if (result === "DEL_ERR") {
                            alert("삭제에 실패했습니다.");
                        }
                        $("#commentCnt").html(result + "개의 댓글");
                        showCommentList();
                        showReplyList(pcno);
                    },
                    error: function () {
                        alert("죄송합니다. 삭제에 실패했습니다. 확인 후 다시 시도해주세요.")
                    },
                })
            }
        });

// [CRUD] 댓글 수정
        commentList.on("click", "#cModBtn", function () {
            let cno = $(this).parents("ul").attr("data-cno");
            let pcno = $(this).parents("ul").attr("data-pcno");
            $("#cDelBtn").attr("hidden", true);
            $("#replyBtn").attr("hidden", true);
            $("#comment" + cno).attr("readonly", false).css("border", "2px solid steelblue").focus();
            $(this).attr("id", "cModBtn" + cno);

            $("#cModBtn" + cno).on("click", function () {
                let comment = $("#comment" + cno).val();
                let commenter = $(this).parents("ul").attr("data-commenter");
                $.ajax({
                    type: 'PATCH',
                    url: '<c:url value="/comment/"/>' + cno + "?bno=" + bno,
                    headers: {"content-type": "application/json"},
                    data: JSON.stringify({comment: comment, commenter: commenter}),
                    success: function (result) {
                        if (result === "LOGIN_ERR") {
                            alert("작성자가 일치하지 않습니다.");
                        } else if (result === "NO_DIFF") {
                            alert("취소했습니다.");
                        } else if (result === "MOD_OK") {
                            alert("댓글 수정에 성공하였습니다.");
                        } else if (result === "MOD_ERR") {
                            alert("댓글 수정에 실패하였습니다.");
                        }
                        $("#comment" + cno).attr("readonly", true);
                        $("#cModBtn" + cno).attr("id", "cModBtn");
                        showCommentList();
                        showReplyList(pcno);
                    },
                    error: function () {
                        alert(".cModBtn2 error")
                    }
                }); // .$ajax
            });
        });

        commentList.on("click", "#replyBtn", function () {
            let cno = $(this).parents("ul").attr("data-cno");
            let pcno = $(this).parents("ul").attr("data-pcno");

            if (${sessionScope.id eq null}) {
                alert("댓글을 입력하려면 로그인이 필요합니다.");
                location.href = "<c:url value='/login/login?bno='/>" + bno;
                return;
            }

            if (cno === pcno) {
                $("#replyForm").insertBefore($("#comeHereReply" + cno)).css("display", "block");
            } else {
                $("#replyForm").appendTo($(this).parent()).css("display", "block");
            }

            $("#replyFormRemoveBtn").on("click", function () {
                $("#replyForm").css("display", "none");
                $("textarea[name=reply]").val('');
            });
        });

// [CRUD] 대댓글 등록
        $("#replyRegBtn").on("click", function () {
            let pcno = $("#replyForm").parent().parent().attr("data-pcno");
            let comment = $("textarea[name=reply]").val();

            if (comment.trim() === '') {
                alert("대댓글을 입력해주세요.");
                $("textarea[name=reply]").focus();
                return;
            }

            $.ajax({
                type: 'POST',
                url: '<c:url value="/comment?bno="/>' + bno,
                headers: {"content-type": "application/json"},
                data: JSON.stringify({pcno: pcno, comment: comment}),
                success: function (result) {
                    if (result === "LOGIN_ERR") {
                        alert("대댓글을 등록하려면 로그인이 필요합니다.");
                        location.href = '<c:url value="/login/login?bno="/>' + bno;
                    } else if (result === "EMPTY_ERR") {
                        $("textarea[name=comment]").val("");
                        alert("대댓글을 입력해주세요.");
                    } else if (result === "WRT_ERR") {
                        alert("대댓글 등록에 실패했습니다.");
                    } else {
                        $("#commentCnt").html(result + "개의 댓글");
                        showCommentList();
                        showReplyList(pcno);
                    }

                },
                error: function () {
                    alert("죄송합니다. 대댓글 등록에 실패했습니다. 확인 후 다시 시도해 주세요.");
                }
            }); // $.ajax()

            $("#replyForm").css("display", "none").appendTo("body");
            $("textarea[name=reply]").val('');
        });

// [대댓글] 펼치기
        commentList.on("click", "#showReply", function () {
            let pcno = $(this).parents("ul").attr("data-pcno");
            showReplyList(pcno);
        });

// [대댓글] 접기
        commentList.on("click", "#replyListClose", function () {
            let pcno = $(this).parents("ul").attr("data-pcno");
            $("#comeHereReply" + pcno).css("display", "none");
        });
    });

    let bno = "<c:out value='${boardDto.bno}'/>";
    let list = [];

    // [대댓글] 리스트 출력
    let showReplyList = function (pcno) {
        $.ajax({
            type: 'GET',
            url: '<c:url value="/comment?bno="/>' + bno + "&pcno=" + pcno,
            success: function (result) {
                list = result;
                let htmlOut = "";
                for (let i in list) {
                    let cno = list[i]["cno"];
                    let pcno = list[i]["pcno"];
                    let bno = list[i]["bno"];
                    let commenter = list[i]["commenter"];
                    let comment = list[i]["comment"];
                    let dateTime = new Date(list[i]["commentDate"]);
                    let commenterId = (commenter !== "${sessionScope.id}"); // 댓글 작성자와 세션 아이디 동일한지 비교

                    htmlOut += "<ul data-cno=" + cno
                    htmlOut += " data-pcno=" + pcno
                    htmlOut += " data-bno=" + bno
                    htmlOut += " data-commenter=" + commenter + ">";
                    htmlOut += "<li>&ensp;&ensp;&ensp;&ensp;<span id='replyListCommenter'>" + commenter + "</span>";
                    htmlOut += "<br>&ensp;&ensp;&ensp;&ensp;<input id='comment" + cno + "' value='" + comment + "' readonly/>&ensp;" + dateTime.toLocaleString();
                    htmlOut += "<button type='button' id='cDelBtn'" + (commenterId ? 'hidden' : '') + ">삭제</button>";
                    htmlOut += "<button type='button' id='cModBtn'" + (commenterId ? 'hidden' : '') + ">수정</button>";
                    htmlOut += "<button type='button' id='replyBtn'>댓글</button></div>";
                    htmlOut += "</li></ul>";
                }
                $("#comeHereReply" + pcno).html(htmlOut).css("display", "block");
                hoverBackgroundColor("button");
            },
            error: function () {
                alert("showReplyList error")
            }
        })
    };

    // [댓글] 리스트 출력
    let showCommentList = function () {
        $.ajax({
            type: 'GET',
            url: '<c:url value="/comment?bno="/>' + bno,
            success: function (result) {
                list = result;
                let htmlOut = "";
                let firstCno = 0;
                let list2 = [];
                for (let i in list) {
                    let cno = list[i]["cno"];
                    let pcno = list[i]["pcno"];
                    let bno = list[i]["bno"];
                    let commenter = list[i]["commenter"];
                    let comment = list[i]["comment"];
                    let dateTime = new Date(list[i]["commentDate"]);
                    let commenterId = (commenter !== "${sessionScope.id}"); // 댓글 작성자와 세션 아이디 동일한지 비교
                    htmlOut += "<ul data-cno=" + cno;
                    htmlOut += " data-pcno=" + pcno
                    htmlOut += " data-bno=" + bno
                    htmlOut += " data-commenter=" + commenter + ">";
                    if (cno !== pcno) {
                        htmlOut += "<div id='hideReply" + pcno + "' hidden='hidden'>";
                    }
                    htmlOut += "<li><span id='commentListCommenter'>" + commenter + "</span>";
                    htmlOut += "<br><input id='comment" + cno + "' value='" + comment + "' readonly/>&ensp;" + dateTime.toLocaleString();
                    htmlOut += "<button type='button' id='cDelBtn'" + (commenterId ? 'hidden' : '') + ">삭제</button>";
                    htmlOut += "<button type='button' id='cModBtn'" + (commenterId ? 'hidden' : '') + ">수정</button>";
                    htmlOut += "<button type='button' id='replyBtn'>댓글</button></div>";

                    // 원댓글과 대댓글 숫자가 같으면 대댓글 수 +1
                    if (cno === pcno) {
                        firstCno = cno;
                        list2.push(firstCno);
                        htmlOut += "<br><button type='button' id='showReply'><span id='replyCnt" + cno + "'></span>개 댓글보기</button>";
                        htmlOut += "<button type='button' id='replyListClose'>접기</button><div id='comeHereReply" + pcno + "'></div>";
                    }
                    htmlOut += "</li></ul>";
                }

                $("textarea[name=comment]").val("");
                $(".commentList").html(htmlOut);
                getReplyCnt(list2); // 대댓글 수 표시해주는 메서드
                hoverBackgroundColor("button");

            },
            error: function () {
                alert("error")
            }
        }); // $.ajax()
    };

    // [메소드] 페이지 모드 변경
    function modeChange() {
        if (<c:out value="${mode=='write'}"/>) {
            $(".thisPage_title").html("게시물 쓰기");
            $("#labelBno").css("display", "none");
            $("#title").attr("readonly", false).focus();
            $("#writer").val("<c:out value='${sessionScope.id}'/>");
            $("#content").attr("readonly", false).attr("rows", "20px");
            $("#regBtn").attr("hidden", false).css("margin-left", "569px");
            $("#modBtn").attr("hidden", true);
            $("#delBtn").attr("hidden", true);
            $(".commentSpace").css("display", "none");
        }
    }


    // [메소드] 현재 대댓글 수 표시
    function getReplyCnt(list) {
        for (let i = 0; i < list.length; i++) {
            let replyCnt = $("ul[data-pcno=" + list[i] + "]").children("div").length;
            $("#replyCnt" + list[i]).html(replyCnt);
        }
    }

    // [메소드] 동적 추가 버튼 배경색 변경
    function hoverBackgroundColor(button) {
        $(button).hover(function () {
                $(this).css("background-color", "steelblue").css("box-shadow", "none").css("color", "white");
            }, function () {
                $(this).css("background-color", "#e5e8eb").css("box-shadow", "2px 2px 4px #b8b8ba").css("color", "black");
            }
        );
    }
</script>
</body>
</html>