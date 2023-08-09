package com.example.sample1.service;

import java.util.HashMap;

public interface UserService {
	HashMap<String, Object> userLogin(HashMap<String, Object> map);

	int searchUserCnt(HashMap<String, Object> map);
}
