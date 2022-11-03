package com.spring.portf.dao;

import com.spring.portf.domain.CommentDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CommentDaoImplTest {
    @Autowired
    CommentDao commentDao;
    @Autowired
    BoardDao boardDao;

    @Test
    public void commentCntTest() throws Exception {
        commentDao.deleteAll();
        Integer bno = boardDao.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "tester", "test", new Date());
        commentDao.insert(commentDto);
        assertEquals(1, commentDao.commentCnt());
    }

    @Test
    public void selectTest() throws Exception {
        commentDao.deleteAll();
        Integer bno = boardDao.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "tester", "test", new Date());
        commentDao.insert(commentDto);
        Integer cno = commentDao.selectAllComments().get(0).getCno();
        assertNotNull(commentDao.select(cno));
    }

    @Test
    public void selectAllTest() throws Exception {
        commentDao.deleteAll();
        Integer bno = boardDao.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "tester", "test", new Date());
        List<CommentDto> list = new ArrayList();
        for (int i = 0; i < 10; i++) {
            commentDao.insert(commentDto);
            list.add(commentDto);
        }
        assertEquals(10, commentDao.selectAllComments().size());
    }

    @Test
    public void deleteTest() throws Exception {
        commentDao.deleteAll();
        Integer bno = boardDao.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "tester", "test", new Date());
        commentDao.insert(commentDto);
        Integer cno = commentDao.selectAllComments().get(0).getCno();
        assertEquals(1, commentDao.delete(cno, commentDto.getCommenter()));
    }

    @Test
    public void updateTest() throws Exception {
        commentDao.deleteAll();
        Integer bno = boardDao.selectAll().get(0).getBno();
        CommentDto commentDto = new CommentDto(bno, "tester", "test", new Date());
        commentDao.insert(commentDto);
        Integer cno = commentDao.selectAllComments().get(0).getCno();
        assertEquals("test", commentDao.select(cno).getComment());
        commentDto.setCno(cno); // 생략하면
        commentDto.setComment("test test");
        commentDao.update(commentDto);
        assertEquals("test test", commentDao.select(cno).getComment());
    }

}