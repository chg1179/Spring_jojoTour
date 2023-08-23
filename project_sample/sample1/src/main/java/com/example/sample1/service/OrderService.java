package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Order;

public interface OrderService {
	List<Order> searchOrderList(HashMap<String, Object> map);
}
