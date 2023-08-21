package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Product;
import com.example.sample1.model.Stay;

@Mapper
public interface StayMainMapper {
	
	// 숙소 리스트
	List<Product> viewStayList(HashMap<String, Object> map);
	
	// 슉소 편의시설 리스트
	List<Stay> selectServiceList(HashMap<String, Object> map);
	
	// 호텔 상세 정보 
	List<Product> selectRoomList(HashMap<String, Object> map);
	
	// 찜 인서트
	int insertJjim(HashMap<String, Object> map);
	
	// 상세페이지 숙소 정보 출력 
	Product selectStayInfo(HashMap<String, Object> map);
	
	// 메인페이지 숙소 정보 
	Stay selectStayView(HashMap<String, Object> map);
	
	// 장바구니 인서트
	int insertCart(HashMap<String, Object> map);
}
