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
	
}
