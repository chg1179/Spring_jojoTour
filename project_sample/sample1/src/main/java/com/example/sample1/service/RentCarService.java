package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.RentCar;

public interface RentCarService {
	// 렌트카 정보 리스트 출력
	List<RentCar> searchRentCarList(HashMap<String, Object> map);
	
	//렌트카 차 삭제
	int removeRentCar(HashMap<String, Object> map);
}
