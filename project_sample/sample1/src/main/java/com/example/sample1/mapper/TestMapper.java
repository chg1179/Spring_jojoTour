package com.example.sample1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Test;

@Mapper
public interface TestMapper {
	List<Test> selectTest();
}
