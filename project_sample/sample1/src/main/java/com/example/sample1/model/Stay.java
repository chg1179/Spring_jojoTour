package com.example.sample1.model;

import lombok.Data;

@Data
public class Stay {
	private int stayNo;
	private String uId;
	private String stayName;
	private String pAddr;
	private String pDetailAddr;
	
	private String tKind;
	private String tName;
	
	// t2_room_tbl
	private String productNo;
	private String productName;
	private String productPrice;
	private String peopleMax;
}
