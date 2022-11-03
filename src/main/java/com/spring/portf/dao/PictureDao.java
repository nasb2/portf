package com.spring.portf.dao;

import com.spring.portf.domain.PictureDto;

import java.util.List;

public interface PictureDao {
    int selectCnt() throws Exception;

    List<PictureDto> selectAll() throws Exception;

    List<PictureDto> selectList(Integer offset, Integer pageSize) throws Exception;

    PictureDto select(Integer pno) throws Exception;

    int deleteAll() throws Exception;

    int delete(Integer pno, String writer) throws Exception;

    int insert(PictureDto pictureDto) throws Exception;

    int update(PictureDto pictureDto) throws Exception;
}
