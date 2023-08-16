package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.MyPage;
import com.example.sample1.model.User;

public interface MyPageService {
	MyPage searchOrder(HashMap<String, Object> map);
}
