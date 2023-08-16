package com.example.sample1.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.MyPageMapper;
import com.example.sample1.model.MyPage;

import jakarta.servlet.http.HttpSession;

@Service
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	MyPageMapper orderMapper;
	
	@Autowired
	HttpSession session;

	@Override
	public MyPage searchOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectOrder(map);
	}
	




}
