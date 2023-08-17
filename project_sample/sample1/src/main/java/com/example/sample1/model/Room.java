package com.example.sample1.model;

public class Room {
	// room
	private int roomNo;
	private int stayNo;
	private String roomName;
	private int roomPrice;
	private double roomSales;
	private int peopleMax;
	private String roomInsertTime;
	private String roomUpdateTime;
	private int roomResidue;
	
	// code_type
	private String cKind;
	private String cName;
	private String cType;
	
	private String state;
	
	// service
	private int serviceNo;
	private String serviceName;
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public int getStayNo() {
		return stayNo;
	}
	public void setStayNo(int stayNo) {
		this.stayNo = stayNo;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}
	public double getRoomSales() {
		return roomSales;
	}
	public void setRoomSales(double roomSales) {
		this.roomSales = roomSales;
	}
	public int getPeopleMax() {
		return peopleMax;
	}
	public void setPeopleMax(int peopleMax) {
		this.peopleMax = peopleMax;
	}
	public String getRoomInsertTime() {
		return roomInsertTime;
	}
	public void setRoomInsertTime(String roomInsertTime) {
		this.roomInsertTime = roomInsertTime;
	}
	public String getRoomUpdateTime() {
		return roomUpdateTime;
	}
	public void setRoomUpdateTime(String roomUpdateTime) {
		this.roomUpdateTime = roomUpdateTime;
	}
	public int getRoomResidue() {
		return roomResidue;
	}
	public void setRoomResidue(int roomResidue) {
		this.roomResidue = roomResidue;
	}
	public String getcKind() {
		return cKind;
	}
	public void setcKind(String cKind) {
		this.cKind = cKind;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getServiceNo() {
		return serviceNo;
	}
	public void setServiceNo(int serviceNo) {
		this.serviceNo = serviceNo;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	
}
