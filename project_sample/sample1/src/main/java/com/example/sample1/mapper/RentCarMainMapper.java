package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

@Mapper
public interface RentCarMainMapper {
	//렌트카 리스트
	List<RentCar> selectCarList(HashMap<String, Object> map);
	int selectCarCnt(HashMap<String, Object> map);
	//렌트카 종류별 리스트
	List<RentCar> selectCarKind(HashMap<String, Object> map);
	int selectCarKindCnt(HashMap<String, Object> map);
	//렌트카 상세페이지
	RentCar selectRentCarInfo(HashMap<String, Object> map);
	//렌트카 이미지 리스트
	List<RentCarImg> selectCarImgList(HashMap<String, Object> map);
	// 렌트카 검색 리스트
	List<RentCar> selectCarSearchList(HashMap<String, Object> map);
	//렌트카 검색 카운트
	int selectCarSearchListCnt(HashMap<String, Object> map);
}