package com.spring.portf.dao;

import com.spring.portf.domain.PictureDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PictureDaoImplTest {
    @Autowired
    PictureDaoImpl pictureDao;

    @Test
    public void selectCntTest() throws Exception {
        pictureDao.deleteAll();
        PictureDto pictureDto = new PictureDto("test", "test", "test", new Date(), "", "", "");
        assertTrue(pictureDao.insert(pictureDto) > 0);
        assertEquals(1, pictureDao.selectCnt());
    }

    @Test
    public void selectListTest() throws Exception {
        pictureDao.deleteAll();
        for (int i = 0; i < 20; i++) {
            PictureDto pictureDto = new PictureDto("test", "test", "test", new Date(), "", "", "");
            pictureDao.insert(pictureDto);
        }
        List<PictureDto> list = pictureDao.selectList(5, 5);
        System.out.println("list = " + list);
    }

    @Test
    public void selectTest() throws Exception {
        pictureDao.deleteAll();
        PictureDto pictureDto = new PictureDto("test", "test", "test", new Date(), "", "", "");
        pictureDao.insert(pictureDto);
        Integer pno = pictureDao.selectAll().get(0).getPno();
        assertNotNull(pictureDao.select(pno));
    }

    @Test
    public void deleteTest() throws Exception {
        pictureDao.deleteAll();
        for (int i = 0; i < 10; i++) {
            PictureDto pictureDto = new PictureDto("test", "test", "test", new Date(), "", "", "");
            pictureDao.insert(pictureDto);
        }
        Integer pno = pictureDao.selectAll().get(0).getPno();
        String writer = pictureDao.selectAll().get(0).getWriter();
        assertEquals(1, pictureDao.delete(pno, writer));
        assertEquals(9, pictureDao.selectCnt());
    }

    @Test
    public void updateTest() throws Exception {
        pictureDao.deleteAll();
        PictureDto pictureDto = new PictureDto("test", "test", "test", new Date(), "", "", "");
        System.out.println(pictureDto);
        assertEquals(1, pictureDao.insert(pictureDto));
        pictureDto.setTitle("test1");
        pictureDao.update(pictureDto);
        assertEquals("test1", pictureDao.selectAll().get(0).getTitle());
    }

    @Test
    public void fileTest() throws Exception {
        PictureDto pictureDto = new PictureDto("test", "test", "test", new Date(), "", "", "");
        String filepath = System.getProperty("user.dir") + "/src/main/webapp/uploadDir";
        pictureDto.setFilepath(filepath);
        pictureDto.setFilename(UUID.randomUUID() + "");
        System.out.println("pictureDto = " + pictureDto);
        pictureDao.insert(pictureDto);
    }
}