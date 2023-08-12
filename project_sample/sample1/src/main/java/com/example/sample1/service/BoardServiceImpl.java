package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.BoardMapper;
import com.example.sample1.mapper.TestMapper;
import com.example.sample1.model.Board;
import com.example.sample1.model.Test;

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
	public List<Board> searchNoticeList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return boardMapper.selectNoticeList(map);
	}

	@Override
	public HashMap<String, Object> searchNoticeInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.noticeCnt(map);
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





}
