package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.RentCar;

public interface RentCarService {
	// 렌트카 정보 리스트 출력
	List<RentCar> searchRentCarList(HashMap<String, Object> map);
	
	// 렌트카 상세 정보 출력
	RentCar searchRentCarInfo(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int removeRentCar(HashMap<String, Object> map);
	
	//렌트카 패키지 신청
	int addRentPack(HashMap<String, Object> map);
		
	//렌트카 패키지 신청 취소
	int removeRentPack(HashMap<String, Object> map);
	
	//렌트카 추가
	int addRentCar(HashMap<String, Object> map);
	
	//렌트카 정보 수정
	int editRentCar(HashMap<String, Object> map);
}
