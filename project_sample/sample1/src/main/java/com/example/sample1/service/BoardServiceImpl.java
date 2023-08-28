package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.BoardMapper;
import com.example.sample1.model.Board;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;

	@Override
	public int addNotice(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return boardMapper.insertNotice(map);
	}

	@Override
	public HashMap<String, Object> searchNoticeList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", boardMapper.selectNoticeList(map));
		resultMap.put("cnt", boardMapper.selectCnt(map));
		return resultMap;
	}

	@Override
	public HashMap<String, Object> searchNoticeInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.noticeCnt(map);
		map.put("search", "UP"); //다음글
		resultMap.put("upBoard", boardMapper.selectNextTitle(map));
		
		map.put("search", "DOWN"); //이전글
		resultMap.put("downBoard", boardMapper.selectNextTitle(map));
		
		resultMap.put("info", boardMapper.selectNoticeInfo(map));
		
		return resultMap;
	}

	@Override
	public int removeNotice(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		return boardMapper.deleteNotice(map);
	}

	@Override
	public int editNotice(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return boardMapper.updateNotice(map);
	}

	@Override
	public int removeNoticeCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return boardMapper.deleteNoticeCheck(map);
	}
	
	
	

}
