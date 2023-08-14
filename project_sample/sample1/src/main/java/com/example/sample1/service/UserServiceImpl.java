package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.UserMapper;
import com.example.sample1.model.User;

import jakarta.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper userMapper;
	
	@Autowired
	HttpSession session;
	

	@Override
	public int addUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.insertUser(map);
	}
	
	@Override
	public List<User> listUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<User>) userMapper.userList(map);
	}

	@Override
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectUser(map);
		int status = userMapper.statusCnt(map);
		System.out.println(status);
		if(user != null) {
			if(user.getLoginCnt() >= 5) {
				resultMap.put("success", false);
				resultMap.put("message", "5번 이상 실패, 관리자에게 문의 하세요.");
			} else if(status == 1){
				userMapper.resetUserCnt(map);
				resultMap.put("success", true);
				resultMap.put("message", user.getNickName() + "님 환영합니다.");
				resultMap.put("user", user);
			} else {
				resultMap.put("success", false);
				resultMap.put("message", "권한을 확인하세요.");
			}
		} else {
			resultMap.put("success", false);
			User tempUser = userMapper.userCheckId(map) ;
			if(tempUser != null) {
				userMapper.updateUserCnt(map);
				int cnt = tempUser.getLoginCnt() + 1;
				String message = cnt + "번 실패! \n패스워드를 확인하세요.";
				if(cnt >= 5) {
					message = "5번 이상 실패, 관리자 한테 문의하세요.";
				}
				resultMap.put("message", message);
			} else {
				resultMap.put("message", "없는 아이디입니다.");
			}
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectId(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.searchId(map);
		if(user != null) {
			resultMap.put("success", true);
			resultMap.put("message", user.getuId());
			resultMap.put("user", user);
			resultMap.put("confirm", "아이디가 확인되었습니다.");
		}else {
			resultMap.put("success", false);
			resultMap.put("confirm", "이름과 핸드폰 번호를 정확하게 적으세요.");
			resultMap.put("message", "");
		}
		return resultMap;
	}
	@Override
	public HashMap<String, Object> selectPwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.searchPwd(map);
		if(user != null) {
			resultMap.put("success", true);
			resultMap.put("messageId", user.getuId());
			resultMap.put("messagePwd", user.getuPwd());
			resultMap.put("user", user);
		}
		return resultMap;
	}
	@Override
	public int searchUserCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.userCnt(map);
	}

	@Override
	public int banUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.userBan(map);
	}

	@Override
	public int resetUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.userReset(map);
	}

	@Override
	public int joinPoint(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.joinPoint(map);
	}



}
