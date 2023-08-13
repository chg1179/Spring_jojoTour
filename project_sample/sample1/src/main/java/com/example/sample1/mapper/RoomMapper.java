package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Product;

@Mapper
public interface RoomMapper {

	// 숙소 방 목록 출력
	List<Product> selectRoomList(HashMap<String, Object> map);
	
	// 객실 삭재
	int deleteRoom(HashMap<String, Object> map);
}
