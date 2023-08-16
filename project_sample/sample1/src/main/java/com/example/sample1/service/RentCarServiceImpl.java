package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.RentCarMapper;
import com.example.sample1.model.RentCar;

@Service
public class RentCarServiceImpl implements RentCarService{
	
	@Autowired
	RentCarMapper rentCarMapper;

	@Override
	public List<RentCar> searchRentCarList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.selectRentCarList(map);
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
	public int addRentCar(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rentCarMapper.insertRentCar(map);
	}

}
