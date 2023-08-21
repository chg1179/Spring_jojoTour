package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Product;
import com.example.sample1.model.Stay;

public interface StayMainService {
	// 숙소 상품 리스트 출력
	List<Product> showStayList(HashMap<String, Object> map);
	
	// 숙소 서비스 리스트
	List<Stay> searchServiceList(HashMap<String, Object> map);
	
	// 숙소 룸 리스트
	List<Product> searchRoomList(HashMap<String, Object> map);
	
	// 찜 인서트
	int addJjim(HashMap<String, Object> map);
	
	// 숙소 정보 출력
	Product searchStayInfo(HashMap<String, Object> map);
}
