package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Board;
import com.example.sample1.model.Free;


@Mapper
public interface FreeMapper {

	// 게시글 등록
	int insertFree(HashMap<String, Object> map);
	// 게시판 목록 + 검색
	List<Free> selectFreeList(HashMap<String, Object> map);
	int selectCnt(HashMap<String, Object> map);
	// 게시글 상세보기
	Free selectFreeInfo(HashMap<String, Object> map);
	// 댓글 목록
	List<Free> selectFreeComment(HashMap<String, Object> map);
	// 댓글 등록
	int insertFreeComment(HashMap<String, Object> map);
	// 댓글 삭제
	int deleteFreeComment(HashMap<String, Object> map);
	// 조회수 증가
	int freeCnt(HashMap<String, Object> map);

	// 게시글 수정
	int updateFree(HashMap<String, Object> map);
	
	int deleteFreeCheck(HashMap<String, Object> map);
	
	int deleteFree(HashMap<String, Object> map);
}
