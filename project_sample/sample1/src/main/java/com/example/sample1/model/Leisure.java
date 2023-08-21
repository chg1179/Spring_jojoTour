package com.example.sample1.model;

import lombok.Data;

@Data
public class Leisure {
	private int leisureNo;
	private String uId;
	private String leisureName;
	private String leisureKind;
	private double leisureSales;
	private String leisurePrice;
	private String lZipno;
	private String lAddr;
	private String lDetailAddr;
	private int lRead;
	private String lInsertTime;
	private String lUpdateTime;
	private int lResidue;
	private String lDelYN;
	
	private String cKind;
	private String cName;
	private String cType;

	private String state; 
	
	private int lCnt;
	
	private int imgNo;
	private String imgName;
	private String imgSaveName;
	private String imgPath;
	private String imgDate;
	private String mainYn;
	private String imgDelYn;
}
