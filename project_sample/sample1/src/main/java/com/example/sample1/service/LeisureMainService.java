package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Leisure;
import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

public interface LeisureMainService {
	//워터레저 리스트 출력
	HashMap<String, Object> searchLeisureList(HashMap<String, Object> map);
	//워터레저 종류별 리스트 출력
	HashMap<String, Object> searchWaterLeisureKindList(HashMap<String, Object> map);
	
}
