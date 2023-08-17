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
	public MyPage searchOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOrder(map);
	}

	@Override
	public MyPage searchPoint(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectPoint(map);
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

	@Override
	public int removeReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.deleteReview(map);
	}

	@Override
	public MyPage searchReviewInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.selectReviewInfo(map);
	}

	@Override
	public int updateReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return myPageMapper.editReview(map);
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
	




}
