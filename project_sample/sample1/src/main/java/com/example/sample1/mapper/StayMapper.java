package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Product;

@Mapper
public interface StayMapper {
	// 숙소 업체 목록 출력
	List<Product> selectStayList(HashMap<String, Object> map);
	
	// 숙소 업체 등록
	int insertStay(HashMap<String, Object> map);
	
	// 숙소 타입 리스트
	List<Product> selectStayTypeList(HashMap<String, Object> map);
} 
