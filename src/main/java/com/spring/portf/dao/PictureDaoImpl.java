package com.spring.portf.dao;

import com.spring.portf.domain.PictureDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PictureDaoImpl implements PictureDao {
    @Autowired
    SqlSession session;
    private final String namespace = "com.spring.portf.dao.PictureMapper.";

    @Override
    public int selectCnt() throws Exception {
        return session.selectOne(namespace + "selectCnt");
    }

    @Override
    public List<PictureDto> selectAll() throws Exception {
        return session.selectList(namespace + "selectAll");
    }

    @Override
    public List<PictureDto> selectList(Integer offset, Integer pageSize) throws Exception {
        Map map = new HashMap();
        map.put("offset", offset);
        map.put("pageSize", pageSize);
        return session.selectList(namespace + "selectList", map);
    }

    @Override
    public PictureDto select(Integer pno) throws Exception {
        return session.selectOne(namespace + "select", pno);
    }

    @Override
    public int deleteAll() throws Exception {
        return session.delete(namespace + "deleteAll");
    }

    @Override
    public int delete(Integer pno, String writer) throws Exception {
        Map map = new HashMap();
        map.put("pno", pno);
        map.put("writer", writer);
        return session.delete(namespace + "delete", map);
    }

    @Override
    public int insert(PictureDto pictureDto) throws Exception {
        return session.insert(namespace + "insert", pictureDto);
    }

    @Override
    public int update(PictureDto pictureDto) throws Exception {
        return session.update(namespace + "update", pictureDto);
    }
}