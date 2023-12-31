package com.example.sample1.model;

import lombok.Data;

@Data
public class Admin {
	
	//request
	private String state;
	
	//room
	private int roomNo;
	private int stayNo;
	private String stayName;
	private String roomName;
	private int roomPrice;
	private double roomSales;
	private int peopleMax;
	private String roomInsertTime;
	private String roomUpdateTime;
	private int roomResidue;
	
	//rentcar
	private int rentNo;
	private String rentName;
	private String rentKind;
	private double rentSales;
	private int rentPrice;
	private String rZipno;
	private String rAddr;
	private String rDetailAddr;
	private int rRead;
	private String rInsertTime;
	private String rUpdateTime;
	private int rResidue;
	private String rDelYN;
	
	//leisure
	private int productNo;
	private String productName;
	private double productSales;
	private int productPrice;
	private String pAddr;
	private String pDetailAddr;
	private String productKind;
	private String leisureKind;
	private String leisureName;
	private int leisureNo;
	private int leisurePrice;
	private double leisureSales;
	
	//inner
	private String uId;
	
	//package
	private String packageNo;
	private String packageName;
	private int pPrice;
	private int pRead;
	private String pDelyn;
	
	
	
}
