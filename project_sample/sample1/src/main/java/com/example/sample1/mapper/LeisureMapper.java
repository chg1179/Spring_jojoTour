package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Leisure;

@Mapper
public interface LeisureMapper {
	List<Leisure> selectLeisureList(HashMap<String, Object> map);
}
