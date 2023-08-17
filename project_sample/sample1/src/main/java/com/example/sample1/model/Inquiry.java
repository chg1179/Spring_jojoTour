package com.example.sample1.model;

import lombok.Data;

@Data
public class Inquiry {
	private int iNo;
	private String uId;
	private int categoryNo;
	private int orderNo;
	private String iTitle;
	private String iContent;
	private int iHits;
	private String iWriteTime;
	private String iUpdateTime;
	private String privateYn;
	private String iPassword;
	private String answerYn;
	private String delyn;
	private int parentNo;
}
