package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Inquiry;
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
	List<Inquiry> searchInquiry(HashMap<String, Object> map);
	int removeInquiry(HashMap<String, Object> map);
	Inquiry searchInquiryInfo(HashMap<String, Object> map);
	//1:1문의 수정
	int updateInquiry(HashMap<String, Object> map);
	// 찜목록
	List<MyPage> searchJjim(HashMap<String, Object> map);
	// 선택한찜목록 삭제
	int removeJjimCheck(HashMap<String, Object> map);
}
