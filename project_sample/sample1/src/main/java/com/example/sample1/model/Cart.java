package com.example.sample1.model;

import lombok.Data;

@Data
public class Cart {
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
	private String sReserveDate;
	private String lReserveDate;
	
	// code_type
	private String cKind;
	private String cName;
	private String cType;
	
	private String state;
	
	// 찜
	private String productKind;
	private int productNo;
	
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
	private int cnt;
	
	// service
	private int serviceNo;
	private String serviceName;
	
	private int sCnt;
	
	private int rentNo;
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

	private int rCnt;
	
	private int imgNo;
	private String imgName;
	private String imgSaveName;
	private String imgPath;
	private String imgDate;
	private String mainYn;
	private String imgDelYn;
	
	private String uPwd;
	private String uName;
	private String nickname;
	private String birth;
	private String phone;
	private String email;
	private String addr;
	private String addrDetail;
	private String status;
	private String banyn;
	private String eventyn;
	private int loginCnt;
	private int point;
	private String zipno;
	private String delyn;
	
	private int leisureNo;
	private String leisureName;
	private String leisureKind;
	private double leisureSales;
	private int leisurePrice;
	private String lZipno;
	private String lAddr;
	private String lDetailAddr;
	private int lRead;
	private String lInsertTime;
	private String lUpdateTime;
	private int lResidue;
	private String lDelYN;
	private int lCnt;
	
}
