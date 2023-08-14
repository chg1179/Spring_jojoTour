package com.example.sample1.service;

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
	public List<Stay> searchStayList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectStayList(map);
	}

	@Override
	public int addStay(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.insertStay(map);
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
	public List<Stay> searchServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMapper.selectServiceList(map);
	}


	
}
