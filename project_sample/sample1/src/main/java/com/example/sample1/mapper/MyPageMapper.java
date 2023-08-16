package com.example.sample1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.MyPage;


@Mapper
public interface MyPageMapper {
	MyPage selectOrder(HashMap<String, Object> map);
}
