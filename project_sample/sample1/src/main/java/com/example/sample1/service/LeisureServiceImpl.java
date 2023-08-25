package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.LeisureMapper;
import com.example.sample1.model.Leisure;
import com.example.sample1.model.LeisureImg;

@Service
public class LeisureServiceImpl implements LeisureService{
	
	@Autowired
	LeisureMapper leisureMapper;
	
	//리스트 출력
	@Override
	public HashMap<String, Object> searchLeisureList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("leisureList", leisureMapper.selectLeisureList(map));
		resultMap.put("cnt", leisureMapper.selectCnt(map));
		return resultMap;
	}

	//상세정보 출력
	@Override
	public Leisure searchLeisureInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.selectLeisureInfo(map);
	}
	
	//레저 삭제
	@Override
	public int removeLeisure(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		leisureMapper.deleteLeisureImg(map);
		return leisureMapper.deleteLeisure(map);
	}
	
	//레저 패키지 신청
	@Override
	public int addLeisurePack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.insertLeisurePack(map);
	}

	//레저 패키지 신청 취소
	@Override
	public int removeLeisurePack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.deleteLeisurePack(map);
	}

	//레저 추가
	@Override
	public HashMap<String, Object> addLeisure(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureMapper.insertLeisure(map);
		resultMap.put("leisureNo", map.get("leisureNo"));
		System.out.println(map.get("leisureNo"));
		return resultMap;
	}

	//레저 정보 수정
	@Override
	public HashMap<String, Object> editLeisure(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureMapper.updateLeisure(map);
		return resultMap;
	}

	//레저 이미지 추가
	@Override
	public int addLeisureImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.insertLeisureImg(map);
	}

	//레저 이미지 수정
	@Override
	public int editLeisureImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.updateLeisureImg(map);
	}
	
	//레저 이미지 리스트
	@Override
	public List<LeisureImg> searchLeisureImgList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.selectLeisureImgList(map);
	}

	//레저 카트 추가
	@Override
	public int leisureCartAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return leisureMapper.leisureAddCart(map);
	}
}