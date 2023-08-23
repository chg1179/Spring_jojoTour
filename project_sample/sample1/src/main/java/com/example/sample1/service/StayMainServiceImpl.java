package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.StayMainMapper;
import com.example.sample1.model.Product;
import com.example.sample1.model.Stay;
import com.example.sample1.model.StayImg;

@Service
public class StayMainServiceImpl implements StayMainService{
	
	@Autowired
	StayMainMapper stayMainMapper;
	
	// 숙소 리스트
	@Override
	public List<Product> showStayList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.viewStayList(map);
	}
	
	// 숙소 서비스 리스트
	@Override
	public List<Stay> searchServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.selectServiceList(map);
	}
	
	// 룸 정보
	@Override
	public List<Product> searchRoomList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.selectRoomList(map);
	}
	
	// 찜 하기
	@Override
	public int addJjim(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.insertJjim(map);
	}
	
	// 상세 페이지 숙소 정보
	@Override
	public Product searchStayInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.selectStayInfo(map);
	}
	
	// 메인페이지 정보
	@Override
	public Stay searchStayView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.selectStayView(map);
	}

	@Override
	public int addCart(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.insertCart(map);
	}

	@Override
	public List<StayImg> searchImgList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return stayMainMapper.selectImgList(map);
	}

	
	
}
