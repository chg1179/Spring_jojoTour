package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.BoardMapper;
import com.example.sample1.mapper.FaqMapper;
import com.example.sample1.model.Board;
import com.example.sample1.model.Faq;

@Service
public class FaqServiceImpl implements FaqService{

	@Autowired
	FaqMapper faqMapper;

	@Override
	public int addFaq(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return faqMapper.insertFaq(map);
	}
	
	@Override
	public HashMap<String, Object> searchFaqList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", faqMapper.selectFaqList(map));
		resultMap.put("cnt", faqMapper.selectCnt(map));
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> searchFaqInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		faqMapper.faqCnt(map);
		map.put("search", "UP"); //다음글
		resultMap.put("upBoard", faqMapper.selectNextTitle(map));
		
		map.put("search", "DOWN"); //이전글
		resultMap.put("downBoard", faqMapper.selectNextTitle(map));
		resultMap.put("info", faqMapper.selectFaqInfo(map));
		
		return resultMap;
	}
	
	@Override
	public int removeFaq(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		return faqMapper.deleteFaq(map);
	}
	
	@Override
	public int editFaq(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return faqMapper.updateFaq(map);
	}

	@Override
	public int removeFaqCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return faqMapper.deleteFaqCheck(map);
	}

	


}
