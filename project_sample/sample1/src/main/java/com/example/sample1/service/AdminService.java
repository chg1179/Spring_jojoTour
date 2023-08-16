package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Admin;
import com.example.sample1.model.User;

public interface AdminService {
	
	//유저관리
	List<User> listUser(HashMap<String, Object> map);
	//리퀘스트 보기
	List<Admin> requestList(HashMap<String, Object> map);
	//리퀘스트 신청 허용
	int appRequest(HashMap<String, Object> map);
}
