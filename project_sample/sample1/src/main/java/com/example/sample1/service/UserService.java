package com.example.sample1.service;

import java.util.HashMap;

import com.example.sample1.model.User;

public interface UserService {
	int addUser(HashMap<String, Object> map);
	HashMap<String, Object> userLogin(HashMap<String, Object> map);
	int searchUserCnt(HashMap<String, Object> map);
	int banUser(HashMap<String, Object> map);
	int resetUser(HashMap<String, Object> map);
	int joinPoint(HashMap<String, Object> map);
	HashMap<String, Object> selectId(HashMap<String, Object> map);
	HashMap<String, Object> selectPwd(HashMap<String, Object> map);
	int updatePwd(HashMap<String, Object> map);
	int updateMyInfo(HashMap<String, Object> map);
	HashMap<String, Object> searchInfo(HashMap<String, Object> map);
	//아이디 삭제
	int removeId(HashMap<String, Object> map);
	
	//유저 정보 받아오기(결제시 사용)
	User searchUserInfo(HashMap<String, Object> map);
}
