package com.example.sample1.model;

import lombok.Data;

@Data
public class Free {
	private int freeNo;
	private String freeTitle;
	private String freeContent;
	private String uId;
	private int fHits; // 게시글 조회수
	private String fWriteTime;
	private String fUpdateTime;
	private String delyn;
	private int notifyCnt; // 신고횟수
	private int commCnt; // 댓글갯수
	private int recommend; // 추천수
	
	private int cNo; //댓글번호
	private String comm; // 댓글내용
	private String cWriteTime;
	private String cUpdateTime;
}
