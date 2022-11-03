package com.spring.portf.service;

import com.spring.portf.dao.PictureDaoImpl;
import com.spring.portf.domain.PictureDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PictureServiceImpl implements PictureService {
    @Autowired
    PictureDaoImpl pictureDao;

    @Override
    public int selectCnt() throws Exception {
        return pictureDao.selectCnt();
    }

    @Override
    public List<PictureDto> selectList(Integer offset, Integer pageSize) throws Exception {
        return pictureDao.selectList(offset, pageSize);
    }

    @Override
    public List<PictureDto> selectAll() throws Exception {
        return pictureDao.selectAll();
    }

    @Override
    public PictureDto read(Integer pno) throws Exception {
        return pictureDao.select(pno);
    }

    @Override
    public int deleteAll() throws Exception {
        return pictureDao.deleteAll();
    }

    @Override
    public int remove(Integer pno, String writer) throws Exception {
        return pictureDao.delete(pno, writer);
    }

    @Override
    public int write(PictureDto pictureDto) throws Exception {
        return pictureDao.insert(pictureDto);
    }

    @Override
    public int update(PictureDto pictureDto) throws Exception {
        return pictureDao.update(pictureDto);
    }
}
