package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;
import com.example.sample1.model.Review;
import com.example.sample1.model.User;

public interface ReviewService {
	List<Review> searchReviewList(HashMap<String, Object> map);
	Review searchReview(HashMap<String, Object> map);
	int updateReview(HashMap<String, Object> map);
	int removeReview(HashMap<String, Object> map);
}
