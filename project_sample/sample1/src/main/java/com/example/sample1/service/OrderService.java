package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Order;

public interface OrderService {
	// 예약 내역 리스트
	List<Order> searchOrderList(HashMap<String, Object> map);
	
	// 예약 상태 업데이트
	int editOrderSign(HashMap<String, Object> map);
}
