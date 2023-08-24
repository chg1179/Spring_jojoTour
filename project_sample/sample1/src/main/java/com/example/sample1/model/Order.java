package com.example.sample1.model;

import lombok.Data;

@Data
public class Order {
	private int orderNo;
	private String uId;
	private String paymentDate;
	private String productKind;
	private int productNo;
	private int people;
	private String sReserveDate;
	private String lReserveDate;
	private String useYnc;
	private int deduPoint;
	private int payment;
	
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
