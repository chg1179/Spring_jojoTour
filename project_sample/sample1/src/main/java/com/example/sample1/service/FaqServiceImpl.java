package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.BoardMapper;
import com.example.sample1.mapper.FaqMapper;
import com.example.sample1.mapper.TestMapper;
import com.example.sample1.model.Board;
import com.example.sample1.model.Faq;
import com.example.sample1.model.Test;

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
	public List<Faq> searchFaqList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return faqMapper.selectFaqList(map);
	}
	
	@Override
	public HashMap<String, Object> searchFaqInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		faqMapper.faqCnt(map);
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
