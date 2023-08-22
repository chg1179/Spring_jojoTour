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
	
	// 룸 리스트 출력
	@Override
	public List<Room> searchRoomList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomList(map);
	}
	
	// 룸 삭제
	@Override
	public int removeRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		roomMapper.deleteRoomImg(map);
		return roomMapper.deleteRoom(map);
	}
	
	// 룸 정보 출력
	@Override
	public Room searchRoomInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomInfo(map);
	}

	// 룸 수정
	@Override
	public int editRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		return roomMapper.updateRoom(map);
	}

	// 룸 패키지 신청
	@Override
	public int addRoomPack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.insertRoomPack(map);
	}

	// 룸 패키지 취소
	@Override
	public int removeRoomPack(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.deleteRoomPack(map);
	}

	// 룸 등록
	@Override
	public HashMap<String, Object> addRoom(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		roomMapper.insertRoom(map);
		resultMap.put("roomNo", map.get("roomNo"));
		//System.out.println(map.get("roomNo"));
		return resultMap;
	}
	
	// 룸 이미지 등록
	@Override
	public int addRoomImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.insertRoomImg(map);
	}

	// 룸 이미지 수정
	@Override
	public int editRoomImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.updateRoomImg(map);
	}

	// 룸 이미지 정보 
	@Override
	public RoomImg searchRoomImgInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomImgInfo(map);
	}

	

}
