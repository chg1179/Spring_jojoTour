package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Stay;

public interface StayMainService {
	// 숙소 상품 리스트 출력
	List<Stay> showStayList(HashMap<String, Object> map);
	
	// 숙소 서비스 리스트
	List<Stay> searchServiceList(HashMap<String, Object> map);
}
