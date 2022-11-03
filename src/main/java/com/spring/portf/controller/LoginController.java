package com.spring.portf.controller;

import com.spring.portf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    UserService userService;

    @GetMapping("/login")
    public String loginOut(HttpSession session) {
        if (session.getAttribute("id") != null) {
            session.invalidate();
        }
        return "loginForm";
    }

    @PostMapping("/login")
    public String login(String id, String pwd, Integer bno, Integer pno, RedirectAttributes ra,
                        HttpServletRequest request, HttpServletResponse response, boolean rememberId, String url) {

        try {
            // 0. 아이디에 대문자 포함 시 소문자로 변환하여 세션에 저장
            id = id.toLowerCase();

            // 1. 비회원인 경우 회원가입 창으로 이동
            if (userService.select(id) == null) {
                ra.addFlashAttribute("msg", "nonmember");

                return "redirect:/register/form";
            }

            // 2. 회원인 경우
            // 2-1. 아이디, 비밀번호 불일치
            if (!userService.select(id).getPwd().equals(pwd)) {
                ra.addFlashAttribute("msg", "loginFailed");

                return "redirect:/login/login";
            } else {
                // 2-2. 아이디, 비밀번호 일치
                HttpSession session = request.getSession();
                session.setAttribute("id", id);

                // 3. 아이디 기억 체크 여부
                Cookie cookie = new Cookie("id", id);
                if (rememberId) {
                    response.addCookie(cookie);
                    cookie.setMaxAge(24 * 60 * 60); // 쿠키 유효기간 1일
                } else {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
                ra.addFlashAttribute("mode", "write");
            }

            // 4. 이전에 보고있던 페이지로 보내주기 위한 처리
            if (bno != null) {
                ra.addFlashAttribute("mode", "read");
                url = "/board/read?bno=" + bno;
            }
            if (pno != null) {
                url = "/pic/read?pno=" + pno;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:" + ("".equals(url) ? "/" : url);
    }
}
