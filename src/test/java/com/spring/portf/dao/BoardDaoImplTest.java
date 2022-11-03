package com.spring.portf.dao;

import com.spring.portf.domain.BoardDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardDaoImplTest {
    @Autowired
    BoardDao boardDao;
    @Autowired
    CommentDao commentDao;

    @Test
    public void selectCntTest() throws Exception {
        boardDao.deleteAll();
        BoardDto boardDto = new BoardDto("test1", "test", "tester");
        for (int i = 0; i < 10; i++) {
            boardDao.insert(boardDto);
        }
        assertEquals(10, boardDao.selectCnt());
    }

    @Test
    public void selectTest() throws Exception {
        boardDao.deleteAll();
        BoardDto boardDto = new BoardDto("test1", "test", "tester");
        boardDao.insert(boardDto);
        Integer bno = boardDao.selectAll().get(0).getBno();
        System.out.println(boardDao.select(bno));
    }

    @Test
    public void selectAllTest() throws Exception {
        boardDao.deleteAll();
        BoardDto boardDto = new BoardDto("test1", "test", "tester");
        for (int i = 0; i < 10; i++) {
            boardDao.insert(boardDto);
        }
        List list = boardDao.selectAll();
        System.out.println(list);
    }

    @Test
    public void selectPageTest() throws Exception {
        insertTest();
        List<BoardDto> list = boardDao.selectPage(10, 10);
        System.out.println(list);
        assertEquals(10, list.size());
    }

    @Test
    public void deleteTest() throws Exception {
        boardDao.deleteAll();
        BoardDto boardDto = new BoardDto("test1", "test", "tester");
        boardDao.insert(boardDto);
        Integer bno = boardDao.selectAll().get(0).getBno();
        assertTrue(boardDao.delete(bno, "tester") == 1);
    }

    @Test
    public void insertTest() throws Exception {
//        boardDao.deleteAll();
        for (int i = 1; i <= 200; i++) {
            BoardDto boardDto = new BoardDto("test" + i, "test", "tester");
            boardDao.insert(boardDto);
        }
//        assertTrue(boardDao.selectCnt() == 200);
    }

    @Test
    public void updateTest() throws Exception {
        boardDao.deleteAll();
        BoardDto boardDto = new BoardDto("test1", "test", "tester");
        assertEquals(1, boardDao.insert(boardDto));
        boardDto.setBno(boardDao.selectAll().get(0).getBno());
        boardDto.setTitle("test2");
        assertEquals(1, boardDao.update(boardDto));
        assertEquals("test2", boardDao.selectAll().get(0).getTitle());
    }

    @Test
    public void selectSearchDataTest() throws Exception {
        boardDao.deleteAll();
        for (int i = 1; i <= 20; i++) {
            BoardDto boardDto = new BoardDto("test" + i, "test" + i, "test");
            boardDao.insert(boardDto);
        }
        String keyword = "1";
        System.out.println(boardDao.selectSearchData(keyword, 1, 10));
        System.out.println(boardDao.selectSearchData(keyword, 1, 10).size());
        System.out.println(boardDao.selectSearchDataCnt(keyword));

    }
}