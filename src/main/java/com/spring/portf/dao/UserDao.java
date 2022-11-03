package com.spring.portf.dao;

import com.spring.portf.domain.UserDto;

import java.util.List;

public interface UserDao {
    int selectCnt() throws Exception;

    UserDto select(String id) throws Exception;

    List<UserDto> selectAll() throws Exception;

    int deleteAll() throws Exception;

    int delete(String id, String pwd) throws Exception;

    int insert(UserDto userDto) throws Exception;

    int update(UserDto userDto) throws Exception;
}
