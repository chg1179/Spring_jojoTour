package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.InquiryMapper;
import com.example.sample1.mapper.TestMapper;
import com.example.sample1.model.Inquiry;
import com.example.sample1.model.Test;

@Service
public class InquiryServiceImpl implements InquiryService{

	@Autowired
	InquiryMapper inquiryMapper;

	@Override
	public HashMap<String, Object> searchInquiryList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("inquiryList", inquiryMapper.selectInquiryList(map));
		resultMap.put("cnt", inquiryMapper.selectCnt(map));
		System.out.println(inquiryMapper.selectCnt(map));
		return resultMap;
	}

	@Override
	public int addInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return inquiryMapper.insertInquiry(map);
	}

	
	@Override
	public HashMap<String, Object> searchInquiryInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		inquiryMapper.inquiryCnt(map);
		resultMap.put("info", inquiryMapper.selectInquiryInfo(map));
		
		return resultMap;
	}

	@Override
	public int removeInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return inquiryMapper.deleteInquiry(map);
	}

	@Override
	public int editInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return inquiryMapper.updateInquiry(map);
	}

	@Override
	public int removeInquiryCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return inquiryMapper.deleteInquiryCheck(map);
	}

	@Override
	public int replyInquiry(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return inquiryMapper.answerInquiry(map);
	}


}
