package com.example.sample1.model;

import lombok.Data;

@Data
public class Product {
	
	private String uId;
	
	// stay
	private int stayNo;
	private String stayName;
	private String sAddr;
	private String sDetailAddr;
	private String stayKind;
	
	// room
	private int roomNo;
	private String roomName;
	private int roomPrice;
	private String roomSales;
	private String peopleMax;
	
	// rent
	private int rentNo;
	private String rentName;
	private String rentPrice;
	private String rentSales;
	private String rAddr;
	private String rDetailAddr;
	private String rentKind;
		
	// leisure
	private int leisureNo;
	private String leisureName;
	private String leisurePrice;
	private String leisureSales;
	private String lAddr;
	private String lDetailAddr;
	private String leisureKind;
	
	// code_type
	private String cKind;
	private String cName;
	private String cType;
}
