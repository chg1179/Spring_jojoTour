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
			} else if(status == 1) {
				if(user.getDelyn().equals("Y")) {
					resultMap.put("success", false);
					resultMap.put("message", user.getuId() + "는 탈퇴한 회원입니다.");
				}else {
					userMapper.resetUserCnt(map);
					resultMap.put("success", true);
					resultMap.put("message", user.getNickname() + "님 환영합니다.");
					resultMap.put("user", user);
				}
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
	public HashMap<String, Object> searchInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectInfo(map);
		if(user != null) {
				resultMap.put("user", user);
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
			resultMap.put("confirm", "아이디를 찾았습니다.");
		}else {
			resultMap.put("success", false);
			resultMap.put("confirm", "일치하는 아이디가 없습니다.");
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
			resultMap.put("confirm", "비밀번호를 찾았습니다.");
			resultMap.put("user", user);
		}else {
			resultMap.put("success", false);
			resultMap.put("confirm", "일치하는 아이디가 없습니다.");
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

	@Override
	public int updatePwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.changePwd(map);
	}

	@Override
	public int updateMyInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.changeMyInfo(map);
	}

	@Override
	public int removeId(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.deleteId(map);
	}




}
