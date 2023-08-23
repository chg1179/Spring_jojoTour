package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Cart;

public interface CartService {

	//룸리스트
	List<Cart> listRoom(HashMap<String, Object> map);
	//렌트리스트
	List<Cart> listRent(HashMap<String, Object> map);
	//레저리스트
	List<Cart> listLeisure(HashMap<String, Object> map);
	//장바구니 삭제
	int removeCart(HashMap<String, Object> map);
	
}
