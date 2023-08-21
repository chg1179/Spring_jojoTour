package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Admin;

@Mapper
public interface AdminMapper {
	//리퀘스트 넣기
	Integer insertRequest(HashMap<String, Object> map);
	//렌트카 리퀘스트 리스트
	List<Admin> rentRequest(HashMap<String, Object> map);
	//룸 리퀘스트 리스트
	List<Admin> roomRequest(HashMap<String, Object> map);
	//레져 리퀘스트 리스트
	List<Admin> leisureRequest(HashMap<String, Object> map);
	//허용 리퀘스트 리스트
	List<Admin> selectReqList(HashMap<String, Object> map);
	//리퀘스트 허용
	int stateChange(HashMap<String, Object> map);
	//패키지 인서트
	int insertPackage(HashMap<String, Object> map);
}
