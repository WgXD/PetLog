package com.mbc.pet.community;

public class PageDTO {
    // ?Ÿ“? ?˜?´ì§? ì²˜ë¦¬ë¥? ?œ„?•œ ë³??ˆ˜ ?„ ?–¸
   int boardnumber;
	 String boardwriter, boardtitle, boardcontent, boarddate;
	 int boardreadcnt, groups, step, indent;
   
   private int nowPage;    // ?˜„?¬ ?˜?´ì§? ë²ˆí˜¸
   private int startPage;  // ?˜„?¬ ?™”ë©´ì—?„œ ë³´ì´?Š” ?‹œ?‘ ?˜?´ì§? ë²ˆí˜¸(?˜?´ì§? ë¸”ë¡ ê¸°ì?)
   private int endPage;    // ?˜„?¬ ?™”ë©´ì—?„œ ë³´ì´?Š” ? ?˜?´ì§? ë²ˆí˜¸(?˜?´ì§? ë¸”ë¡ ê¸°ì?)
   private int total;      // ? „ì²? ?°?´?„° ê°œìˆ˜ (ì´? ? ˆì½”ë“œ&ê²Œì‹œê¸? ?ˆ˜)
   private int cntPerPage; // ?•œ ?˜?´ì§??‹¹ ë³´ì—¬ì¤? ?°?´?„° ê°œìˆ˜
   private int lastPage;   // ë§ˆì?ë§? ?˜?´ì§? ë²ˆí˜¸ (ì´? ?˜?´ì§? ?ˆ˜)
   private int start;      // ?˜„?¬ ?˜?´ì§??—?„œ DB ì¡°íšŒ ?‹œ ?‚¬?š©?•  ?‹œ?‘ ?¸?±?Š¤(LIMIT ? ˆ?—?„œ ?‚¬?š©)
   private int end;        // ?˜„?¬ ?˜?´ì§??—?„œ DB ì¡°íšŒ ?‹œ ?‚¬?š©?•  ? ?¸?±?Š¤
   private int cntPage = 10; // ?•œ ?™”ë©´ì— ?‘œ?‹œ?•  ?˜?´ì§? ê°œìˆ˜ (ex: 1~10, 11~20)

    // ?Ÿ“? ?˜?´ì§??‹¹ ê°œìˆ˜ ?„¤? • Getter/Setter
    public int getCntPage() { return cntPage; }
    public void setCntPage(int cntPage) { this.cntPage = cntPage; }

    // ?Ÿ“? ê¸°ë³¸ ?ƒ?„±?
    public PageDTO() {}

    // ?Ÿ“? ?˜?´ì§? ? •ë³´ë?? ?„¤? •?•˜?Š” ?ƒ?„±?
    public PageDTO(int total, int nowPage, int cntPerPage) {
        setNowPage(nowPage);       // ?˜„?¬ ?˜?´ì§? ?„¤? •
        setCntPerPage(cntPerPage); // ?˜?´ì§??‹¹ ?°?´?„° ê°œìˆ˜ ?„¤? •
        setTotal(total);           // ? „ì²? ?°?´?„° ê°œìˆ˜ ?„¤? •
        calcLastPage(getTotal(), getCntPerPage()); // ? „ì²? ?˜?´ì§? ê³„ì‚°
        calcStartEndPage(getNowPage(), cntPage);   // ?‹œ?‘ ?˜?´ì§?, ? ?˜?´ì§? ê³„ì‚° (?˜?´ì§? ë¸”ë¡ ê¸°ì?)
        calcStartEnd(getNowPage(), getCntPerPage()); // DB ì¡°íšŒ?— ?•„?š”?•œ start, end ê³„ì‚°
    }   

    /**
     * ?Ÿ“? 1. ? „ì²? ?˜?´ì§? ?ˆ˜ ê³„ì‚°
     * ? „ì²? ?°?´?„° ê°œìˆ˜(total)?? ?•œ ?˜?´ì§??‹¹ ê°œìˆ˜(cntPerPage)ë¥? ?‚˜?ˆ„?–´ ë§ˆì?ë§? ?˜?´ì§? ê³„ì‚°
     */
    public void calcLastPage(int total, int cntPerPage) {
        setLastPage((int) Math.ceil((double) total / (double) cntPerPage)); 
        // Math.ceil()?„ ?´?š©?•˜?—¬ ?†Œ?ˆ˜? ?„ ?˜¬ë¦? ì²˜ë¦¬
        // ?˜ˆ: ì´? ?°?´?„° 55ê°?, ?•œ ?˜?´ì§??‹¹ 10ê°? ?†’ ì´? ?˜?´ì§? ?ˆ˜ 6 (?˜¬ë¦? ì²˜ë¦¬)
    }

    /**
     * ?Ÿ“? 2. ?‹œ?‘ ?˜?´ì§??? ? ?˜?´ì§? ê³„ì‚°
     * ?˜„?¬ ?˜?´ì§?(nowPage)ë¥? ê¸°ì??œ¼ë¡? ?•œ ?™”ë©´ì— ?‘œ?‹œ?•  ?˜?´ì§? ê°œìˆ˜(cntPage)ë§Œí¼ ?„¤? •
     */
    public void calcStartEndPage(int nowPage, int cntPage) {
        setEndPage(((int) Math.ceil((double) nowPage / (double) cntPage)) * cntPage);  // ?˜„?¬ ?˜?´ì§?ê°? ?†?•œ ë¸”ë¡?˜ ë§ˆì?ë§? ?˜?´ì§? ë²ˆí˜¸ ê³„ì‚°
        // ?˜„?¬ ?˜?´ì§?ê°? 7?´ë©? ?†’ ?•œ ?™”ë©´ì—?„œ ? ?˜?´ì§??Š” 10
        // ?˜„?¬ ?˜?´ì§?ê°? 15?´ë©? ?†’ ?•œ ?™”ë©´ì—?„œ ? ?˜?´ì§??Š” 20

        if (getLastPage() < getEndPage()) {    
            setEndPage(getLastPage());  // ë§ˆì?ë§? ?˜?´ì§? ë²ˆí˜¸ê°? ì´? ?˜?´ì§? ?ˆ˜ë³´ë‹¤ ?¬?‹¤ë©? ì¡°ì •
        }

        setStartPage(getEndPage() - cntPage + 1); //?‹œ?‘ ?˜?´ì§? ë²ˆí˜¸ ?„¤? • (? ?˜?´ì§??—?„œ ë¸”ë¡ ê°œìˆ˜ ë¹¼ê¸°)
        if (getStartPage() < 1) {   
            setStartPage(1);  // ?‹œ?‘ ?˜?´ì§?ê°? 1ë³´ë‹¤ ?‘?„ ê²½ìš° ì¡°ì •
        }
    }               

    /**
     * ?Ÿ“? 3. DB ì¿¼ë¦¬?— ?‚¬?š©?•  start, end ê°? ?„¤? •
     * ?°?´?„°ë² ì´?Š¤?—?„œ ?°?´?„°ë¥? ê°?? ¸?˜¬ ?•Œ ?‚¬?š©?•  ?¸?±?Š¤ ë²”ìœ„ë¥? ê³„ì‚°
     */
    public void calcStartEnd(int nowPage, int cntPerPage) {    
        setEnd(nowPage * cntPerPage); // ?˜„?¬ ?˜?´ì§??˜ ë§ˆì?ë§? ?°?´?„° ë²ˆí˜¸ ê³„ì‚°
        setStart(getEnd() - cntPerPage + 1); // ?˜„?¬ ?˜?´ì§??˜ ?‹œ?‘ ?°?´?„° ë²ˆí˜¸ ê³?
    }

    // ?Ÿ“? Getter & Setter (ê°? ë³??ˆ˜?˜ ê°’ì„ ?„¤? •?•˜ê³? ê°?? ¸?˜¤ê¸? ?œ„?•œ ë©”ì„œ?“œ)
    public int getNowPage() { return nowPage; }
    public void setNowPage(int nowPage) { this.nowPage = nowPage; }

    public int getStartPage() { return startPage; }
    public void setStartPage(int startPage) { this.startPage = startPage; }

    public int getEndPage() { return endPage; }
    public void setEndPage(int endPage) { this.endPage = endPage; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }

    public int getCntPerPage() { return cntPerPage; }
    public void setCntPerPage(int cntPerPage) { this.cntPerPage = cntPerPage; }

    public int getLastPage() { return lastPage; }
    public void setLastPage(int lastPage) { this.lastPage = lastPage; }

    public int getStart() { return start; }
    public void setStart(int start) { this.start = start; }

    public int getEnd() { return end; }
    public void setEnd(int end) { this.end = end; }
}
