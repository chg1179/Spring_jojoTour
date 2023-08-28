package com.example.sample1.model;

import lombok.Data;

@Data
public class Order {
	
	// order tbl
	private String uId;
	private int people;
	
	// order list
	private String orderNo;
	private String productKind;
	private int productNo;
	private String paymentDate;
	private String sReserveDate;
	private String lReserveDate;
	private String useYnc;
	private int usePoint;
	private int payment;
	private String request;
	
	// stay
	private int stayNo;
	private String stayName;
	private String stayKind;
	
	// room
	private int roomNo;
	private String roomName;
	
	// rent
	private int rentNo;
	private String rentName;
	
	// leisure
	private int leisureNo;
	private String leisureName;
	private String leisureKind;
}
