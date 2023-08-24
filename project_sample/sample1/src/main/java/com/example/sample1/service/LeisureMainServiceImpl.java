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
	public HashMap<String, Object> searchWaterLeisureList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectWaterLeisureList(map));
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

	@Override
	public HashMap<String, Object> searchGroundLeisureList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectGroundLeisureList(map));
		resultMap.put("cnt", leisureMainMapper.selectGroundLeisureCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchGroundLeisureKind(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectGroundLeisureKind(map));
		resultMap.put("cnt", leisureMainMapper.selectGroundLeisureKindCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchWaterSearchList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectWaterSearchList(map));
		resultMap.put("cnt", leisureMainMapper.selectWaterLeisureSearchCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchGroundSearchList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", leisureMainMapper.selectGroundSearchList(map));
		resultMap.put("cnt", leisureMainMapper.selectGroundLeisureSearchCnt(map));
		return resultMap;
	}

	//레저 상세정보
	@Override
	public Leisure searchLeisureInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//레저 조회수 증가
		leisureMainMapper.lReadPlus(map);
		return leisureMainMapper.selectLeisureInfo(map);
	}

	


}
