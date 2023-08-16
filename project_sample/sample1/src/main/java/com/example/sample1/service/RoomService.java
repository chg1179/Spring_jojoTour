package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Room;

public interface RoomService {
	// 방 목록 출력
	List<Room> searchRoomList(HashMap<String, Object> map);
	
	// 객실 삭제
	int removeRoom(HashMap<String, Object> map);
	
	// 객실 정보 출력
	Room searchRoomInfo(HashMap<String, Object> map);
	
	// 객실 추가
	int addRoom(HashMap<String, Object> map);
	
	// 객실 정보 수정
	int editRoom(HashMap<String, Object> map);
}
