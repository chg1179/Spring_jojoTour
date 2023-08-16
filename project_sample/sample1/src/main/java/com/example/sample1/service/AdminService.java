package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.User;

public interface AdminService {
	
	//유저관리
	List<User> listUser(HashMap<String, Object> map);
}
