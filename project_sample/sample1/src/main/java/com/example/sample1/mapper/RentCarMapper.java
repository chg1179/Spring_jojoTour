package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

@Mapper
public interface RentCarMapper {
	//렌트카 정보 리스트 출력
	List<RentCar> selectRentCarList(HashMap<String, Object> map);
	
	// 전체 갯수
	int selectCnt(HashMap<String, Object> map);
	
	//렌트카 상세 정보 출력
	RentCar selectRentCarInfo(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int deleteRentCar(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int deleteRentCarImg(HashMap<String, Object> map);
	
	//렌트카 패키지 신청
	int insertRentPack(HashMap<String, Object> map);
	
	//렌트카 패키지 신청 취소
	int deleteRentPack(HashMap<String, Object> map);
	
	//렌트카 추가
	int insertRentCar(HashMap<String, Object> map);
	
	//렌트카 정보 수정
	int updateRentCar(HashMap<String, Object> map);
	
	//렌트카 이미지 추가
	int insertRentImg(HashMap<String, Object> map);
	
	//렌트카 이미지 수정
	int updateRentCarImg(HashMap<String, Object> map);
	
	//렌트카 이미지 리스트
	List<RentCarImg> selectCarImgList(HashMap<String, Object> map);
	 
	//이미지명이 중복됐는지 검색
	int selectImgCnt(HashMap<String, Object> map);
}