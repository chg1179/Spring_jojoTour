package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.FreeMapper;

import com.example.sample1.model.Free;


@Service
public class FreeServiceImpl implements FreeService{

	@Autowired
	FreeMapper freeMapper;

	@Override
	public HashMap<String, Object> searchFreeList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", freeMapper.selectFreeList(map));
		resultMap.put("cnt", freeMapper.selectCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchFreeInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// 조회수 증가
		if(!map.containsKey("kind")) {
			freeMapper.freeCnt(map);
		}
		// 게시글 상세보기
		resultMap.put("info", freeMapper.selectFreeInfo(map));
		// 댓글 목록
		resultMap.put("commentList", freeMapper.selectFreeComment(map));
		return resultMap;
	}

	@Override
	public int addFreeComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freeMapper.insertFreeComment(map);
	}

	@Override
	public int removeFreeComment(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freeMapper.deleteFreeComment(map);
	}

	@Override
	public int addFree(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freeMapper.insertFree(map);
	}

	@Override
	public int editFree(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freeMapper.updateFree(map);
	}

	@Override
	public int removeFreeCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freeMapper.deleteFreeCheck(map);
	}



}
