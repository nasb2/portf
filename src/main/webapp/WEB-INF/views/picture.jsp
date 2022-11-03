<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<html>
<head>
    <title>사진 상세 페이지</title>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<style>
    form {
        display: grid;
        width: 1000px;
        height: 510px;
        margin-top: 50px;
        grid-template-columns: repeat(6, 1fr);
        grid-template-rows: repeat(8, 70px);
        grid-template-areas:
            "box1 box1 box1 box2 box2"
            "box1 box1 box1 box3 box3"
            "box1 box1 box1 box3 box3"
            "box1 box1 box1 box3 box3"
            "box1 box1 box1 box4 box4"
            "box1 box1 box1 box4 box4"
            "box1 box1 box1 box5 box5"
    }

    .box1 {
        grid-area: box1;
        width: 500px;
        height: 500px;
    }

    .box2 {
        grid-area: box2;
        text-align: right;
        padding-left: 40px;
    }

    .box3 {
        grid-area: box3;
        text-align: left;
        padding-left: 40px;
    }

    .box4 {
        grid-area: box4;
        padding-left: 40px;
    }

    .box5 {
        grid-area: box5;
        margin-top: 40px;
        padding-left: 40px;
    }

    #showTitleTag {
        padding-top: 8px;
        float: left;
        font-size: 22px;
    }

    #showContent {
        width: 360px;
        padding-top: 20px;
        border-top: 2px solid #b8b8ba;
    }

    #span_writer {
        font-size: 17px;
    }

    #span_regDate {
        font-size: 15px;
        padding-top: 6px;
    }

    .advice {
        font-weight: bold;
        padding-bottom: 10px
    }

    .subject {
        padding-right: 1px;
        font-size: 16px;
    }

    #title2 {
        width: 150px;
        height: 30px;
        margin-top: 15px;
        border: 1px solid #b8b8ba;
        outline-color: steelblue;
    }

    #content {
        resize: none;
        border: 1px solid #b8b8ba;
        outline-color: steelblue;
    }

    .error_msg {
        width: 400px;
        height: 20px;
        padding-bottom: 10px;
    }

    input[name='file'] {
        position: relative;
        top: 10px;
        border: 1px solid #b8b8ba;
        border-radius: 2px;
    }

    #downloadBtn, #submitBtn {
        width: 400px;
        height: 66px;
        border: 1px solid #e5e8eb;
    }

    #downloadBtn:active {
        margin-top: 5px;
        margin-left: 5px;
        box-shadow: none;
    }

    #submitBtn:active {
        margin-top: 5px;
        margin-left: 5px;
        box-shadow: none;
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
    <div class="thisPage_title">사진 게시글 상세보기</div>
    <form id="form" enctype="multipart/form-data">

        <div class="box box1">
            <img id="image" src="<c:out value='${pictureDto.filepath}'/>" width="500px" height="500px"
                 alt="<c:out value='${pictureDto.originalFilename}'/>"/>
        </div>

        <div class="box box2">
            <div id="showTitleTag"><c:out value="${pictureDto.title}"/></div>
            <div class="hideForWrtMode">
                <span id="span_writer" name="writer"><c:out value="${pictureDto.writer}"/>
                <span id="span_name">(<c:out value="${name}"/>)</span></span>
                <div id="span_regDate"><c:out value="${printTimeDiff}"/></div>
            </div>

            <span id="span_radio" hidden>
                <div class="advice">1. 주제를 선택해주세요.</div>
                <div class="subject">
                    사람<input type="radio" name="title" value="사람">
                    동물<input type="radio" name="title" value="동물">
                    식물<input type="radio" name="title" value="식물">
                    풍경<input type="radio" name="title" value="풍경">
                    사물<input type="radio" name="title" value="사물">
                    건물<input type="radio" name="title" value="건물">
                    푸드<input type="radio" name="title" value="푸드">
                    배경<input type="radio" name="title" value="배경">
                    기타<input type="radio" name="title" value="기타">
                </div>
            </span>
        </div>

        <div class="box box3">
            <div id="showContent"><c:out value="${pictureDto.content}"/></div>
            <div class="showOnlyWrtMode">
                <div class="advice">2. 관련된 제목을 입력해주세요.</div>
                <label for="title2">
                    <input type="text" id="title2" name="title" value="<c:out value='${pictureDto.title}'/>"
                           placeholder="20자 이내로 작성" maxlength="20">
                </label>
                <div id="msg_title"></div>
            </div>
        </div>
        <div class="box box4">
            <div class="showOnlyWrtMode">
                <div class="advice">3. 사진에 대하여 설명해주세요.</div>
                <label for='content'>
                    <textarea id='content' name='content' cols='55' rows='7'><c:out
                            value="${pictureDto.content}"/></textarea>
                </label>
                <div id="msg_content"></div>
            </div>
        </div>
        <div class="box box5" id="box5">
            <div class="error_msg"></div>
            <button type="button" id="downloadBtn">다운로드</button>
            <button type="button" id="submitBtn" hidden="hidden">제출</button>
            <button type="button" id="picModCompleteBtn" hidden="hidden">수정완료</button>
        </div>
    </form>
    <button type="button" id="picDelBtn">삭제하기</button>
    <button type="button" id="picModBtn">수정하기</button>
    <div id="selectFile"></div>
    <div class="form_notice">! 이미지를 수정하거나 삭제하려면 로그인 해주세요.
    </div>

    <div id="change"></div>
</article>

</body>

<%--자바스크립트--%>
<script>
    $(document).ready(function () {
        let mode = "<c:out value='${mode}'/>";
        let selectFile = $("#selectFile");
        let samePerson = "<c:out value='${samePerson}'/>";
        let picDelBtn = $("#picDelBtn");
        let picModBtn = $("#picModBtn");

        $(".showOnlyWrtMode").css("display", "none");
        $("#showContent").css("border-top", "2px solid steelblue;");

        // 페이지가 쓰기 모드일 때 페이지 변경
        mode_writeFunction(mode);

        // 로그인한 사람과 글작성자 비교
        if (!samePerson) {
            picDelBtn.attr("hidden", true);
            picModBtn.attr("hidden", true);
            $(".form_notice").css("display", "none");
        } else {
            $(".form_notice").css("display", "none");
        }

        // 비로그인한 사람
        if (!${isLogined}) {
            $(".form_notice").css("display", "block");
        }

        // [구현] 첨부파일 미리보기 기능
        selectFile.on("change", function (e) {
            let reader = new FileReader();
            reader.readAsDataURL(e.target.files[0]);
            reader.onload = function (e) {
                let url = e.target.result;
                $("#image").attr("src", url);
            };
        });

        // [구현] 폼 전송
        $("#submitBtn").on("click", function () {
            let form = new FormData();
            form.append("file", $("input[type=file]")[0].files[0]);
            form.append("title", $("input[type=radio]:checked").val());
            form.append("title", $("#title2").val());
            form.append("writer", '${sessionScope.id}');
            form.append("content", $("textarea[id=content]").val());

            if (confirm("등록하시겠습니까?")) {
                $.ajax({
                    type: 'POST',
                    url: '<c:url value="/pic/upload"/>',
                    data: form,
                    processData: false,
                    contentType: false,
                    success: function (result) {
                        if (result === "NO_IMAGE") {
                            printErrorMsg("이미지를 선택해주세요.");
                            removeErrMsg();
                            return;
                        }
                        if (result === "NO_CATEGORY") {
                            printErrorMsg("주제를 선택해주세요.");
                            return;
                        }
                        if (result === "NO_TITLE") {
                            printErrorMsg("제목을 입력해주세요.");
                            $("#title2").focus();
                            return;
                        }
                        if (result === "NO_CONTENT") {
                            printErrorMsg("내용을 입력해주세요");
                            $("#content").focus();
                            return;
                        }
                        if (result === "WRITE_FAILED") {
                            alert("등록에 실패했습니다. 다시 확인해 주세요");
                            return;
                        }
                        if (result === "WRITE_SUCCESS") {
                            alert("정상적으로 등록되었습니다.");
                            location.href = "<c:url value='/pic/list'/>";
                        }
                    },
                    error: function () {
                        alert("죄송합니다. 등록에 실패했습니다. 다시 확인해 주세요");
                    }
                }); // $.ajax
            }
        });

        // [구현] 삭제 버튼
        picDelBtn.on("click", function () {
            let pno = "<c:out value='${pictureDto.pno}'/>";
            if (confirm("정말 삭제하시겠습니까?")) {
                $.ajax({
                    type: 'DELETE',
                    url: '<c:url value="/pic/picture/"/>' + pno,
                    success: function (result) {
                        if (result === "LOGIN_REQ") {
                            location.href = "<c:url value='/login/login'/>";
                            return;
                        }
                        if (result === "DELETE_OK") {
                            alert("정상적으로 삭제되었습니다.");
                            location.href = "<c:url value='/pic/list'/>";
                        } else {
                            alert("삭제에 실패했습니다. 다시 확인해 주세요.");
                        }
                    },
                    error: function () {
                        alert("죄송합니다. 삭제에 실패했습니다. 다시 확인해 주세요.")
                    }
                }); // $.ajax
            }
        });

        // [구현] 수정 버튼
        picModBtn.on("click", function () {
            $("input[name=title]:checked").val('');
            $("input[id=title2]").val('');

            let pno = "<c:out value='${pictureDto.pno}'/>";

            if (!${isLogined}) {
                alert("로그인이 필요합니다.");
                location.href = "<c:url value='/login/login?pno='/>" + pno;
                return;
            }
            mode_writeFunction("mode_write");
            $(".thisPage_title").html("사진 파일 수정 하기");
            $("#submitBtn").attr("hidden", true);
            $("#showTitleTag").attr("hidden", true);
            $("#showContent").css("display", "none");
            $(".showOnlyWrtMode:nth-child(2)").css("margin-top", "25px");


            $("#picModCompleteBtn").attr("hidden", false).on("click", function () {
                if (confirm("수정하시겠습니까?")) {
                    let form = new FormData();
                    if ($("#selectFile").on("change")) {
                        form.append("file", $("input[type=file]")[0].files[0]);
                    }
                    form.append("filepath", "<c:out value='${pictureDto.filepath}'/>");
                    form.append("title", $("input[type=radio]:checked").val());
                    form.append("title", $("#title2").val());
                    form.append("content", $("#content").val());

                    $.ajax({
                        type: 'PATCH',
                        url: '<c:url value="/pic/picture/"/>' + pno,
                        data: form,
                        processData: false,
                        contentType: false,
                        success: function (result) {
                            if (result === "NO_CATEGORY") {
                                printErrorMsg("주제를 선택해주세요.");
                                return;
                            }
                            if (result === "NO_TITLE") {
                                printErrorMsg("제목을 입력해주세요.");
                                $("#title2").focus();
                                return;
                            }
                            if (result === "NO_CONTENT") {
                                printErrorMsg("내용을 입력해주세요");
                                $("#content").focus();
                                return;
                            }
                            if (result === "PATCH_OK") {
                                location.href = '<c:url value="/pic/read?pno="/>' + pno;
                            } else {
                                alert("수정에 실패했습니다. 다시 확인해 주세요.");
                            }

                        },
                        error: function () {
                            alert("죄송합니다. 수정에 실패했습니다. 다시 확인해 주세요.")
                        }
                    });
                }

            });

        });
    });

    // msg 제거
    function removeErrMsg() {
        $("input[type=file]").on("change", function () {
            $(".error_msg").html("");
        });
    }

    function mode_writeFunction(mode) {
        if (mode === "mode_write") {
            $(".thisPage_title").html("이미지 업로드 하기");
            $(".form_notice").css("display", "none");
            $(".showOnlyWrtMode").css("display", "block");
            $(".hideForWrtMode").css("display", "none");

            $("#selectFile").append("<input type='file' name='file'>");
            $("#picDelBtn").attr("hidden", true);
            $("#picModBtn").attr("hidden", true);
            $("#downloadBtn").attr("hidden", true);
            $("#submitBtn").attr("hidden", false);
            $("#span_radio").attr("hidden", false);

            $(".box2").css("text-align", "left");
            $(".showOnlyWrtMode:nth-child(2)").css("padding-top", "25px");
            $("#showContent").css("border", "none");
        }
    }

    function printErrorMsg(str) {
        $(".error_msg").html(str).css("color", "red").css("font-weight", "bold");
    }
</script>
</html>
