package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.RentCar;

@Mapper
public interface RentCarMapper {
	//렌트카 정보 리스트 출력
	List<RentCar> selectRentCarList(HashMap<String, Object> map);
	
	//렌트카 상세 정보 출력
	RentCar selectRentCarInfo(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int deleteRentCar(HashMap<String, Object> map);
	
	//렌트카 패키지 신청
	int insertRentPack(HashMap<String, Object> map);
	
	//렌트카 패키지 신청 취소
	int deleteRentPack(HashMap<String, Object> map);
	
	//렌트카 추가
	int insertRentCar(HashMap<String, Object> map);
	
	//렌트카 정보 수정
	int updateRentCar(HashMap<String, Object> map);
}