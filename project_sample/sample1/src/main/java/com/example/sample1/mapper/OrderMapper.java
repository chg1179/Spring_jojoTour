package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Order;

@Mapper
public interface OrderMapper {
	List<Order> selectOrderList(HashMap<String, Object> map);
}
