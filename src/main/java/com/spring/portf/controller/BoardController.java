package com.spring.portf.controller;

import com.spring.portf.domain.BoardDto;
import com.spring.portf.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    BoardService boardService;

    @PostMapping("/modify")
    public String modify(BoardDto boardDto, Integer page, Integer pageSize, HttpSession session, RedirectAttributes ra) {
        Integer bno = boardDto.getBno();
        try {
            if (loginCheck(session, bno)) {
                Integer viewCnt = boardService.read(bno).getViewCnt();
                boardService.update(boardDto);
                boardService.updateViewCnt(bno, viewCnt - 4);
                ra.addFlashAttribute("msg", "modifyOk");
            } else {
                ra.addFlashAttribute("msg", "modifyX");
            }
            ra.addAttribute("page", page);
            ra.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/board/read?bno=" + bno;
    }

    @PostMapping("/delete")
    public String delete(Integer bno, Integer page, Integer pageSize, HttpSession session, RedirectAttributes ra) {
        try {
            String writer = boardService.read(bno).getWriter();
            if (loginCheck(session, bno)) {
                boardService.delete(bno, writer);
                ra.addFlashAttribute("msg", "deleteOk");
            } else {
                ra.addFlashAttribute("msg", "deleteX");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/board/list?page=" + page + "&pageSize" + pageSize;
    }

    @GetMapping("/write")
    public String write(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        String id = (String) session.getAttribute("id");

        try {
            // ???????????? ??? ????????? ??????
            if (id == null) {
                model.addAttribute("msg", "LOGIN_REQ");
                request.setAttribute("url", request.getRequestURL());
                return "forward:/login/login";
            }

            model.addAttribute("mode", "write");
            BoardDto boardDto = new BoardDto();
            boardDto.setWriter(id);
            boardDto.setBno(0); // Uncaught SyntaxError: Unexpected token ';' ?????????
            model.addAttribute(boardDto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "board";
    }

    @PostMapping("/write")
    public String write(BoardDto boardDto, RedirectAttributes ra) {
        try {
            if (boardService.insert(boardDto) != 1) {
                ra.addFlashAttribute("msg", "registerX");
                ra.addFlashAttribute(boardDto);
                return "redirect:/board/write";
            }
            ra.addFlashAttribute("msg", "registerOk");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/board/list";
    }

    @GetMapping("/read")
    public String read(Integer bno, Model model, Integer page, Integer pageSize) {
        try {
            BoardDto boardDto = boardService.read(bno);
            model.addAttribute(boardDto);
            model.addAttribute("page", page);
            model.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "board";
    }

    @GetMapping("/list")
    public String list(Integer page, Integer pageSize, Model model, String keyword) {
        try {
            List<BoardDto> list;
            // 0. ???????????? ????????? ?????? ?????????
            page = (page == null ? 1 : page);
            pageSize = (pageSize == null ? 10 : pageSize);
            int totalCnt = boardService.selectCnt();
            PageHandler ph = new PageHandler(totalCnt, page, pageSize);

            // 1. ???????????? ?????? ?????? ?????????
            if (keyword == null || "".equals(keyword)) {
                list = boardService.selectPage((page - 1) * pageSize, pageSize);
            } else {
                // 2. ???????????? ?????? ?????? ?????????
                list = boardService.selectSearchData(keyword, (page - 1) * pageSize, pageSize);
                totalCnt = boardService.selectSearchDataCnt(keyword);
                ph = new PageHandler(totalCnt, page, pageSize);

                // ????????????????????? page ?????? ????????????????????? ????????? ????????? page=1??? ?????????
                if (ph.getTotalPageCnt() < page) {
                    return "redirect:/board/list?page=1&keyword=" + keyword;
                }
                model.addAttribute("keyword", keyword);
                model.addAttribute("searchedCnt", totalCnt);
            }

            // ??????, ?????? ?????? ??? ????????? ?????? '.....' ?????????
            for (BoardDto boardDto : list) {
                String title = boardDto.getTitle();
                if (15 < title.length()) {
                    boardDto.setTitle(title.substring(0, 15) + ".....");
                }
                String content = boardDto.getContent();
                if (29 < content.length()) {
                    boardDto.setContent(content.substring(0, 29) + ".....");
                }
            }
            model.addAttribute("list", list);
            model.addAttribute("ph", ph);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "boardList";
    }

    // ???????????? ???????????? ????????? ???????????? ??????
    private boolean loginCheck(HttpSession session, Integer bno) throws Exception {
        String id = (String) session.getAttribute("id");
        String writer = boardService.read(bno).getWriter();

        return id.equals(writer);
    }
}
