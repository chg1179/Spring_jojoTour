package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.RoomMapper;
import com.example.sample1.model.Room;
import com.example.sample1.model.RoomImg;

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

	@Override
	public HashMap<String, Object> addRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		roomMapper.insertRoom(map);
		resultMap.put("roomNo", map.get("roomNo"));
		//System.out.println(map.get("roomNo"));
		return resultMap;
	}

	@Override
	public int addRoomImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.insertRoomImg(map);
	}

	@Override
	public int editRoomImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.updateRoomImg(map);
	}

	@Override
	public RoomImg searchRoomImgInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomImgInfo(map);
	}

	

}
