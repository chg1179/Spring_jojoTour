package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.AdminMapper;
import com.example.sample1.mapper.UserMapper;
import com.example.sample1.model.Admin;
import com.example.sample1.model.User;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	UserMapper userMapper;
	
	@Autowired
	AdminMapper adminMapper;
	
	@Override
	public List<User> listUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<User>) userMapper.userList(map);
	}

	@Override
	public List<Admin> requestList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Admin>) adminMapper.selectRequest(map);
	}

	@Override
	public int appRequest(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.requestApp(map);
	}
}
