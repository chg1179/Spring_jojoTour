package com.example.sample1.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.StayMapper;
import com.example.sample1.model.Stay;

@Service
public class StayServiceImpl implements StayService{
	
	@Autowired
	StayMapper stayMapper;

	@Override
	public HashMap<String, Object> searchStayList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("stayList", stayMapper.selectStayList(map));
		resultMap.put("cnt", stayMapper.selectCnt(map));
		return resultMap;
	}


	@Override
	public HashMap<String, Object> addStay(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    
	    // 객실 기본 정보 삽입
	    stayMapper.insertStay(map);
	    
	    resultMap.put("stayNo", map.get("stayNo"));
	    
	    List<Object> list = (List<Object>) map.get("serviceList");
		for(int i=0;i<list.size();i++) {
			map.put("service", list.get(i));
			stayMapper.insertStayService(map);
		}
	    
	    return resultMap;
	}
	
	@Override
	public List<Stay> searchStayTypeList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectStayTypeList(map);
	}

	@Override
	public int removeStay(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.deleteStay(map);
	}

	@Override
	public Stay searchStayInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectStayInfo(map);
	}

	@Override
	public int editStayInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.updateStayInfo(map);
	}
	
	// 숙소 서비스 목록 출력
	@Override
	public List<Stay> searchServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectServiceList(map);
	}




	
}
