package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.OrderMapper;
import com.example.sample1.model.Order;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderMapper orderMapper;
	
	@Override
	public List<Order> searchOrderList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectOrderList(map);
	}

	@Override
	public int editOrderSign(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.updateOrderSign(map);
	}
	
}
