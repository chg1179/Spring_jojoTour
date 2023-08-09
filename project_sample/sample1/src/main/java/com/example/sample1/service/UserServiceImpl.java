package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.UserMapper;
import com.example.sample1.model.User;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper userMapper;
	
	@Override
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectUser(map);
		if(user != null) {
			if(user.getLoginCnt() >= 5) {
				resultMap.put("success", false);
				resultMap.put("message", "5번 이상 실패, 관리자 문의 하셈");
			} else {
				userMapper.resetUserCnt(map);
				resultMap.put("success", true);
				resultMap.put("message", user.getuName() + "님 환영합니다.");
				resultMap.put("user", user);
			}
		} else {
			resultMap.put("success", false);
			User tempUser = userMapper.userCheckId(map) ;
			if(tempUser != null) {
				userMapper.updateUserCnt(map);
				int cnt = tempUser.getLoginCnt() + 1;
				String message = cnt + "번 실패! \n패스워드 확인해라.";
				if(cnt >= 5) {
					message = "5번 이상 실패, 관리자 한테 문의하셈";
				}
				resultMap.put("message", message);
			} else {
				resultMap.put("message", "없는 아이디");
			}
		}
		
		return resultMap;
	}
	
	@Override
	public int searchUserCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.userCnt(map);
	}

	@Override
	public List<User> listUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<User>) userMapper.userList(map);
	}

}
