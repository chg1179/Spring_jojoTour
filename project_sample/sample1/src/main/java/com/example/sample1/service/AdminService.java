package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Admin;
import com.example.sample1.model.User;

public interface AdminService {
	
	//유저관리
	List<User> listUser(HashMap<String, Object> map);
	//리퀘스트 넣기
	Integer requestInsert(HashMap<String, Object> map);
	//렌트카 리퀘스트 리스트
	List<Admin> requestRent(HashMap<String, Object> map);
	//룸 리퀘스트 리스트
	List<Admin> requestRoom(HashMap<String, Object> map);
	//레져 리퀘스트 리스트
	List<Admin> requestLeisure(HashMap<String, Object> map);
	//허용 리퀘스트 리스트
	List<Admin> searchReqList(HashMap<String, Object> map);
	//신청 허용
	int changeState(HashMap<String, Object> map);
	//패키지 신청
	int packageInsert(HashMap<String, Object> map);
}
