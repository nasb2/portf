<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="isLogined" value="${not empty sessionScope.id}"/>
<html>
<head>
    <title>Free Download: Pick your Best Photos!</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<link rel="stylesheet" href="<c:url value='/css/menu2.css?0'/>">
<style>
    li {
        list-style: none;
        margin-bottom: 0;
    }

    .userInfo {
        display: flex;
        flex-direction: column;
        width: 750px;
        margin: 70px 0 70px 230px;
        text-align: center;
    }

    div[id*="form_"] {
        float: left;
    }

    .input {
        float: left;
        width: 250px;
        height: 33px;
        margin: 5px 0 9px 0;
        border: 1px solid #8a8b8d;
        border-radius: 5px;
        font-size: 14px;
    }

    #yy, #mm, #dd, #sns {
        width: 120px;
        height: 43px;
        margin-right: 10px;
        font-size: 13px;
    }

    button {
        float: left;
        margin-right: 10px;
    }

    #joinBtn, #resetBtn {
        width: 150px;
        height: 60px;
        margin-top: 20px;
    }

    button:not(#checkIdBtn):hover {
        font-size: 17px;
    }

    .errorMsg {
        padding-bottom: 10px;
        color: red;
        text-align: left;
    }

    #checkIdBtnMsg {
        float: left;
        padding-top: 10px;
    }

    .serverValidationErrMsg {
        display: inline-block;
        float: left;
        padding: 0 0 10px 0;
        color: red;
        text-align: left;
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

<script>
    let msg = "<c:out value='${msg}'/>";
    if (msg === "nonmember") {
        alert("회원이 아닙니다. 회원가입 창으로 이동합니다.");
    }
</script>

<%--본문--%>
<article>
    <div class="thisPage_title">회원가입</div>
    <div class="errorMsg" style="display:none;"></div>
    <form:form id="form" modelAttribute="userDto">
        <label class="userInfo">
            <li>
                <div class="form_notice" style="float: left">! 회원가입에 필요한 기본정보를
                    입력해주세요.
                </div>
            </li>
            <li>
                <div id="form_id">아이디 *</div>
                <br>
                <input type="text" id="id" class="input" name="id" value="${userDto.id}"
                       placeholder="공백없이 4~12자의 영문 소문자, 숫자" maxlength="15" required/>
                <button type="button" id="checkIdBtn">중복확인</button>
                <span id="checkIdBtnMsg"></span>
            </li>
            <form:errors path="id" cssClass="serverValidationErrMsg"/>
            <li>
                <div id="form_pwd">비밀번호 *</div>
                <br>
                <input type="password" id="pwd" class="input" name="pwd" value="${userDto.pwd}"
                       placeholder="공백없이 4~12자의 영문, 숫자" maxlength="15" required/>
            </li>
            <form:errors path="pwd" cssClass="serverValidationErrMsg"/>
            <li>
                <div id="form_pwd2">비밀번호 재확인 *</div>
                <br>
                <input type="password" id="pwd2" class="input" name="pwd2" value="<c:out value='${param.pwd2}'/>"
                       placeholder="비밀번호를 한 번 더 입력해주세요" maxlength="15" required/>
            </li>
            <li>
                <div id="form_name">이름 *</div>
                <br>
                <input type="text" id="name" class="input" name="name" value="${userDto.name}"
                       placeholder="한글 또는 영문 2~6자" maxlength="10" required/>
            </li>
            <form:errors path="name" cssClass="serverValidationErrMsg"/>
            <li>
                <div id="form_email">이메일 *</div>
                <br>
                <input type="text" id="email" class="input" name="email" value="${userDto.email}"
                       placeholder="이메일을 입력해주세요" maxlength="40" required/>
            </li>
            <form:errors path="email" cssClass="serverValidationErrMsg"/>
            <li>
                <div id="form_birth">생년월일 *</div>
                <br>
                <div>
                    <input type="text" id="yy" class="input" name="yy" value="<c:out value='${param.yy}'/>"
                           placeholder="출생년도(4자)"
                           maxlength="4">
                    <select id="mm" name="mm" class="input">
                        <option disabled selected>월</option>
                        <option value="01" ${param.mm eq '01'? 'selected="selected"':''}>1</option>
                        <option value="02" ${param.mm eq '02'? 'selected="selected"':''}>2</option>
                        <option value="03" ${param.mm eq '03'? 'selected="selected"':''}>3</option>
                        <option value="04" ${param.mm eq '04'? 'selected="selected"':''}>4</option>
                        <option value="05" ${param.mm eq '05'? 'selected="selected"':''}>5</option>
                        <option value="06" ${param.mm eq '06'? 'selected="selected"':''}>6</option>
                        <option value="07" ${param.mm eq '07'? 'selected="selected"':''}>7</option>
                        <option value="08" ${param.mm eq '08'? 'selected="selected"':''}>8</option>
                        <option value="09" ${param.mm eq '09'? 'selected="selected"':''}>9</option>
                        <option value="10" ${param.mm eq '10'? 'selected="selected"':''}>10</option>
                        <option value="11" ${param.mm eq '11'? 'selected="selected"':''}>11</option>
                        <option value="12" ${param.mm eq '12'? 'selected="selected"':''}>12</option>
                    </select>
                    <input type="text" id="dd" class="input" name="dd" value="<c:out value='${param.dd}'/>"
                           placeholder="일" maxlength="2">
                    <input type="text" id="birth" name="birth" value="" hidden><br>
                </div>
            </li>
            <form:errors path="birth" cssClass="serverValidationErrMsg"/>
            <li>
                <div id="form_gender">성별</div>
                <br>
                <select id="sns" name="sns" class="input">
                    <option disabled selected>성별</option>
                    <option value="선택안함" ${param.sns eq '선택안함'? 'selected="selected"':''}>선택안함</option>
                    <option value="여자" ${param.sns eq '여자'? 'selected="selected"':''}>여자</option>
                    <option value="남자" ${param.sns eq '남자'? 'selected="selected"':''}>남자</option>
                </select>
            </li>
            <div>
                <button type="button" id="joinBtn">회원가입</button>
                <button type="reset" id="resetBtn">취소하기</button>
            </div>
        </label>
    </form:form>
</article>

<script>
    $(document).ready(function () {
        let requireCheckId = 0;
        let regexId = /^[a-z0-9]{4,12}$/;
        let regexPwd = /^[a-zA-Z0-9]{4,12}$/;
        let regexName = /^[가-힣a-zA-z]{2,6}$/;
        let regexEmail = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*.[a-zA-Z]{2,3}$/;
        let regexYear = /^(19|20)[0-9]{2}$/;
        let regexDay = /^[0-3]?[0-9]$/;
        let beforeId = "";
        let form = $("#form");
        let id = $("#id");
        let pwd = $("#pwd");
        let pwd2 = $("#pwd2");
        let name = $("#name");
        let email = $("#email");
        let birth = $("#birth");
        let year = $("#yy");
        let month = $("#mm");
        let day = $("#dd");

        validMsgCss();

        // 프론트 폼 유효성 검사
        function validate() {
            $("#checkIdBtnMsg").val("");

            // 0. 앞 뒤 공백 제거
            id.val(id.val().trim());
            pwd.val(pwd.val().trim());
            pwd2.val(pwd2.val().trim());
            name.val(name.val().trim());
            email.val(email.val().trim());
            year.val(year.val().trim());

            // 1. 아이디 공란 체크
            if (id.val() === "" || id.val() == null) {
                errorMsgFunc("id", "아이디를 입력해주세요.");
                id.focus();
                return false;
            }

            if (id.val().indexOf(" ") > 0) {
                errorMsgFunc("id", "아이디에는 공백이 포함될 수 없습니다.");
                return false;
            }

            // 1-1. 아이디 정규식 체크
            if (!regexId.test(id.val())) {
                errorMsgFunc("id", "아이디는 4~12자 이내의 영문 소문자, 숫자로만 입력해주세요.");
                return false;
            }

            // 1-2. 아이디 중복 확인 체크
            if (requireCheckId !== 1) {
                errorMsgFunc("id", "아이디 중복 확인을 해주세요.");
                $("#checkIdBtn").on("click", function () {
                    $(".errorMsg").css("display", "none");
                });
                return false;
            }

            // 2. 비밀번호 공란 체크
            if (pwd.val() === '') {
                errorMsgFunc("pwd", "비밀번호를 입력해주세요.");
                pwd.val("").focus();
                return false;
            }

            if (pwd.val().indexOf(" ") > 0) {
                errorMsgFunc("pwd", "비밀번호에는 공백이 포함될 수 없습니다.");
                return false;
            }

            // 2-1. 비밀번호 정규식 체크
            if (!regexPwd.test(pwd.val())) {
                errorMsgFunc("pwd", "비밀번호는 4~12자의 영문, 숫자로만 입력해주세요.");
                pwd.focus();
                return false;
            }

            // 2-2. 아이디와 비밀번호가 서로 같은지 체크
            if (id.val() === pwd.val()) {
                errorMsgFunc("pwd", "아이디와 비밀번호는 서로 같을 수 없습니다.");
                pwd.focus();
                return false;
            }

            // 2-3. 비밀번호 확인란 체크
            if (pwd2.val() === "") {
                errorMsgFunc("pwd2", "비밀번호를 한 번 더 입력해주세요.");
                return false;
            }

            // 2-4. 비밀번호가 서로 일치하는지 체크
            if (pwd.val().trim() !== pwd2.val().trim()) {
                errorMsgFunc("pwd2", "비밀번호가 서로 일치하지 않습니다. 다시 입력해주세요.");
                pwd2.val("").focus();
                return false;
            }

            // 3. 이름 공란 체크
            if (name.val().trim() === "") {
                errorMsgFunc("name", "이름을 입력해주세요.");
                name.focus();
                return false;
            }

            // 3-1. 이름 정규식 체크
            if (!regexName.test(name.val())) {
                errorMsgFunc("name", "이름은 한글 또는 영문 2~6자로 입력해주세요.");
                name.focus();
                return false;
            }

            // 4. 이메일 공란 체크
            if (email.val() === "") {
                errorMsgFunc("email", "이메일을 입력해주세요.");
                email.focus();
                return false;
            }

            // 4-1. 이메일 정규식 검증
            if (!regexEmail.test(email.val())) {
                errorMsgFunc("email", "이메일을 올바른 형식으로 입력해주세요.");
                return false;
            }

            // 5. 생년월일 검증
            // 5-1. 출생년도 검증
            if (year.val() === "" || !regexYear.test(year.val())) {
                errorMsgFunc("birth", "출생 년도가 올바르지 않습니다. 다시 확인해주세요. 예) 2022");
                year.focus();
                return false;
            }

            // 5-2. 출생월 검증
            if (month.val() === null) {
                errorMsgFunc("birth", "출생 월을 입력해주세요.");
                month.focus();
                return false;
            }

            // 5-3. 출생일 검증
            if (day.val() === "" || !regexDay.test(day.val())) {
                errorMsgFunc("birth", "출생 일을 확인해주세요.");
                day.focus();
                return false;
            }

            // 6. 중복 확인 받은 아이디와 현재 입력한 아이디 비교
            if (beforeId !== $("input[name=id]").val()) {
                errorMsgFunc("id", "아이디 중복 확인을 해주세요.");
                id.focus();
                return false;
            }
            return true;
        }

        // [구현] 회원가입 버튼
        $("#joinBtn").on("click", function () {
            let birth = $("#yy").val() + '/' + $("#mm").val() + '/' + $("#dd").val();
            $("#birth").attr("value", birth);

            if (validate() && requireCheckId === 1) {
                form.attr("method", "POST").attr("action", '<c:url value="/register/form"/>');
                form.submit();

                // 뒤로가기 & input 필드 초기화
                $("#form")[0].reset();

                history.pushState(null, null, location.href);
                window.onpopstate = function () {
                    history.go(1);
                };
                $("#mm").val('월')
                $("#form")[0].reset();

            } else {
                $("#checkIdBtnMsg").val("");
            }
        });

        // [버튼] 아이디 중복 버튼
        $("#checkIdBtn").on("click", function () {
            requireIdCheck();
        });

        // [구현] 아이디 중복 체크
        function requireIdCheck() {
            $("h4").html("");
            let id = $("input[name=id]").val().trim();
            $.ajax({
                type: 'GET',
                url: '<c:url value="/register/idCheck?id="/>' + id,
                dataType: 'text',
                success: function (result) {
                    if (result === "MAKE_ID") {
                        $("#checkIdBtnMsg").html(" 사용 가능한 아이디 입니다.").css('color', 'green');
                        requireCheckId = 1;
                        beforeId = id;
                        $(".serverValidationErrMsg").html('');
                    } else if (result === "ANOTHER_ID") {
                        $("#checkIdBtnMsg").html(" 이미 사용중인 아이디 입니다.").css('color', 'red');
                        requireCheckId = 0;
                    } else if (result === "CONTAINS_GAP") {
                        $("#checkIdBtnMsg").html(" 아이디에는 공백이 포함될 수 없습니다.").css('color', 'red');
                        requireCheckId = 0;
                    } else if (result === "REQ_ID") {
                        $("#checkIdBtnMsg").html(" 아이디를 입력해주세요.").css('color', 'red');
                        requireCheckId = 0;
                    } else if (result === "LENGTH_ERR") {
                        $("#checkIdBtnMsg").html(" 아이디는 4~12자 이내로 작성해주세요.").css('color', 'red');
                        requireCheckId = 0;
                    } else if (result === "CAPITAL_ERR") {
                        $("#checkIdBtnMsg").html(" 아이디는 영문 소문자로만 작성해주세요.").css('color', 'red');
                        requireCheckId = 0;
                    }
                },
                error: function () {
                    alert("죄송합니다. 다시 확인해주세요.");
                    requireCheckId = null;
                }
            }); // $.ajax
        }

        // [구현] 취소 버튼
        $("#resetBtn").on("click", function () {
            $(".errorMsg").css("display", "none");
            $("#checkIdBtnMsg").html("");
            location.replace('<c:url value="/register/form"/>');
        });
    });


    // 여기서부터 [CSS] 함수 영역
    // [CSS] 프론트 에러 메시지
    function errorMsgFunc(id, errorMsg) {
        if ($("#checkIdBtnMsg") !== null) {
            let where = $("#form_" + id).parent();
            $(".errorMsg").html(errorMsg).css("display", "block").css("color", "red").insertAfter($(where));
        }
        $("#checkIdBtnMsg").html("");
    }

    // [CSS] 서버 에러 메시지
    function validMsgCss() {
        $(".serverValidationErrMsg").css("color", "red").css("float", "left").css("text-align", "left").css("display", "inline-block")
            .css("padding-top", "10px");
        $(".serverValidationErrMsg:last-child").css("padding-top", 0);
    }

    // [CSS] 버튼 배경색 바꾸는 메서드
    // function hoverBackgroundColor() {
    //     $("button").hover(function () {
    //             $(this).css("background-color", "steelblue").css("box-shadow", "none").css("color", "white");
    //         }, function () {
    //             $(this).css("background-color", "#e5e8eb").css("box-shadow", "1px 1px 2px #b8b8ba").css("color", "black");
    //         }
    //     );
    // }
</script>

</body>
</html>