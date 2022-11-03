package com.spring.portf.domain;

import java.util.Date;

public class CommentDto {
    private Integer cno;
    private Integer bno;
    private Integer pcno;
    private String commenter;
    private String comment;
    private Date commentDate;

    public CommentDto() {
    }

    public CommentDto(Integer bno, String commenter, String comment, Date commentDate) {
        this.bno = bno;
        this.commenter = commenter;
        this.comment = comment;
        this.commentDate = commentDate;
    }

    public Integer getCno() {
        return cno;
    }

    public void setCno(Integer cno) {
        this.cno = cno;
    }

    public Integer getBno() {
        return bno;
    }

    public void setBno(Integer bno) {
        this.bno = bno;
    }

    public Integer getPcno() {
        return pcno;
    }

    public void setPcno(Integer pcno) {
        this.pcno = pcno;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    @Override
    public String toString() {
        return "CommentDto{" +
                "cno=" + cno +
                ", bno=" + bno +
                ", pcno=" + pcno +
                ", commenter='" + commenter + '\'' +
                ", comment='" + comment + '\'' +
                ", commentDate=" + commentDate +
                '}';
    }
}
