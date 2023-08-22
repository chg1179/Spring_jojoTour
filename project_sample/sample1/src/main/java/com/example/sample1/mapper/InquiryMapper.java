package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Board;
import com.example.sample1.model.Inquiry;
import com.example.sample1.model.Test;

@Mapper
public interface InquiryMapper {
	// 문의 리스트 출력
	List<Inquiry> selectInquiryList(HashMap<String, Object> map);
	
	// 삭제되지 않은 전체 문의 리스트 갯수(페이징에 사용)
	int selectCnt(HashMap<String, Object> map);
	
	// 유저 및 호스트가 작성한 문의글 pk 최댓값
	int maxNo(HashMap<String, Object> map);
	
	// 삭제된 게시글을 포함한 전체 문의 리스트 갯수. 게시글이 있는지 없는지 체크하여 pk를 구할 때 사용한다
	int noCheck(HashMap<String, Object> map);
	
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
