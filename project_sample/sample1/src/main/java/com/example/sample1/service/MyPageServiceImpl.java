package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.MyPageMapper;
import com.example.sample1.mapper.OrderMapper;
import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;

import jakarta.servlet.http.HttpSession;

@Service
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	MyPageMapper myPageMapper;
	
	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	HttpSession session;

	// 예약내역 전체 리스트 출력. 총금액, 사용완료, 사용전, 취소 COUNT
	@Override
	public List<MyPage> searchOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrder(map);
	}

	// 주문 번호에 따른 주문 제품 가져오기
	@Override
	public HashMap<String, Object> searchOrderInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("orderInfoList", orderMapper.selectOrderList(map));
		resultMap.put("orderUserInfo", myPageMapper.selectOrderUserInfo(map));
		return resultMap;
	}
	
	// 주문 제품에 대한 요청 사항 수정
	@Override
	public int editRequest(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.updateRequest(map);
	}

	
	@Override
	public MyPage searchPoint(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectPoint(map);
	}


	@Override
	public int removeReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.deleteReview(map);
	}



	@Override
	public List<Inquiry> searchInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectInquiry(map);
	}

	@Override
	public int removeInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.deleteInquiry(map);
	}

	@Override
	public Inquiry searchInquiryInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectInquiryInfo(map);
	}

	@Override
	public int updateInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.editInquiry(map);
	}

	@Override
	public HashMap<String, Object> searchJjim(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("jjim", myPageMapper.selectJjim(map));
		resultMap.put("cnt", myPageMapper.selectCnt(map));
		return resultMap;
	}

	@Override
	public int removeJjimCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.deleteJjimCheck(map);
	}

	@Override
	public int searchBookingCancel(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectBookingCancel(map);
	}
	@Override
	public List<MyPage> searchReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectReview(map);
	}

	@Override
	public int searchReviewCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectReviewCnt(map);
	}

	
	




}
