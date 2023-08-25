package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Leisure;
import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

public interface LeisureMainService {
	//수상레저 리스트 출력
	HashMap<String, Object> searchWaterLeisureList(HashMap<String, Object> map);
	//수상레저 종류별 리스트 출력
	HashMap<String, Object> searchWaterLeisureKindList(HashMap<String, Object> map);
	// 수상레저 검색
	HashMap<String, Object> searchWaterSearchList(HashMap<String, Object> map);
	
	//지상레저 리스트 출력
	HashMap<String, Object> searchGroundLeisureList(HashMap<String, Object> map);
	//지상레저 종류별 리스트 출력
	HashMap<String, Object> searchGroundLeisureKind(HashMap<String, Object> map);
	// 지상레저 검색
	HashMap<String, Object> searchGroundSearchList(HashMap<String, Object> map);
	
	//수상 지상 레저 상세정보
	Leisure searchLeisureInfo(HashMap<String, Object> map);
	
	int addJjim(HashMap<String, Object> map);
	//찜목록해제
	int delJjim(HashMap<String, Object> map);
	
}
