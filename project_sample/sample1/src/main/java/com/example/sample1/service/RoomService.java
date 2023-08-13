package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Product;

public interface RoomService {
	// 방 목록 출력
	List<Product> searchRoomList(HashMap<String, Object> map);
	
	// 객실 삭제
	int removeRoom(HashMap<String, Object> map);
	
	
}
