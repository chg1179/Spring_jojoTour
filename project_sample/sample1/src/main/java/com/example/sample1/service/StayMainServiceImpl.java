package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.StayMainMapper;
import com.example.sample1.model.Stay;

@Service
public class StayMainServiceImpl implements StayMainService{
	
	@Autowired
	StayMainMapper stayMainMapper;
	
	@Override
	public List<Stay> showStayList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.viewStayList(map);
	}

	@Override
	public List<Stay> searchServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.selectServiceList(map);
	}
	
	
}
