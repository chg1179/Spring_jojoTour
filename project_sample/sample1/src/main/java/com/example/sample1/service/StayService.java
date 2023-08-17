package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Room;
import com.example.sample1.model.Stay;

public interface StayService {
	
	// 숙소 업체 목록 출력
	List<Stay> searchStayList(HashMap<String, Object> map);
	
	// 숙소 업체 등록
	HashMap<String, Object> addStay(HashMap<String, Object> map);
	
	// 숙소 타입 리스트
	List<Stay> searchStayTypeList(HashMap<String, Object> map);
	
	// 숙소 업체 삭제
	int removeStay(HashMap<String, Object> map);
	
	// 숙소 편의시설 리스트
	List<Stay> searchServiceList(HashMap<String, Object> map);
	
	// 숙소 정보
	Stay searchStayInfo(HashMap<String, Object> map);
	
	// 숙소 정보 수정
	int editStayInfo(HashMap<String, Object> map);
	
	/*
	 * // 숙소 편의시설 인서트 int addStayService(HashMap<String, Object> map);
	 */
}
