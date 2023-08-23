package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Free;


public interface FreeService {
	// 게시글 목록
	HashMap<String, Object> searchFreeList(HashMap<String, Object> map);
	// 게시글 상세보기 + 댓글
	HashMap<String, Object> searchFreeInfo(HashMap<String, Object> map);
	// 댓글 등록
	int addFreeComment(HashMap<String, Object> map);
	// 댓글 삭제
	int removeFreeComment(HashMap<String, Object> map);
	// 게시글 등록
	int addFree(HashMap<String, Object> map);
	// 게시글 수정
	int editFree(HashMap<String, Object> map);
	
	int removeFreeCheck(HashMap<String, Object> map);
	
	int removeFree(HashMap<String, Object> map);
	
	int addReport(HashMap<String, Object> map);
	
	int addRecommend(HashMap<String, Object> map);
}
