package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.Leisure;
import com.example.sample1.model.LeisureImg;


public interface LeisureService {
	// 레저 정보 리스트 출력
	HashMap<String, Object> searchLeisureList(HashMap<String, Object> map);
	
	// 레저 상세 정보 출력
	Leisure searchLeisureInfo(HashMap<String, Object> map);
	
	//레저 삭제
	int removeLeisure(HashMap<String, Object> map);
	
	//레저 패키지 신청
	int addLeisurePack(HashMap<String, Object> map);
		
	//레저 패키지 신청 취소
	int removeLeisurePack(HashMap<String, Object> map);
	
	//레저 추가
	HashMap<String, Object> addLeisure(HashMap<String, Object> map);
	
	//레저 정보 수정
	HashMap<String, Object> editLeisure(HashMap<String, Object> map);
	
	//레저 이미지 추가
	int addLeisureImg(HashMap<String, Object> map);
	
	//레저 이미지 수정
	int editLeisureImg(HashMap<String, Object> map);
	
	// 레저 이미지 출력
	List<LeisureImg> searchLeisureImgList(HashMap<String, Object> map);
}
