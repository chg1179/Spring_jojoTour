package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.RentCar;

@Mapper
public interface RentCarMapper {
	// 렌터카 정보 리스트 출력
	List<RentCar> selectRentCarList(HashMap<String, Object> map);
}
