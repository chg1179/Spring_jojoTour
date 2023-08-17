package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Stay;

@Mapper
public interface StayMapper {
	// 숙소 업체 목록 출력
	List<Stay> selectStayList(HashMap<String, Object> map);
	
	// 숙소 업체 등록
	int insertStay(HashMap<String, Object> map);
	
	// 숙소 타입 리스트
	List<Stay> selectStayTypeList(HashMap<String, Object> map);
	
	// 숙소 업체 삭제
	int deleteStay(HashMap<String, Object> map);
	
	
	
	// 숙소 정보
	Stay selectStayInfo(HashMap<String, Object> map);
	
	// 숙소 정보 수정
	int updateStayInfo(HashMap<String, Object> map);
} 
