package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Stay;
import com.example.sample1.model.StayImg;

public interface StayService {
	
	// 숙소 업체 목록 출력
	HashMap<String, Object> searchStayList(HashMap<String, Object> map);
	
	// 숙소 업체 등록, 편의시설 인서트
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
	HashMap<String, Object> editStayInfo(HashMap<String, Object> map);
	
	// 체크된 서비스 리스트 
	List<Stay> checkServiceList(HashMap<String, Object> map);
	
	// 서비스 삭제
	int removeService(HashMap<String, Object> map);
	
	// 숙소 이미지 인서트
	int addStayImg(HashMap<String, Object> map);
	
	// 숙소 이미지 수정
	int editStayImg(HashMap<String, Object> map);
	
	// 숙소 이미지 출력
	StayImg searchStayImgInfo(HashMap<String, Object> map);
}
