package com.example.sample1.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.StayMapper;
import com.example.sample1.model.Stay;
import com.example.sample1.model.StayImg;

@Service
public class StayServiceImpl implements StayService{
	
	@Autowired
	StayMapper stayMapper;
	
	// 숙소 리스트 출력
	@Override
	public HashMap<String, Object> searchStayList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("stayList", stayMapper.selectStayList(map));
		resultMap.put("cnt", stayMapper.selectCnt(map));
		return resultMap;
	}

	// 숙소 등록(+서비스)
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
	
	// 숙소 타입 리스트 출력
	@Override
	public List<Stay> searchStayTypeList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectStayTypeList(map);
	}
	
	// 숙소 삭제
	@Override
	public int removeStay(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		stayMapper.deleteStayImg(map);
		return stayMapper.deleteStay(map);
	}

	// 숙소 정보 출력
	@Override
	public Stay searchStayInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectStayInfo(map);
	}
	
	// 숙소 수정 (재등록)
	@Override
	public HashMap<String, Object> editStayInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		stayMapper.updateStayInfo(map);
		
		List<Object> list = (List<Object>) map.get("jsonCheckList");
		for(int i=0;i<list.size();i++) {
			map.put("service", list.get(i));
			stayMapper.insertService2(map);
	  	}		    
		return resultMap;
	}
	
	// 숙소 서비스 목록 출력
	@Override
	public List<Stay> searchServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectServiceList(map);
	}

	// 숙소 서비스 리스트 출력
	@Override
	public List<Stay> checkServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.checkServiceList(map);
	}

	// 서비스 삭제
	@Override
	public int removeService(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.deleteService(map);
	}

	// 이미지 추가
	@Override
	public int addStayImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.insertStayImg(map);
	}
	
	// 이미지 수정
	@Override
	public int editStayImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.updateStayImg(map);
	}

	// 이미지 정보 출력
	@Override
	public StayImg searchStayImgInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectStayImgInfo(map);
	}

}
