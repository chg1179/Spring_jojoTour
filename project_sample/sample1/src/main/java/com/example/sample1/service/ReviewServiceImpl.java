package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.mapper.ReviewMapper;
import com.example.sample1.model.MyPage;
import com.example.sample1.model.RentCarImg;
import com.example.sample1.model.Review;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpSession;

@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	ReviewMapper reviewMapper;
	
	@Autowired
	HttpSession session;

	@Override
	public HashMap<String, Object> searchReviewList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
	      HashMap<String, Object> resultMap = new HashMap<String, Object>();
	      resultMap.put("list", reviewMapper.selectReviewList(map));
	      resultMap.put("cnt", reviewMapper.selectReviewCnt(map));
	      return resultMap;
	}

	@Override
	public Review searchReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		reviewMapper.rHitsPlus(map);
		return reviewMapper.selectReview(map);
	}



	@Override
	public int updateReview(HashMap<String, Object> map) {
		// Review Auto-generated method stub
		return reviewMapper.editReview(map);
	}

	@Override
	public int removeReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return reviewMapper.deleteReview(map);
	}

	@Override
	public int addReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return reviewMapper.insertReview(map);
	}

}
