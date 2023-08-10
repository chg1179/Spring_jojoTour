package com.example.sample1.model;

import lombok.Data;

@Data
public class RentCar {
	// rent_tbl 컬럼
	private int productNo;
	private String productName;
	private String productSales;
	private String productPrice;
	private String productKind;
	
	// car_type_tbl 컬럼
	private String carKind;
	private String carType;
	
}
