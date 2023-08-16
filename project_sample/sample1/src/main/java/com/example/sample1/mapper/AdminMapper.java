package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Admin;

@Mapper
public interface AdminMapper {
	//리퀘스트 보기
	List<Admin> selectRequest(HashMap<String, Object> map);
	//리퀘스트 허용
	int requestApp(HashMap<String, Object> map);
}
