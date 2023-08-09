package com.example.sample1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.TestMapper;
import com.example.sample1.model.Test;

@Service
public class TestServiceImpl implements TestService{

	@Autowired
	TestMapper testMapper;
	@Override
	public List<Test> searchTest() {
		// TODO Auto-generated method stub
		return testMapper.selectTest();
	}

}
