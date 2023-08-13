package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Product;

public interface StayService {
	
	// 숙소 업체 목록 출력
	List<Product> searchStayList(HashMap<String, Object> map);
	
	// 숙소 업체 등록
	int addStay(HashMap<String, Object> map);
	
	// 숙소 타입 리스트
	List<Product> searchStayTypeList(HashMap<String, Object> map);
}
