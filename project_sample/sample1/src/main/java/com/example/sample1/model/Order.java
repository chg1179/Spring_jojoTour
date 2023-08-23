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
}
