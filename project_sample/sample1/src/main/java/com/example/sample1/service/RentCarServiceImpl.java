package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.RentCarMapper;
import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;

@Service
public class RentCarServiceImpl implements RentCarService{
	
	@Autowired
	RentCarMapper rentCarMapper;

	//리스트 출력
	@Override
	public HashMap<String, Object> searchRentCarList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("carList", rentCarMapper.selectRentCarList(map));
		resultMap.put("cnt", rentCarMapper.selectCnt(map));
		return resultMap;
	}

	//상세정보 출력
	@Override
	public RentCar searchRentCarInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.selectRentCarInfo(map);
	}
	
	//렌트카 삭제
	@Override
	public int removeRentCar(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		rentCarMapper.deleteRentCarImg(map);
		return rentCarMapper.deleteRentCar(map);
	}
	
	//렌트카 패키지 신청
	@Override
	public int addRentPack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.insertRentPack(map);
	}

	//렌트카 패키지 신청 취소
	@Override
	public int removeRentPack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.deleteRentPack(map);
	}

	//렌트카 정보 수정
	@Override
	public int editRentCar(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.updateRentCar(map);
	}

	//렌트카 추가
	@Override
	public HashMap<String, Object> addRentCar(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarMapper.insertRentCar(map);
		resultMap.put("rentNo", map.get("rentNo"));
		return resultMap;
	}

	//렌트카 이미지 추가
	@Override
	public int addRentImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.insertRentImg(map);
	}

	//렌트카 이미지 리스트
	@Override
	public List<RentCarImg> searchCarImgList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.selectCarImgList(map);
	}

}
