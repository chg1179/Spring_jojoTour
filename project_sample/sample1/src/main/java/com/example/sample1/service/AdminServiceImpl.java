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
	
	//리퀘스트 넣기
	@Override
	public Integer requestInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.insertRequest(map);
	}

	//리퀘스트 신청 허용
	//@Override
	//public int appRequest(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
	//	return adminMapper.requestApp(map);
	//}

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

	@Override
	public List<Admin> searchReqList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectReqList(map);
	}

	@Override
	public int changeState(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.stateChange(map);
	}

	@Override
	public int packageInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.insertPackage(map);
	}

	@Override
	public HashMap<String, Object> userPage(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", userMapper.pageUser(map));
		resultMap.put("cnt", userMapper.cntUserPage(map));
		return resultMap;
	}
	@Override
	public HashMap<String, Object> hostPage(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", userMapper.pageHost(map));
		resultMap.put("cnt", userMapper.cntHostPage(map));
		return resultMap;
	}
}
