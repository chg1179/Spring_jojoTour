package com.example.sample1.model;

public class Review {
	private int rNo;
	private String uId;
	private String orderNo;
	private String rTitle;
	private String rContent;
	private int rHits;
	private String rWriteTime;
	private String rUpdateTime;
	private int rStar;
	private int recommend;
	private String delYN;
	private int notyfyCnt;
	
	
	private int imgNo;
	private String imgName;
	private String imgSaveName;
	private String imgPath;
	private String imgDate;
	private String mainYn;
	private String imgDelYN;
	
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public int getrHits() {
		return rHits;
	}
	public void setrHits(int rHits) {
		this.rHits = rHits;
	}
	public String getrWriteTime() {
		return rWriteTime;
	}
	public void setrWriteTime(String rWriteTime) {
		this.rWriteTime = rWriteTime;
	}
	public String getrUpdateTime() {
		return rUpdateTime;
	}
	public void setrUpdateTime(String rUpdateTime) {
		this.rUpdateTime = rUpdateTime;
	}
	public int getrStar() {
		return rStar;
	}
	public void setrStar(int rStar) {
		this.rStar = rStar;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public String getDelYN() {
		return delYN;
	}
	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}
	public int getNotyfyCnt() {
		return notyfyCnt;
	}
	public void setNotyfyCnt(int notyfyCnt) {
		this.notyfyCnt = notyfyCnt;
	}
	public int getImgNo() {
		return imgNo;
	}
	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getImgSaveName() {
		return imgSaveName;
	}
	public void setImgSaveName(String imgSaveName) {
		this.imgSaveName = imgSaveName;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getImgDate() {
		return imgDate;
	}
	public void setImgDate(String imgDate) {
		this.imgDate = imgDate;
	}
	public String getMainYn() {
		return mainYn;
	}
	public void setMainYn(String mainYn) {
		this.mainYn = mainYn;
	}
	public String getImgDelYN() {
		return imgDelYN;
	}
	public void setImgDelYN(String imgDelYN) {
		this.imgDelYN = imgDelYN;
	}
	public String getrTitle() {
		return rTitle;
	}
	public void setrTitle(String rTitle) {
		this.rTitle = rTitle;
	}
}
