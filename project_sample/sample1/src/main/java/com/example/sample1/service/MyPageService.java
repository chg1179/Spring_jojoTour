package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;
import com.example.sample1.model.User;

public interface MyPageService {
	// 예약내역 전체 리스트 출력. 총금액, 사용완료, 사용전, 취소 COUNT
	List<MyPage> searchOrder(HashMap<String, Object> map);
	
	// 주문 번호에 따른 정보 출력
	HashMap<String, Object> searchOrderInfo(HashMap<String, Object> map);
	
	// 주문자 정보 수정
	int editUserInfo(HashMap<String, Object> map);
	
	// 주문 제품에 대한 요청 사항 수정
	int editRequest(HashMap<String, Object> map);
	
	// 주문 제품 취소 및 포인트 반환
	int revokeOrder(HashMap<String, Object> map);
	
	MyPage searchPoint(HashMap<String, Object> map);
	int removeReview(HashMap<String, Object> map);
	List<Inquiry> searchInquiry(HashMap<String, Object> map);
	int removeInquiry(HashMap<String, Object> map);
	Inquiry searchInquiryInfo(HashMap<String, Object> map);
	//1:1문의 수정
	int updateInquiry(HashMap<String, Object> map);
	
	// 찜목록
	HashMap<String, Object> searchJjim(HashMap<String, Object> map);
	// 선택한찜목록 삭제
	int removeJjimCheck(HashMap<String, Object> map);

	//리뷰
	List<MyPage> searchReview(HashMap<String, Object> map);
	int searchReviewCnt(HashMap<String, Object> map);
}
