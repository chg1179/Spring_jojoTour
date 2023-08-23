package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.CartMapper;
import com.example.sample1.model.Cart;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	CartMapper cartMapper;

	@Override
	public List<Cart> listRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return cartMapper.roomList(map);
	}

	@Override
	public List<Cart> listRent(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return cartMapper.rentList(map);
	}

	@Override
	public List<Cart> listLeisure(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return cartMapper.leisureList(map);
	}

	@Override
	public int removeCart(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return cartMapper.delCart(map);
	}
	
	
}
