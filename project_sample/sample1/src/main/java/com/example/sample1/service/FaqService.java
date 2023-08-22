package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Board;
import com.example.sample1.model.Faq;
import com.example.sample1.model.Test;

public interface FaqService {

	
	//faq 리스트 출력
	List<Faq> searchFaqList(HashMap<String, Object> map);
	// faq 보기
	HashMap<String, Object> searchFaqInfo(HashMap<String, Object> map);
	//faq 삭제
	int removeFaq(HashMap<String, Object> map);
	// faq 등록
	int addFaq(HashMap<String, Object> map);
	// faq 수정
	int editFaq(HashMap<String, Object> map);
	//체크리스트 삭제
	int removeFaqCheck(HashMap<String, Object> map);
	
}
