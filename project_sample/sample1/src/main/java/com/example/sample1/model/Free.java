package com.example.sample1.model;

import lombok.Data;

@Data
public class Free {
	private int freeNo;
	private String freeTitle;
	private String freeContent;
	private String uId;
	private int fHits; // 게시글 조회수
	private String fWriteTime;
	private String fUpdateTime;
	private String delyn;
	private int notifyCnt; // 신고횟수
	private int commCnt; // 댓글갯수
	private int recommend; // 추천수
	
	public int getFreeNo() {
		return freeNo;
	}
	public void setFreeNo(int freeNo) {
		this.freeNo = freeNo;
	}
	public String getFreeTitle() {
		return freeTitle;
	}
	public void setFreeTitle(String freeTitle) {
		this.freeTitle = freeTitle;
	}
	public String getFreeContent() {
		return freeContent;
	}
	public void setFreeContent(String freeContent) {
		this.freeContent = freeContent;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public int getfHits() {
		return fHits;
	}
	public void setfHits(int fHits) {
		this.fHits = fHits;
	}
	public String getfWriteTime() {
		return fWriteTime;
	}
	public void setfWriteTime(String fWriteTime) {
		this.fWriteTime = fWriteTime;
	}
	public String getfUpdateTime() {
		return fUpdateTime;
	}
	public void setfUpdateTime(String fUpdateTime) {
		this.fUpdateTime = fUpdateTime;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public int getNotifyCnt() {
		return notifyCnt;
	}
	public void setNotifyCnt(int notifyCnt) {
		this.notifyCnt = notifyCnt;
	}
	public int getCommCnt() {
		return commCnt;
	}
	public void setCommCnt(int commCnt) {
		this.commCnt = commCnt;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public String getComm() {
		return comm;
	}
	public void setComm(String comm) {
		this.comm = comm;
	}
	public String getcWriteTime() {
		return cWriteTime;
	}
	public void setcWriteTime(String cWriteTime) {
		this.cWriteTime = cWriteTime;
	}
	public String getcUpdateTime() {
		return cUpdateTime;
	}
	public void setcUpdateTime(String cUpdateTime) {
		this.cUpdateTime = cUpdateTime;
	}
	private int cNo; //댓글번호
	private String comm; // 댓글내용
	private String cWriteTime;
	private String cUpdateTime;
}
