package com.example.sample1.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.RentCarMainMapper;

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



}
