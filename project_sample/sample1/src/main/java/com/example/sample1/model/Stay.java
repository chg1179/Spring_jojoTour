package com.example.sample1.model;

import lombok.Data;

@Data
public class Stay {
	private int stayNo;
	private String stayName;
	private String sAddr;
	private String sDetailAddr;
	private String stayKind;
	
	// code_type
	private String cKind;
	private String cName;
	private String cType;
	
	// service
	private String serviceNo;
	private String serviceName;
}
