package com.spring.portf.controller;

public class PageHandler {
    private int totalCnt; // 총 게시물 개수
    private int page; // 현재 페이지
    private int pageSize; // 페이지 크기
    private int totalPageCnt; // 전체 페이지 개수
    private int naviSize = 10; // 내비게이션 크기
    private int beginPage; // 내비게이션 시작번호
    private int endPage; // 내비게이션 끝번호
    private boolean showPrev; // 이전 페이지 보여줄 것인지 여부
    private boolean showNext; // 다음 페이지 보여줄 것인지 여부

    public PageHandler() {
    }

    public PageHandler(int totalCnt, int page, int pageSize) {
        this.totalCnt = totalCnt;
        this.page = page;
        this.pageSize = pageSize;
        this.totalPageCnt = (totalCnt - 1) / pageSize + 1;
        this.beginPage = (page - 1) / pageSize * pageSize + 1;
        this.endPage = Math.min(totalPageCnt, beginPage + 9);
        this.showPrev = !(beginPage == 1);
        this.showNext = !(endPage == totalPageCnt);
    }

    public void printNavi() {
        System.out.print(showPrev ? "[이전페이지] " : "");
        for (int i = beginPage; i <= endPage; i++) {
            System.out.print(i + " ");
        }
        System.out.print(showNext ? "[다음페이지]" : "");
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getTotalPageCnt() {
        return totalPageCnt;
    }

    public void setTotalPageCnt(int totalPageCnt) {
        this.totalPageCnt = totalPageCnt;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getNaviSize() {
        return naviSize;
    }

    public void setNaviSize(int naviSize) {
        this.naviSize = naviSize;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    @Override
    public String toString() {
        return "PageHandler{" +
                "totalCnt=" + totalCnt +
                ", totalPageCnt=" + totalPageCnt +
                ", page=" + page +
                ", pageSize=" + pageSize +
                ", naviSize=" + naviSize +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }
}
