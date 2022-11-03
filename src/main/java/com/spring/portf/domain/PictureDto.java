package com.spring.portf.domain;

import java.util.Date;

public class PictureDto {
    private Integer pno;
    private String title;
    private String writer;
    private String content;
    private Date regDate;
    private String filename;
    private String filepath;
    private String originalFilename;

    public PictureDto() {
    }

    public PictureDto(String title, String writer, String content, Date regDate, String filename, String filepath, String originalFilename) {
        this.title = title;
        this.writer = writer;
        this.content = content;
        this.regDate = regDate;
        this.filename = filename;
        this.filepath = filepath;
        this.originalFilename = originalFilename;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    public String getOriginalFilename() {
        return originalFilename;
    }

    public void setOriginalFilename(String originalFilename) {
        this.originalFilename = originalFilename;
    }

    @Override
    public String toString() {
        return "PictureDto{" +
                "pno=" + pno +
                ", title='" + title + '\'' +
                ", writer='" + writer + '\'' +
                ", content='" + content + '\'' +
                ", regDate=" + regDate +
                ", filename='" + filename + '\'' +
                ", filepath='" + filepath + '\'' +
                ", originalFilename='" + originalFilename + '\'' +
                '}';
    }
}
