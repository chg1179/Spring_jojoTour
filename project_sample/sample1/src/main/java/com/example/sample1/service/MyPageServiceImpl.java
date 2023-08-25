package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.MyPageMapper;
import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;

import jakarta.servlet.http.HttpSession;

@Service
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	MyPageMapper myPageMapper;
	
	@Autowired
	HttpSession session;

	@Override
	public List<MyPage> searchOrderList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrderList(map);
	}

	@Override
	public MyPage searchOrderInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrderInfo(map);
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
	public List<MyPage> searchOrderAcceptList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrderAcceptList(map);
	}

	@Override
	public List<MyPage> searchOrderCompletionList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrderCompletionList(map);
	}

	@Override
	public List<MyPage> searchOrderCancelList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrderCancelList(map);
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
