package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.MyPage;
import com.example.sample1.model.User;

public interface MyPageService {
	MyPage searchOrder(HashMap<String, Object> map);
	MyPage searchPoint(HashMap<String, Object> map);
	List<MyPage> searchReview(HashMap<String, Object> map);
	int searchReviewCnt(HashMap<String, Object> map);
	int removeReview(HashMap<String, Object> map);
	MyPage searchReviewInfo(HashMap<String, Object> map);
	int updateReview(HashMap<String, Object> map);
}
