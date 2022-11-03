package com.spring.portf.controller;

import com.spring.portf.domain.CommentDto;
import com.spring.portf.service.BoardService;
import com.spring.portf.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@RestController
public class CommentController {
    @Autowired
    BoardService boardService;
    @Autowired
    CommentService commentService;

    @PatchMapping("/comment/{cno}")
    public String modify(@RequestBody CommentDto commentDto, @PathVariable Integer cno, Integer bno, HttpSession session) {
        try {
            String id = (String) session.getAttribute("id");
            String commenter = commentDto.getCommenter();

            if (!commenter.equals(id)) {
                return "LOGIN_ERR";
            }
            String comment = commentService.read(cno).getComment();
            if (comment.equals(commentDto.getComment())) {
                return "NO_DIFF";
            }
            commentDto.setBno(bno);
            commentDto.setCno(cno);
            if (commentService.update(commentDto) != 1) {
                return "MOD_ERR";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "MOD_OK";
    }

    @DeleteMapping("/comment/{cno}")
    public String remove(@PathVariable Integer cno, Integer bno, HttpSession session) {
        try {
            String commenter = (String) session.getAttribute("id");
            if (commentService.remove(cno, commenter) == 1) {
                // 실시간 댓글 수 리턴
                Integer liveCommentCnt = commentService.selectCommentList(bno).size();
                return liveCommentCnt + "";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "DEL_ERR";
    }

    @PostMapping("/comment")
    public String write(@RequestBody CommentDto commentDto, Integer bno, HttpSession session) {
        try {
            String commenter = (String) session.getAttribute("id");
            if (commenter == null) {
                return "LOGIN_ERR";
            }
            if ("".equals(commentDto.getComment())) {
                return "EMPTY_ERR";
            }
            commentDto.setBno(bno);
            commentDto.setCommentDate(new Date());
            commentDto.setCommenter(commenter);
            if (commentService.write(commentDto) == 1) {
                Integer liveCommentCnt = commentService.selectCommentList(bno).size();
                return liveCommentCnt + "";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "WRT_ERR";
    }

    @GetMapping("/comment")
    public List<CommentDto> list(Integer bno, Integer pcno) {
        List<CommentDto> list = null;
        try {
            if (pcno != null) {
                // 대댓글 리스트 return
                list = commentService.selectReplyList(bno, pcno);
            } else {
                // 댓글 리스트 return
                list = commentService.selectCommentList(bno);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
