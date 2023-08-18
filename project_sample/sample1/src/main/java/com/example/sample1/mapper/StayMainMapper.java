package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Stay;

@Mapper
public interface StayMainMapper {
	
	// 숙소 리스트
	List<Stay> viewStayList(HashMap<String, Object> map);
	
	// 슉소 편의시설 리스트
	List<Stay> selectServiceList(HashMap<String, Object> map);
}
