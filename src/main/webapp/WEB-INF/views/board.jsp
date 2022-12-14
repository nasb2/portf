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
        alert("?????????????????????.")
    }
    if (msg === "modifyX") {
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
        <li class="naviMenu"><a href="<c:url value='/login/login'/>">${isLogined? 'Logout' : 'Login'}</a></li>
        <li class="naviMenu" ${isLogined? 'hidden="hidden"':''}><a
                href="<c:url value='/register/form'/>">${isLogined? '':'sign up'}</a></li>
        <li class="naviMenu" id="naviMenu_sessionId">${sessionScope.id}${isLogined?'???':''}</li>
    </ul>
</nav>

<%--??????--%>
<article>
    <div class="thisPage_title">????????? ??????</div>
    <div>
        <form id="form">
            <label id="labelBno"><span class="formInfo">?????????</span>
                <input type="text" id="bno" name="bno"
                       value="<c:out value='${boardDto.bno}'/>" readonly="readonly"></label><br>
            <label id="labelTitle"><span class="formInfo">??????</span>
                <input type="text" id="title" name="title"
                       value="<c:out value='${boardDto.title}'/>" readonly="readonly" maxlength="70"></label>
            <label id="labelWriter"><span class="formInfo">?????????</span>
                <input type="text" id="writer" name="writer"
                       value="<c:out value='${boardDto.writer}'/>" readonly="readonly"><br></label>
            <label><textarea name="content" id="content" readonly="readonly" rows="16" cols="99"><c:out
                    value='${boardDto.content}' escapeXml="true"/></textarea></label><br>
            <button id="regBtn" type="button" hidden="hidden">??????</button>
            <button id="modBtn" type="button">??????</button>
            <button id="delBtn" type="button">??????</button>
            <button id="listBtn" type="button">??????</button>
        </form>

        <div class="commentSpace">
            <div id="commentCnt"><c:out value="${boardDto.commentCnt}"/>?????? ??????</div>
            <div class="commentForm">
                <label><textarea cols="70" rows="5" name="comment" placeholder="????????? ??????????????? ????????? ????????????."></textarea></label>
                <button type="button" id="commentSendBtn">??????</button>
            </div>

            <div class="commentList"></div>
            <div id="replyForm" style="display: none">
                <label>
                    <textarea name="reply" placeholder="????????? ??????????????????." cols="98" rows="5"></textarea>
                </label>
                <button type="button" id="replyRegBtn">??????</button>
                <button type="button" id="replyFormRemoveBtn">??????</button>
            </div>
        </div>
    </div>
</article>

<%--??????????????????--%>
<script>
    $(document).ready(function () {
        let form = $("#form");
        let commentList = $(".commentList");

        modeChange(); // ?????? ????????? ??? ????????? ??????
        showCommentList(); // ?????? ????????? ????????????

        // ???????????? ????????? ?????? ????????? ?????? ?????? ??????, ???????????? ?????????
        if (!<c:out value="${isLoginedPerson}"/>) {
            $("#modBtn").attr("hidden", true);
            $("#delBtn").attr("hidden", true);
            $("#listBtn").css("margin-left", "630px");
        }

// [CRUD] ?????????
// [CRUD] ??????
        $("#regBtn").on("click", function () {
            if (confirm("?????????????????????????")) {
                form.attr("method", "POST").attr("action", "<c:url value='/board/write'/>");
                form.submit();
            }
        });

// [CRUD] ????????? ??????
        $("#delBtn").on("click", function () {
            if (confirm("?????? ?????????????????????????")) {
                form.attr("method", "POST").attr("action", "<c:url value='/board/delete?page=${page}&pageSize=${pageSize}'/>");
                form.attr("bno", "<c:out value='${boardDto.bno}'/>");
                form.submit();
            }
        });

// [CRUD] ????????? ??????
        $("#modBtn").on("click", function () {
            $(".thisPage_title").html("????????? ????????????");
            $("#title").attr("readonly", false).css("border", "2px solid steelblue").focus();
            $("#content").attr("readonly", false).css("border", "2px solid steelblue").focus();
            $("#modBtn").attr('class', 'modBtn2').html("????????????");

            $(".modBtn2").on("click", function () {
                if (confirm("?????????????????????????")) {
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

// [CRUD] ??????
// [CRUD] ??????
        $("#commentSendBtn").click(function () {
            let comment = $("textarea[name=comment]").val().trim();
            $.ajax({
                type: 'POST',
                url: '<c:url value="/comment?bno="/>' + bno,
                headers: {"content-type": "application/json"},
                data: JSON.stringify({comment: comment}),
                success: function (result) {
                    if (result === "LOGIN_ERR") {
                        alert("????????? ??????????????? ???????????? ???????????????.");
                        location.href = '<c:url value="/login/login?bno="/>' + bno;
                    } else if (result === "EMPTY_ERR") {
                        $("textarea[name=comment]").val("");
                        alert("????????? ??????????????????.");
                    } else if (result === "WRT_ERR") {
                        alert("?????? ????????? ??????????????????.");
                    } else {
                        $("#commentCnt").html(result + "?????? ??????");
                        showCommentList();
                    }
                },
                error: function () {
                    alert("???????????????. ?????? ????????? ??????????????????.");
                }
            })
        });

// [CRUD] ?????? ??????
        commentList.on("click", "#cDelBtn", function () {
            let cno = $(this).parents("ul").attr("data-cno");
            let pcno = $(this).parents("ul").attr("data-pcno");
            let bno = $(this).parents("ul").attr("data-bno");
            if (confirm("?????????????????????????")) {
                $.ajax({
                    type: 'DELETE',
                    url: '<c:url value="/comment/"/>' + cno + "?bno=" + bno,
                    success: function (result) {
                        if (result === "DEL_ERR") {
                            alert("????????? ??????????????????.");
                        }
                        $("#commentCnt").html(result + "?????? ??????");
                        showCommentList();
                        showReplyList(pcno);
                    },
                    error: function () {
                        alert("???????????????. ????????? ??????????????????. ?????? ??? ?????? ??????????????????.")
                    },
                })
            }
        });

// [CRUD] ?????? ??????
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
                            alert("???????????? ???????????? ????????????.");
                        } else if (result === "NO_DIFF") {
                            alert("??????????????????.");
                        } else if (result === "MOD_OK") {
                            alert("?????? ????????? ?????????????????????.");
                        } else if (result === "MOD_ERR") {
                            alert("?????? ????????? ?????????????????????.");
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
                alert("????????? ??????????????? ???????????? ???????????????.");
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

// [CRUD] ????????? ??????
        $("#replyRegBtn").on("click", function () {
            let pcno = $("#replyForm").parent().parent().attr("data-pcno");
            let comment = $("textarea[name=reply]").val();

            if (comment.trim() === '') {
                alert("???????????? ??????????????????.");
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
                        alert("???????????? ??????????????? ???????????? ???????????????.");
                        location.href = '<c:url value="/login/login?bno="/>' + bno;
                    } else if (result === "EMPTY_ERR") {
                        $("textarea[name=comment]").val("");
                        alert("???????????? ??????????????????.");
                    } else if (result === "WRT_ERR") {
                        alert("????????? ????????? ??????????????????.");
                    } else {
                        $("#commentCnt").html(result + "?????? ??????");
                        showCommentList();
                        showReplyList(pcno);
                    }

                },
                error: function () {
                    alert("???????????????. ????????? ????????? ??????????????????. ?????? ??? ?????? ????????? ?????????.");
                }
            }); // $.ajax()

            $("#replyForm").css("display", "none").appendTo("body");
            $("textarea[name=reply]").val('');
        });

// [?????????] ?????????
        commentList.on("click", "#showReply", function () {
            let pcno = $(this).parents("ul").attr("data-pcno");
            showReplyList(pcno);
        });

// [?????????] ??????
        commentList.on("click", "#replyListClose", function () {
            let pcno = $(this).parents("ul").attr("data-pcno");
            $("#comeHereReply" + pcno).css("display", "none");
        });
    });

    let bno = "<c:out value='${boardDto.bno}'/>";
    let list = [];

    // [?????????] ????????? ??????
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
                    let commenterId = (commenter !== "${sessionScope.id}"); // ?????? ???????????? ?????? ????????? ???????????? ??????

                    htmlOut += "<ul data-cno=" + cno
                    htmlOut += " data-pcno=" + pcno
                    htmlOut += " data-bno=" + bno
                    htmlOut += " data-commenter=" + commenter + ">";
                    htmlOut += "<li>&ensp;&ensp;&ensp;&ensp;<span id='replyListCommenter'>" + commenter + "</span>";
                    htmlOut += "<br>&ensp;&ensp;&ensp;&ensp;<input id='comment" + cno + "' value='" + comment + "' readonly/>&ensp;" + dateTime.toLocaleString();
                    htmlOut += "<button type='button' id='cDelBtn'" + (commenterId ? 'hidden' : '') + ">??????</button>";
                    htmlOut += "<button type='button' id='cModBtn'" + (commenterId ? 'hidden' : '') + ">??????</button>";
                    htmlOut += "<button type='button' id='replyBtn'>??????</button></div>";
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

    // [??????] ????????? ??????
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
                    let commenterId = (commenter !== "${sessionScope.id}"); // ?????? ???????????? ?????? ????????? ???????????? ??????
                    htmlOut += "<ul data-cno=" + cno;
                    htmlOut += " data-pcno=" + pcno
                    htmlOut += " data-bno=" + bno
                    htmlOut += " data-commenter=" + commenter + ">";
                    if (cno !== pcno) {
                        htmlOut += "<div id='hideReply" + pcno + "' hidden='hidden'>";
                    }
                    htmlOut += "<li><span id='commentListCommenter'>" + commenter + "</span>";
                    htmlOut += "<br><input id='comment" + cno + "' value='" + comment + "' readonly/>&ensp;" + dateTime.toLocaleString();
                    htmlOut += "<button type='button' id='cDelBtn'" + (commenterId ? 'hidden' : '') + ">??????</button>";
                    htmlOut += "<button type='button' id='cModBtn'" + (commenterId ? 'hidden' : '') + ">??????</button>";
                    htmlOut += "<button type='button' id='replyBtn'>??????</button></div>";

                    // ???????????? ????????? ????????? ????????? ????????? ??? +1
                    if (cno === pcno) {
                        firstCno = cno;
                        list2.push(firstCno);
                        htmlOut += "<br><button type='button' id='showReply'><span id='replyCnt" + cno + "'></span>??? ????????????</button>";
                        htmlOut += "<button type='button' id='replyListClose'>??????</button><div id='comeHereReply" + pcno + "'></div>";
                    }
                    htmlOut += "</li></ul>";
                }

                $("textarea[name=comment]").val("");
                $(".commentList").html(htmlOut);
                getReplyCnt(list2); // ????????? ??? ??????????????? ?????????
                hoverBackgroundColor("button");

            },
            error: function () {
                alert("error")
            }
        }); // $.ajax()
    };

    // [?????????] ????????? ?????? ??????
    function modeChange() {
        if (<c:out value="${mode=='write'}"/>) {
            $(".thisPage_title").html("????????? ??????");
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


    // [?????????] ?????? ????????? ??? ??????
    function getReplyCnt(list) {
        for (let i = 0; i < list.length; i++) {
            let replyCnt = $("ul[data-pcno=" + list[i] + "]").children("div").length;
            $("#replyCnt" + list[i]).html(replyCnt);
        }
    }

    // [?????????] ?????? ?????? ?????? ????????? ??????
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