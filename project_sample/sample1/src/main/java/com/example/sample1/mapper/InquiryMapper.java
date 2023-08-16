package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Board;
import com.example.sample1.model.Inquiry;
import com.example.sample1.model.Test;

@Mapper
public interface InquiryMapper {
	List<Inquiry> selectInquiryList(HashMap<String, Object> map);
	
	int insertInquiry(HashMap<String, Object> map);
	
	Inquiry selectInquiryInfo(HashMap<String, Object> map);
	// 게시글 삭제
	int deleteInquiry(HashMap<String, Object> map);
	
	int inquiryCnt(HashMap<String, Object> map);
	
	int updateInquiry(HashMap<String, Object> map);
	//체크한 게시글 삭제
	int deleteInquiryCheck(HashMap<String, Object> map);
	// 게시글 답변
	int answerInquiry(HashMap<String, Object> map);
	
}
