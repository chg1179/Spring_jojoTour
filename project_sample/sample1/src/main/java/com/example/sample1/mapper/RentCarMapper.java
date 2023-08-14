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
}
