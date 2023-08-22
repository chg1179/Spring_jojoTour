package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Board;
import com.example.sample1.model.Test;

public interface BoardService {
	//공지사항 검색
	HashMap<String, Object> searchNoticeList(HashMap<String, Object> map);
	// 공지사항 보기
	HashMap<String, Object> searchNoticeInfo(HashMap<String, Object> map);
	//공지사항 삭제
	int removeNotice(HashMap<String, Object> map);
	// 공지사항 등록
	int addNotice(HashMap<String, Object> map);
	// 공지사항 수정
	int editNotice(HashMap<String, Object> map);
	//체크박스한 게시글 삭제
	int removeNoticeCheck(HashMap<String, Object> map);
	

}
