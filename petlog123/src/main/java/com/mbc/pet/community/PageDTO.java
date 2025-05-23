package com.mbc.pet.community;

public class PageDTO {
    // ?? ??΄μ§? μ²λ¦¬λ₯? ?? λ³?? ? ?Έ
   int boardnumber;
	 String boardwriter, boardtitle, boardcontent, boarddate;
	 int boardreadcnt, groups, step, indent;
   
   private int nowPage;    // ??¬ ??΄μ§? λ²νΈ
   private int startPage;  // ??¬ ?λ©΄μ? λ³΄μ΄? ?? ??΄μ§? λ²νΈ(??΄μ§? λΈλ‘ κΈ°μ?)
   private int endPage;    // ??¬ ?λ©΄μ? λ³΄μ΄? ? ??΄μ§? λ²νΈ(??΄μ§? λΈλ‘ κΈ°μ?)
   private int total;      // ? μ²? ?°?΄?° κ°μ (μ΄? ? μ½λ&κ²μκΈ? ?)
   private int cntPerPage; // ? ??΄μ§??Ή λ³΄μ¬μ€? ?°?΄?° κ°μ
   private int lastPage;   // λ§μ?λ§? ??΄μ§? λ²νΈ (μ΄? ??΄μ§? ?)
   private int start;      // ??¬ ??΄μ§??? DB μ‘°ν ? ?¬?©?  ?? ?Έ?±?€(LIMIT ? ?? ?¬?©)
   private int end;        // ??¬ ??΄μ§??? DB μ‘°ν ? ?¬?©?  ? ?Έ?±?€
   private int cntPage = 10; // ? ?λ©΄μ ???  ??΄μ§? κ°μ (ex: 1~10, 11~20)

    // ?? ??΄μ§??Ή κ°μ ?€?  Getter/Setter
    public int getCntPage() { return cntPage; }
    public void setCntPage(int cntPage) { this.cntPage = cntPage; }

    // ?? κΈ°λ³Έ ??±?
    public PageDTO() {}

    // ?? ??΄μ§? ? λ³΄λ?? ?€? ?? ??±?
    public PageDTO(int total, int nowPage, int cntPerPage) {
        setNowPage(nowPage);       // ??¬ ??΄μ§? ?€? 
        setCntPerPage(cntPerPage); // ??΄μ§??Ή ?°?΄?° κ°μ ?€? 
        setTotal(total);           // ? μ²? ?°?΄?° κ°μ ?€? 
        calcLastPage(getTotal(), getCntPerPage()); // ? μ²? ??΄μ§? κ³μ°
        calcStartEndPage(getNowPage(), cntPage);   // ?? ??΄μ§?, ? ??΄μ§? κ³μ° (??΄μ§? λΈλ‘ κΈ°μ?)
        calcStartEnd(getNowPage(), getCntPerPage()); // DB μ‘°ν? ??? start, end κ³μ°
    }   

    /**
     * ?? 1. ? μ²? ??΄μ§? ? κ³μ°
     * ? μ²? ?°?΄?° κ°μ(total)?? ? ??΄μ§??Ή κ°μ(cntPerPage)λ₯? ???΄ λ§μ?λ§? ??΄μ§? κ³μ°
     */
    public void calcLastPage(int total, int cntPerPage) {
        setLastPage((int) Math.ceil((double) total / (double) cntPerPage)); 
        // Math.ceil()? ?΄?©??¬ ??? ? ?¬λ¦? μ²λ¦¬
        // ?: μ΄? ?°?΄?° 55κ°?, ? ??΄μ§??Ή 10κ°? ? μ΄? ??΄μ§? ? 6 (?¬λ¦? μ²λ¦¬)
    }

    /**
     * ?? 2. ?? ??΄μ§??? ? ??΄μ§? κ³μ°
     * ??¬ ??΄μ§?(nowPage)λ₯? κΈ°μ??Όλ‘? ? ?λ©΄μ ???  ??΄μ§? κ°μ(cntPage)λ§νΌ ?€? 
     */
    public void calcStartEndPage(int nowPage, int cntPage) {
        setEndPage(((int) Math.ceil((double) nowPage / (double) cntPage)) * cntPage);  // ??¬ ??΄μ§?κ°? ?? λΈλ‘? λ§μ?λ§? ??΄μ§? λ²νΈ κ³μ°
        // ??¬ ??΄μ§?κ°? 7?΄λ©? ? ? ?λ©΄μ? ? ??΄μ§?? 10
        // ??¬ ??΄μ§?κ°? 15?΄λ©? ? ? ?λ©΄μ? ? ??΄μ§?? 20

        if (getLastPage() < getEndPage()) {    
            setEndPage(getLastPage());  // λ§μ?λ§? ??΄μ§? λ²νΈκ°? μ΄? ??΄μ§? ?λ³΄λ€ ?¬?€λ©? μ‘°μ 
        }

        setStartPage(getEndPage() - cntPage + 1); //?? ??΄μ§? λ²νΈ ?€?  (? ??΄μ§??? λΈλ‘ κ°μ λΉΌκΈ°)
        if (getStartPage() < 1) {   
            setStartPage(1);  // ?? ??΄μ§?κ°? 1λ³΄λ€ ?? κ²½μ° μ‘°μ 
        }
    }               

    /**
     * ?? 3. DB μΏΌλ¦¬? ?¬?©?  start, end κ°? ?€? 
     * ?°?΄?°λ² μ΄?€?? ?°?΄?°λ₯? κ°?? Έ?¬ ? ?¬?©?  ?Έ?±?€ λ²μλ₯? κ³μ°
     */
    public void calcStartEnd(int nowPage, int cntPerPage) {    
        setEnd(nowPage * cntPerPage); // ??¬ ??΄μ§?? λ§μ?λ§? ?°?΄?° λ²νΈ κ³μ°
        setStart(getEnd() - cntPerPage + 1); // ??¬ ??΄μ§?? ?? ?°?΄?° λ²νΈ κ³?
    }

    // ?? Getter & Setter (κ°? λ³??? κ°μ ?€? ?κ³? κ°?? Έ?€κΈ? ?? λ©μ?)
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
