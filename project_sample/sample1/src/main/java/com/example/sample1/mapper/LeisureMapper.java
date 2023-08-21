package com.example.sample1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.sample1.model.Leisure;
import com.example.sample1.model.LeisureImg;


@Mapper
public interface LeisureMapper {
	//레저 정보 리스트 출력
	List<Leisure> selectLeisureList(HashMap<String, Object> map);
	
	// 전체 갯수
	int selectCnt(HashMap<String, Object> map);
	
	//레저 상세 정보 출력
	Leisure selectLeisureInfo(HashMap<String, Object> map);
	
	//레저 삭제
	int deleteLeisure(HashMap<String, Object> map);
	
	//레저 삭제
	int deleteLeisureImg(HashMap<String, Object> map);
	
	//레저 패키지 신청
	int insertLeisurePack(HashMap<String, Object> map);
	
	//레저 패키지 신청 취소
	int deleteLeisurePack(HashMap<String, Object> map);
	
	//레저 추가
	int insertLeisure(HashMap<String, Object> map);
	
	//레저 정보 수정
	int updateLeisure(HashMap<String, Object> map);
	
	//레저 이미지 추가
	int insertLeisureImg(HashMap<String, Object> map);
	
	//레저 이미지 수정
	int updateLeisureImg(HashMap<String, Object> map);
	
	//레저 이미지 리스트
	List<LeisureImg> selectLeisureImgList(HashMap<String, Object> map);
}
