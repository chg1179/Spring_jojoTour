package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;
import com.example.sample1.model.User;

public interface MyPageService {
	List<MyPage> searchOrderList(HashMap<String, Object> map);
	MyPage searchPoint(HashMap<String, Object> map);
	int removeReview(HashMap<String, Object> map);
	MyPage searchReviewInfo(HashMap<String, Object> map);
	int updateReview(HashMap<String, Object> map);
	List<Inquiry> searchInquiry(HashMap<String, Object> map);
	int removeInquiry(HashMap<String, Object> map);
	Inquiry searchInquiryInfo(HashMap<String, Object> map);
	//1:1문의 수정
	int updateInquiry(HashMap<String, Object> map);
	// 찜목록
	HashMap<String, Object> searchJjim(HashMap<String, Object> map);
	// 선택한찜목록 삭제
	int removeJjimCheck(HashMap<String, Object> map);

	//예약접수중 리스트 출력
	List<MyPage> searchOrderAcceptList(HashMap<String, Object> map);

	//예약완료 리스트 출력
	List<MyPage> searchOrderCompletionList(HashMap<String, Object> map);

	//예약취소 리스트 출력
	List<MyPage> searchOrderCancelList(HashMap<String, Object> map);
	
	//예약취소
	int searchBookingCancel(HashMap<String, Object> map);
}
