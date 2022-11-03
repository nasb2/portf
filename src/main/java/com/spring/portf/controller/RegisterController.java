package com.spring.portf.controller;

import com.spring.portf.domain.UserDto;
import com.spring.portf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;

@Controller
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    UserService userService;
    String requireCheckId = null; // 아이디 중복확인 검증하는 전역변수 - 1이면 통과, 1이 아니면 불합격
    String passedId = ""; // 검증받은(통과한) 아이디

    @GetMapping("/form")
    public String form() {
        return "registerForm";
    }

    // 입력한 pwd와 비밀번호 재확인란에 입력한 pwd 비교
    @GetMapping("/pCheck")
    @ResponseBody
    public String pwdCheck(String pwd, String pwd2) {
        try {
            if (pwd == null || "".equals(pwd)) {
                return "EMPTY_ERR1";
            } else if (pwd2 == null || "".equals(pwd2)) {
                return "EMPTY_ERR2";
            } else if (!pwd.equals(pwd2)) {
                return "PWD_N"; // 일치하지 않음
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "PWD_Y"; // 일치함
    }

    @PostMapping("/form")
    public String save(@ModelAttribute("userDto") @Valid UserDto userDto, BindingResult result, Model m,
                       HttpSession session, String pwd2) {
        try {
            // 1. 유효성 검사
            Date birth = userDto.getBirth();
            if (result.hasErrors() || birth == null) {
                return "registerForm";
            }

            // 2. 아이디 중복 확인 여부 체크
            // 전역변수 requireCheckId가 1이면 통과
            if (requireCheckId == null || "".equals(requireCheckId)) {
                result.rejectValue("id", "ID-CHECK_NULL");
                return "registerForm";
            } else if (!"1".equals(requireCheckId)) {
                result.rejectValue("id", "ID-CHECK_NOT1");
                requireCheckId = null;
                return "registerForm";
            } else if (!passedId.equals(userDto.getId())) { // 이미 중복확인 받았던 아이디와 현재 입력돼 있는 아이디 비교
                result.rejectValue("id", "ID-CHECK_NULL");
                requireCheckId = null;
                return "registerForm";
            }

            // 3. 비밀번호 서로 일치 하는가 확인
            String pwd = userDto.getPwd();
            if ("".equals(pwd2) || pwd2 == null || !pwd2.equals(pwd)) {
                result.rejectValue("pwd", "PWD2_ERR");
                m.addAttribute("pwd2", pwd2);
                return "registerForm";
            }

            // 4. db insert
            if (userService.insert(userDto) == 1 && "1".equals(requireCheckId)) {
                String id = userDto.getId();
                session.setAttribute("id", id);
                requireCheckId = null;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/";
    }

    // 아이디 중복확인 메서드
    @GetMapping("/idCheck")
    @ResponseBody
    public String idCheck(String id) throws Exception {
        try {
            if (id == null || "".equals(id.trim())) {
                return "REQ_ID";
            } else if (id.contains(" ")) {
                return "CONTAINS_GAP";
            } else if (id.length() < 4 || 12 < id.length()) {
                return "LENGTH_ERR";
            }
            for (int i = 0; i < id.length(); i++) {
                if ('A' <= id.charAt(i) && id.charAt(i) <= 'Z') {
                    return "CAPITAL_ERR"; // 대소문자 에러
                }
            }

            if (userService.select(id) != null) {
                requireCheckId = "0";
            } else {
                requireCheckId = "1";
                passedId = id;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return userService.select(id) != null ? "ANOTHER_ID" : "MAKE_ID";
    }
}