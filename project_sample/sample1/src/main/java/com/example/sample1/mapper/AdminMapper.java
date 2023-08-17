package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Admin;

@Mapper
public interface AdminMapper {
	//리퀘스트 넣기
	int insertRequest(HashMap<String, Object> map);
	//리퀘스트 허용
	int requestApp(HashMap<String, Object> map);
	//렌트카 리퀘스트 리스트
	List<Admin> rentRequest(HashMap<String, Object> map);
	//룸 리퀘스트 리스트
	List<Admin> roomRequest(HashMap<String, Object> map);
	//레져 리퀘스트 리스트
	List<Admin> leisureRequest(HashMap<String, Object> map);
}
