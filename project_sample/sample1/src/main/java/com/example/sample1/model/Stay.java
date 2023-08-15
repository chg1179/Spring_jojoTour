package com.example.sample1.model;

import lombok.Data;

@Data
public class Stay {
	private int stayNo;
	private String uId;
	private String stayName;
	private String stayKind;
	private String sZipno;
	private String sAddr;
	private String sDetailAddr;
	private String sRead;
	private String sInsertTime;
	private String sUpdateTime;
	private String sDelyn;
	
	// code_type
	private String cKind;
	private String cName;
	private String cType;
	
	// service
	private String serviceNo;
	private String serviceName;
}
