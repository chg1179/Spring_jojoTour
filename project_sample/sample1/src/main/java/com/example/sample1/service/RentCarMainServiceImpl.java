package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.RentCarMainMapper;
import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

@Service
public class RentCarMainServiceImpl implements RentCarMainService{
	
	@Autowired
	RentCarMainMapper rentCarMainMapper;

	@Override
	public HashMap<String, Object> searchCarList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", rentCarMainMapper.selectCarList(map));
		resultMap.put("cnt", rentCarMainMapper.selectCarCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchCarKind(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", rentCarMainMapper.selectCarKind(map));
		resultMap.put("cnt", rentCarMainMapper.selectCarKindCnt(map));
		return resultMap;
	}
	//상세정보 출력
	@Override
	public RentCar searchRentCarInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMainMapper.selectRentCarInfo(map);
	}
	
	//렌트카 이미지 리스트
	@Override
	public List<RentCarImg> searchCarImgList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMainMapper.selectCarImgList(map);
	}
	//렌트카 검색
	@Override
	public HashMap<String, Object> searchCarSearchList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", rentCarMainMapper.selectCarSearchList(map));
		resultMap.put("cnt", rentCarMainMapper.selectCarSearchListCnt(map));
		return resultMap;
	}

	@Override
	public int addJjim(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMainMapper.insertJjim(map);
	}



}
