package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Stay;
import com.example.sample1.model.StayImg;

@Mapper
public interface StayMapper {
	// 숙소 업체 목록 출력
	List<Stay> selectStayList(HashMap<String, Object> map);
	
	// 전체 갯수
	int selectCnt(HashMap<String, Object> map);
	
	// 숙소 업체 등록
	int insertStay(HashMap<String, Object> map);
	
	// 숙소 타입 리스트
	List<Stay> selectStayTypeList(HashMap<String, Object> map);
	
	// 숙소 업체 삭제
	int deleteStay(HashMap<String, Object> map);
	
	// 숙소 정보
	Stay selectStayInfo(HashMap<String, Object> map);
	
	// 숙소 정보 수정
	int updateStayInfo(HashMap<String, Object> map);
	
	// 숙소 서비스 리스트
	List<Stay> selectServiceList(HashMap<String, Object> map);
	
	// 체크된 룸서비스 값 인서트
	int insertStayService(HashMap<String, Object> map);
	
	// 체크된 룸서비스 없데이트
	int updateStayService(HashMap<String, Object> map);
	
	// 체크된 서비스 리스트
	List<Stay> checkServiceList(HashMap<String, Object> map);
	
	// 서비스 삭제
	int deleteService(HashMap<String, Object> map);
	
	// 수정시 서비스 다시 인서트
	int insertService2(HashMap<String, Object> map);
	
	// 숙소 이미지 인서트
	int insertStayImg(HashMap<String, Object> map);
	
	// 이미지 수정
	int updateStayImg(HashMap<String, Object> map);
	
	// 숙소 이미지 정보
	StayImg selectStayImgInfo(HashMap<String, Object> map);
	
	// 숙소 이미지 삭제
	int deleteStayImg(HashMap<String, Object> map);
} 
