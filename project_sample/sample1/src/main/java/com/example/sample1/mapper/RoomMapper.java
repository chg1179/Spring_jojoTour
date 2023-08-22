package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Room;
import com.example.sample1.model.Stay;

@Mapper
public interface RoomMapper {

	// 숙소 방 목록 출력
	List<Room> selectRoomList(HashMap<String, Object> map);
	
	// 객실 삭재
	int deleteRoom(HashMap<String, Object> map);
	
	// 객실 정보 출력
	Room selectRoomInfo(HashMap<String, Object> map);
	
	// 객실 추가
	int insertRoom(HashMap<String, Object> map);
	
	// 객실 정보 수정
	int updateRoom(HashMap<String, Object> map);
	
	// 숙박 패키지 신청
	int insertRoomPack(HashMap<String, Object> map);
	
	// 숙박 패키지 신청 삭제
	int deleteRoomPack(HashMap<String, Object> map);
	
	// 룸 이미지 추가
	int insertRoomImg(HashMap<String, Object> map);
	
}
