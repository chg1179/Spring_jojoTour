package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Board;
import com.example.sample1.model.Faq;
import com.example.sample1.model.Test;

@Mapper
public interface FaqMapper {

	// faq 등록
	int insertFaq(HashMap<String, Object> map);
	// faq 검색
	List<Faq> selectFaqList(HashMap<String, Object> map);
	// faq 보기
	Faq selectFaqInfo(HashMap<String, Object> map);
	// faq 삭제
	int deleteFaq(HashMap<String, Object> map);
	
	int faqCnt(HashMap<String, Object> map);
	
	int updateFaq(HashMap<String, Object> map);
	
	int deleteFaqCheck(HashMap<String, Object> map);
}
