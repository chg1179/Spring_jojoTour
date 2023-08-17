package com.example.sample1.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.RoomMapper;
import com.example.sample1.model.Room;

@Service
public class RoomServiceImpl implements RoomService {
	@Autowired
	RoomMapper roomMapper;

	@Override
	public List<Room> searchRoomList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomList(map);
	}

	@Override
	public int removeRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.deleteRoom(map);
	}

	@Override
	public Room searchRoomInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomInfo(map);
	}
	
	// 객실 추가, 서비스 추가
		

	@Override
	public int editRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.updateRoom(map);
	}

	@Override
	public int addRoomPack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.insertRoomPack(map);
	}

	@Override
	public int removeRoomPack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.deleteRoomPack(map);
	}
	
	// 룸서비스 목록 출력
	@Override
	public List<Room> searchServiceList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectServiceList(map);
	}

	@Override
	public HashMap<String, Object> addRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		// 객실 기본 정보 삽입
		roomMapper.insertRoom(map);
		
		// 서비스 인서트
		roomMapper.insertRoomService(map);
		return resultMap;
	}
}
