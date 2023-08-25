package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.sample1.model.Order;

public interface OrderService {
	// 예약 내역 리스트
	List<Order> searchOrderList(HashMap<String, Object> map);
	
	// 예약 상태 업데이트
	int editOrderSign(HashMap<String, Object> map);
	
	
	// 제품 주문 시 사용
	// 주문내역추가, 주문제품매치, 포인트사용, 장바구니제거
	int addOrder(HashMap<String, Object> map, List<Map<String, String>> productList);
}
