package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;


@Mapper
public interface MyPageMapper {
	List<MyPage> selectOrderList(HashMap<String, Object> map);
	MyPage selectOrderInfo(HashMap<String, Object> map);
	MyPage selectPoint(HashMap<String, Object> map);
	int deleteReview(HashMap<String, Object> map);
	List<Inquiry> selectInquiry(HashMap<String, Object> map);
	int deleteInquiry(HashMap<String, Object> map);
	Inquiry selectInquiryInfo(HashMap<String, Object> map);
	// 나의 1:1문의 수정
	int editInquiry(HashMap<String, Object> map);
	// 찜목록!
	List<MyPage> selectJjim(HashMap<String, Object> map);
	int selectCnt(HashMap<String, Object> map);
	//체크한 찜목록 삭제
	int deleteJjimCheck(HashMap<String, Object> map);
	//예약접수중 리스트 출력
	List<MyPage> selectOrderAcceptList(HashMap<String, Object> map);
	//예약완료 리스트 출력
	List<MyPage> selectOrderCompletionList(HashMap<String, Object> map);
	//예약취소 리스트 출력
	List<MyPage> selectOrderCancelList(HashMap<String, Object> map);
	// 예약 취소
	int selectBookingCancel(HashMap<String, Object> map);
	
	//리뷰
	List<MyPage> selectReview(HashMap<String, Object> map);
	int selectReviewCnt(HashMap<String, Object> map);
	
}
