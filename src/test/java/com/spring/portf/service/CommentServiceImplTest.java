package com.spring.portf.service;

import com.spring.portf.domain.BoardDto;
import com.spring.portf.domain.CommentDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CommentServiceImplTest {
    @Autowired
    BoardService boardService;
    @Autowired
    CommentService commentService;

    @Test
    public void commentWriteTest() throws Exception {
        boardService.deleteAll();
        BoardDto boardDto = new BoardDto("test", "test", "test");
        boardService.insert(boardDto);

        Integer bno = boardService.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "test", "testComment", new Date());
        for (int i = 0; i < 5; i++) {
            commentService.write(commentDto);
        }
        assertEquals(5, (int) boardService.read(commentDto.getBno()).getCommentCnt());
    }

    @Test
    public void commentRemoveTest() throws Exception {
        boardService.deleteAll();
        BoardDto boardDto = new BoardDto("board test", "test", "tester1");
        assertEquals(1, boardService.insert(boardDto));

        Integer bno = boardService.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "tester2", "testComment", new Date());
        assertEquals(1, commentService.write(commentDto));
        Integer cno = commentService.selectAllComments().get(0).getCno();
        System.out.println(cno);
        assertEquals(1, commentService.remove(cno, "tester2"));
    }

    @Test
    public void selectCommentList() throws Exception {
        boardService.deleteAll();
        BoardDto boardDto = new BoardDto("board test", "test", "tester1");
        for (int i = 0; i < 10; i++) {
            boardService.insert(boardDto);
        }
        Integer bno = boardService.selectAll().get(0).getBno();
        for (int i = 0; i < 5; i++) {
            commentService.write(new CommentDto(bno, "tester" + i, "testComment", new Date()));
        }
        assertEquals(5, commentService.selectCommentList(bno).size());

    }

    @Test
    public void updateCommentCntTest() throws Exception {
        commentService.deleteAll();
        Integer bno = boardService.selectAll().get(0).getBno();
        System.out.println(bno);
        assertEquals(0, (int) boardService.read(bno).getCommentCnt());

        CommentDto commentDto = new CommentDto(bno, "commenter", "co", new Date());
        commentService.write(commentDto);
        boardService.updateCommentCnt(bno, 1);
        assertEquals(1, (int) boardService.read(bno).getCommentCnt());
    }

    @Test
    public void selectReplyListTest() throws Exception {
//        commentService.deleteAll();
        Integer bno = commentService.selectAllComments().get(0).getBno();
        Integer pcno = commentService.selectAllComments().get(0).getPcno();
        List<CommentDto> list = commentService.selectReplyList(bno, pcno);
        System.out.println("bno = " + bno);
        System.out.println("pcno = " + pcno);
        System.out.println("list = " + list);
    }
}