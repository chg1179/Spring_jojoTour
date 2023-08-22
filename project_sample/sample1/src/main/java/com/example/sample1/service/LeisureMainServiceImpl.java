package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.LeisureMainMapper;
import com.example.sample1.model.Leisure;

@Service
public class LeisureMainServiceImpl implements LeisureMainService{
	
	@Autowired
	LeisureMainMapper leisureMainMapper;

	@Override
	public HashMap<String, Object> searchLeisureList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectLeisureList(map));
		resultMap.put("cnt", leisureMainMapper.selectWaterLeisureCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchWaterLeisureKindList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectWaterLeisureKind(map));
		resultMap.put("cnt", leisureMainMapper.selectWaterLeisureKindCnt(map));
		return resultMap;
	}

	


}
