package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Product;

@Mapper
public interface RentCarMapper {
	//렌트카 정보 리스트 출력
	List<Product> selectRentCarList(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int deleteRentCar(HashMap<String, Object> map);
}
