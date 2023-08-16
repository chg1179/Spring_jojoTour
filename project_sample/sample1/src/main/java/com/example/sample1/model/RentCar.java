package com.example.sample1.model;

import lombok.Data;

@Data
public class RentCar {

	private int rentNo;
	private String uId;
	private String rentName;
	private String rentKind;
	private double rentSales;
	private String rentPrice;
	private String rZipno;
	private String rAddr;
	private String rDetailAddr;
	private int rRead;
	private String rInsertTime;
	private String rUpdateTime;
	private int rResidue;
	private String rDelYN;
	
	private String cKind;
	private String cName;
	private String cType;
	
	private String state; 
	
	private int rCnt;
}
