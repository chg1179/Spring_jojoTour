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
}
