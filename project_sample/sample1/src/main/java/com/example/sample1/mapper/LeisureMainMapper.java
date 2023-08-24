package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Leisure;
import com.example.sample1.model.RentCar;

@Mapper
public interface LeisureMainMapper {
	//수상 레저 메인 리스트
	List<Leisure> selectWaterLeisureList(HashMap<String, Object> map);
	int selectWaterLeisureCnt(HashMap<String, Object> map);
	//수상 레저 종류별 리스트
	List<Leisure> selectWaterLeisureKind(HashMap<String, Object> map);
	int selectWaterLeisureKindCnt(HashMap<String, Object> map);
	//수상 레저 검색
	List<Leisure> selectWaterSearchList(HashMap<String, Object> map);
	int selectWaterLeisureSearchCnt(HashMap<String, Object> map);
	
	//지상 레저 메인 리스트
	List<Leisure> selectGroundLeisureList(HashMap<String, Object> map);
	int selectGroundLeisureCnt(HashMap<String, Object> map);
	//지상 레저 종류별 리스트
	List<Leisure> selectGroundLeisureKind(HashMap<String, Object> map);
	int selectGroundLeisureKindCnt(HashMap<String, Object> map);
	//지상 레저 검색
	List<Leisure> selectGroundSearchList(HashMap<String, Object> map);
	int selectGroundLeisureSearchCnt(HashMap<String, Object> map);
	
	int lReadPlus(HashMap<String, Object> map);
	

	//수상 지상 레저 상세정보
	Leisure selectLeisureInfo(HashMap<String, Object> map);
	

	
}