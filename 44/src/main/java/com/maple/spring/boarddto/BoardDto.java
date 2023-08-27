package com.maple.spring.boarddto;

public class BoardDto {
   private int num;
   private String title;
   private String writer;
   private String title_content;
   private String server;
   private String content;
   private String prevContent;
   private String nextContent;
   private int viewcount;
   private int agree;
   private String regdate;
   private String prevRegDate;
   private String nextRegDate;
   private int StartRowNum;
   private int EndRowNum;
   private int prevNum; //이전글의 글번호
   private int nextNum; //다음글의 글번호
   
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
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
   public int getViewcount() {
      return viewcount;
   }
   public void setViewcount(int viewcount) {
      this.viewcount = viewcount;
   }
   public String getRegdate() {
      return regdate;
   }
   public void setRegdate(String regdate) {
      this.regdate = regdate;
   }
   public int getAgree() {
      return agree;
   }
   public void setAgree(int agree) {
      this.agree = agree;
   }
   public int getStartRowNum() {
      return StartRowNum;
   }
   public void setStartRowNum(int startRowNum) {
      StartRowNum = startRowNum;
   }
   public int getEndRowNum() {
      return EndRowNum;
   }
   public void setEndRowNum(int endRowNum) {
      EndRowNum = endRowNum;
   }
   public int getPrevNum() {
      return prevNum;
   }
   public void setPrevNum(int prevNum) {
      this.prevNum = prevNum;
   }
   public int getNextNum() {
      return nextNum;
   }
   public void setNextNum(int nextNum) {
      this.nextNum = nextNum;
   }
   public String getServer() {
      return server;
   }
   public void setServer(String server) {
      this.server = server;
   }
   public String getTitle_content() {
      return title_content;
   }
   public void setTitle_content(String title_content) {
      this.title_content = title_content;
   }
   public String getPrevContent() {
      return prevContent;
   }
   public void setPrevContent(String prevContent) {
      this.prevContent = prevContent;
   }
   public String getNextContent() {
      return nextContent;
   }
   public void setNextContent(String nextContent) {
      this.nextContent = nextContent;
   }
   public String getPrevRegDate() {
		return prevRegDate;
	}
	public void setPrevRegDate(String prevRegDate) {
		this.prevRegDate = prevRegDate;
	}
	public String getNextRegDate() {
		return nextRegDate;
	}
	public void setNextRegDate(String nextRegDate) {
		this.nextRegDate = nextRegDate;
	}
   
}
