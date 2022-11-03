package com.spring.portf.service;

import com.spring.portf.domain.PictureDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface PictureService {
    int selectCnt() throws Exception;

    List<PictureDto> selectList(Integer offset, Integer pageSize) throws Exception;

    List<PictureDto> selectAll() throws Exception;

    PictureDto read(Integer pno) throws Exception;

    int deleteAll() throws Exception;

    int remove(Integer pno, String writer) throws Exception;

    int write(PictureDto pictureDto) throws Exception;

    int update(PictureDto pictureDto) throws Exception;
}
