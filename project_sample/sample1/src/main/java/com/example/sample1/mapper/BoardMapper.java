package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Board;
import com.example.sample1.model.Test;

@Mapper
public interface BoardMapper {
	// 공지사항 등록
	int insertNotice(HashMap<String, Object> map);
	// 공지사항 검색
	List<Board> selectNoticeList(HashMap<String, Object> map);
	int selectCnt(HashMap<String, Object> map);
	// 공지사항 보기
	Board selectNoticeInfo(HashMap<String, Object> map);
	// 공지사항 삭제
	int deleteNotice(HashMap<String, Object> map);
	
	int noticeCnt(HashMap<String, Object> map);
	
	int updateNotice(HashMap<String, Object> map);
	
	//체크한 게시글 삭제
	int deleteNoticeCheck(HashMap<String, Object> map);

}
