package com.spring.portf.dao;

import com.spring.portf.domain.UserDto;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Calendar;
import java.util.Date;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserDaoImplTest {
    @Autowired
    UserDao userDao;
    Calendar cal;

    @Before
    public void init() {
        cal = Calendar.getInstance();
        cal.clear();
        cal.set(2022, Calendar.SEPTEMBER, 1);
    }

    @Test
    public void selectTest() throws Exception {
        userDao.deleteAll();
        UserDto userDto = new UserDto("testId", "1234", "이름", "test@test.com", new Date(cal.getTimeInMillis()), "insta", new Date());
        assertEquals(1, userDao.insert(userDto));
        userDto.setId("testId2");
        userDao.insert(userDto);
        assertEquals(2, userDao.selectCnt());
    }

    @Test
    public void deleteTest() throws Exception {
        userDao.deleteAll();
        for (int i = 1; i <= 5; i++) {
            UserDto userDto = new UserDto("testId" + i, "1234", "이름", "test@test.com", new Date(cal.getTimeInMillis()), "insta", new Date());
            userDao.insert(userDto);
        }
        assertEquals(1, userDao.delete("testId5", "1234"));
        assertEquals(4, userDao.selectCnt());
    }

    @Test
    public void insertTest() throws Exception {
        userDao.deleteAll();
        UserDto userDto = new UserDto("testId", "1234", "이름", "test@test.com", new Date(cal.getTimeInMillis()), "insta", new Date());
        assertEquals(1, userDao.insert(userDto));
    }

    @Test
    public void updateTest() throws Exception {
        userDao.deleteAll();
        UserDto userDto = new UserDto("testId", "1234", "이름", "test@test.com", new Date(cal.getTimeInMillis()), "insta", new Date());
        assertEquals(1, userDao.insert(userDto));
        userDto.setPwd("4321");
        assertEquals(1, userDao.update(userDto));
        System.out.println(userDto);

    }

}