package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Order;

@Mapper
public interface OrderMapper {
	// 예약 내역 리스트
	List<Order> selectOrderList(HashMap<String, Object> map);
	
	// 예약 상태 업데이트
	int updateOrderSign(HashMap<String, Object> map);
	
	
	
	// 제품 주문 시 사용
	// 주문 번호에 대한 사용자의 정보 insert
	int insertOrder(HashMap<String, Object> map);
	
	// 주문 제품별 정보 insert
	int insertOrderProduct(HashMap<String, Object> map);
	
	
	// 포인트 사용하면 update
	int usePoint(HashMap<String, Object> map);
	
	// 주문한 제품은 장바구니에서 delete
	int deleteCartList(HashMap<String, Object> map);
}
