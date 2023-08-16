package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.User;

public interface UserService {
	int addUser(HashMap<String, Object> map);
	HashMap<String, Object> userLogin(HashMap<String, Object> map);
	int searchUserCnt(HashMap<String, Object> map);
	List<User> listUser(HashMap<String, Object> map);
	int banUser(HashMap<String, Object> map);
	int resetUser(HashMap<String, Object> map);
	int joinPoint(HashMap<String, Object> map);
	HashMap<String, Object> selectId(HashMap<String, Object> map);
	HashMap<String, Object> selectPwd(HashMap<String, Object> map);
	int updatePwd(HashMap<String, Object> map);
}
