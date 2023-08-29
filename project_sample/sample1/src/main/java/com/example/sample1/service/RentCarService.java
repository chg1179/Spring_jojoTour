package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

public interface RentCarService {
	// 렌트카 정보 리스트 출력
	HashMap<String, Object> searchRentCarList(HashMap<String, Object> map);
	
	// 렌트카 상세 정보 출력
	RentCar searchRentCarInfo(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int removeRentCar(HashMap<String, Object> map);
	
	//렌트카 패키지 신청
	int addRentPack(HashMap<String, Object> map);
		
	//렌트카 패키지 신청 취소
	int removeRentPack(HashMap<String, Object> map);
	 
	//렌트카 추가
	HashMap<String, Object> addRentCar(HashMap<String, Object> map);
	
	//렌트카 정보 수정
	HashMap<String, Object> editRentCar(HashMap<String, Object> map);
	
	//렌트카 이미지 추가
	int addRentImg(HashMap<String, Object> map);
	
	//렌트카 이미지 수정
	int editRentCarImg(HashMap<String, Object> map);
	
	// 렌트카 이미지 출력
	List<RentCarImg> searchCarImgList(HashMap<String, Object> map);
	
	//렌트카 이미지 수정
	int searchImgCnt(HashMap<String, Object> map);
}
