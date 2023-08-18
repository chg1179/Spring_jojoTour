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
	
	//유저리스트
	@Override
	public List<User> listUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<User>) userMapper.userList(map);
	}

	//리퀘스트 넣기
	@Override
	public Integer requestInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.insertRequest(map);
	}

	//리퀘스트 신청 허용
	@Override
	public int appRequest(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.requestApp(map);
	}

	//렌트카 리퀘스트 리스트
	@Override
	public List<Admin> requestRent(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.rentRequest(map);
	}

	//룸 리퀘스트 리스트
	@Override
	public List<Admin> requestRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.roomRequest(map);
	}

	//레져 리퀘스트 리스트
	@Override
	public List<Admin> requestLeisure(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.leisureRequest(map);
	}
}
