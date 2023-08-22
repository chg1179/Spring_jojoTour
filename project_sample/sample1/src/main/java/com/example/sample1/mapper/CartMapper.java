package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Cart;

@Mapper
public interface CartMapper {
	
	//룸리스트
	List<Cart> roomList(HashMap<String, Object> map);
	//렌트리스트
	List<Cart> rentList(HashMap<String, Object> map);
	//레저리스트
	List<Cart> leisureList(HashMap<String, Object> map);
}
