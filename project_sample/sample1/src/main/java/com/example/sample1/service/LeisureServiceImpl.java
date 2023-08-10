package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.LeisureMapper;
import com.example.sample1.model.Leisure;

@Service
public class LeisureServiceImpl implements LeisureService{
	
	@Autowired
	LeisureMapper leisureMapper;
	
	@Override
	public List<Leisure> searchLeisureList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.selectLeisureList(map);
	}
}
