package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.MyPage;


@Mapper
public interface MyPageMapper {
	MyPage selectOrder(HashMap<String, Object> map);
	MyPage selectPoint(HashMap<String, Object> map);
	List<MyPage> selectReview(HashMap<String, Object> map);
	int selectReviewCnt(HashMap<String, Object> map);
	int deleteReview(HashMap<String, Object> map);
	MyPage selectReviewInfo(HashMap<String, Object> map);
	int editReview(HashMap<String, Object> map);
}
