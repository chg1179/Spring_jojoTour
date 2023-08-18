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
}