# JOJOTOUR

여행 시 필요한 다양한 예약 상품을 판매하는 웹 사이트



# 프로젝트 개요

코로나 규정이 완화됨에 따라 여가활동에 대한 관심이 급증하면서, 관광과 여행에 대한 관심이 큰 폭으로 상승하고 있다.
전문 연구기관인 컨슈머인사이트에서 조사한 여가활동 관심도 변화에 따르면 관광에 대한 관심도가 61%로 가장 높은 지표를 보였으며, 국내 여행이 관심 여가 활동 1위를 차지한 것을 확인할 수 있다.
여행객들이 많아지면서 숙박업소나 관광지 여행에 대한 관심이 높아지고 있기 때문에, 여행 사이트를 주제로 프로젝트를 선택했다.



# 프로젝트 목표

 - 기존 사이트의 단점을 보완하고 차별성을 가지기 위한 사이트 제작을 기획.
 - 장바구니 기능을 추가하여 숙박, 레저, 렌트 제품을 하나의 장바구니에 넣어 한 번에 결제할 수 있음.
 - 자유롭게 소통하고 정보를 공유할 수 있는 커뮤니티 기능을 추가하여 사이트의 이용률을 높임.



# 팀원 소개

| **팀원** | **역할** |
|---------------|---------------|
| 조예림(조장) | DB 설계. 프로젝트 및 깃허브 세팅. 호스트 상품 관리. 결제 및 주문. 코드 및 오류 관리. |
| 김성호 | 관리자 페이지. 유저 및 호스트 관리.패키지 상품. 장바구니 기능. |
| 이상엽 | 게시판 및 커뮤니티 기능. 제품 상세 페이지. DB 데이터 수집. |
| 이승현 | 메인 페이지. 회원가입. 마이페이지. 상품 페이지. 사이트의 전체적 스타일 수정. |
| 조혜지 | 호스트 상품 관리. 숙소 상품 판매 페이지 |



# 프로젝트 일정

2023.08.04 ~ 2023.08.28

 - 매주 월요일과 목요일 10시 20분, 모든 팀원이 모여 회의 진행. 각자의 진행률 보고 및 피드백 시간을 가짐.
   
 - 2023.08.04 ~ 2023.08.08 : 자료 조사. 사이트 구상
 - 2023.08.09 ~ 2023.08.16 : DB 구축. 스토리보드 작성. 기능 구현
 - 2023.08.17 ~ 2023.08.23 : 중간 점검. 기능 구현 및 보완.
 - 2023.08.24 ~ 2023.08.29 : 테스트 시나리오 작성. 기능 점검 및 오류 수정. PPT 제작.



# 개발 환경

- 운영 체제 (OS): Windows 10 Pro (64-bit)
- 프로세서: Intel Core i5-9400F @ 2.90GHz
- JDK: JDK 17
- IDE: Spring Tools 4 for Eclipse
- 데이터베이스 관리 도구: HeidiSQL
- 개발 언어: JAVA, HTML, CSS, Javascript
- 프론트엔드 프레임워크: jQuery, vue.js
- 백엔드 프레임워크: Spring Boot
- ORM 프레임워크: MyBatis
- 데이터베이스: MySQL
- 형상 관리: Git



# 프로젝트 설계

1. 일반 사용자 
  - 숙소, 렌터카, 레저 상품을 장바구니에 넣고, 원하는 제품을 선택하여 한 번에 구매할 수 있음.
  - 원하는 제품을 찜하여 모아볼 수 있음.
  - 회원가입시 포인트 테이블에 포인트 추가.
  - 게시글에 좋아요를 누르거나 악성 회원의 댓글을 신고. 
2. 호스트 
  - 숙박, 렌터카, 레저 CRUD 기능.
  - 숙박업소 별로 숙소(방) 등록.
  - 호스트가 패키지로 묶고 싶은 상품을 패키지 요청한 뒤, 관리자가 승인하여 패키지로 묶어서 판매.
3. 게시판
  - 관리자는 모든 게시판을 관리.
  - 일반 회원이 문의글을 작성하면, 관리자는 등록한 문의 글에 대해 답변을 작성할 수 있음.
  - 5회 이상 신고 받은 게시글은 감춰짐.



# 프로젝트 기능 구현

- 세션을 이용한 로그인 서비스 구현.
- 상품 CRUD.
- 사용자가 입력한 값과 선택된 조건이 모두 일치하는 결과값 도출.
- 선택한 체크박스의 값을 JSON 형태로 이용.
- 반복문을 사용하여 사용자가 선택한 체크박스의 값을 삽입 및 출력.
- 테이블을 조인하여 상품 테이블 컬럼에 없는 찜 여부와 게시글 테이블에 없는 댓글 수를 출력.
- 리스트 출력 시 페이징 기능 사용.
- 첨부파일 업로드 및 다운로드. 파일 수정 시 테이블에서 이미지 경로 수정.
- 장바구니에서 선택한 상품의 목록을 JSON 형태로 변환하고, RESTful API를 통해 서버로 전송하여 상품의 목록을 결제페이지로 리턴.
- 주소 API, 결제 API 사용.



# 화면 구현

1. 홈페이지: 사용자가 사이트에 처음 접속했을 때 보이는 페이지. 간결하고 직관적인 디자인을 통해 정보를 제공.
2. 상품 페이지: 카테고리 별로 상품을 출력. 사용자가 입력하거나 선택한 조건에 모두 만족하는 상품 리스트를 출력.
3. 장바구니: 결제할 상품을 선택하여 금액을 확인. 선택한 리스트를 결제 페이지로 넘겨준 뒤, 결제 API를 이용해 상품을 결제.
4. 마이페이지: 주문 내역, 좋아요 목록, 사용자 정보 수정, 문의글 확인.
5. 게시판: 공지사항, 문의 게시판을 이용해 다양한 정보 제공. 자유 게시판과 댓글 기능을 이용해 사용자들끼리 소통.
6. 호스트 페이지: 등록된 상품에 대한 예약 내역 관리. 원하는 상품을 등록하고 관리.
7. 관리자 페이지: 모든 사용자의 정보 관리. 패키지 상품 관리.



# 기대효과

- 숙박, 렌터카, 레저 상품을 한 번에 결제할 수 있다는 큰 장점을 갖고 있어, 앞으로 더 많은 사용자들이 해당 사이트를 찾을 것임.
- 세 개의 카테고리 상품 외에도 더 다채로운 상품을 제공할 수 있기 때문에, 사이트의 발전 가능성이 높음.
- 커뮤니티에서 회원들끼리 자유롭게 글을 작성하고 정보를 공유할 수 있기 때문에, 비수기에도 사이트 이용률이 높을 것임.
- 여행에 대한 관심도가 증가함에 따라, 더 많은 사용자들이 저희가 제작한 사이트를 이용할 것으로 기대됨.



# 자체 평가

본 프로젝트는 클라우드 DB와 AWS의 RDS를 활용하여 데이터베이스를 연결하는 작업을 수행하여 테스트를 완료했다.
현재, 관리자 페이지에서 패키지 상품을 관리하는 기능을 개발했지만, 시간 부족으로 패키지 상품을 출력하는 기능을 완성하지 못했다.
해당 부분은 프로젝트 이후 개선할 계획이며, 다양한 환경에서 오류가 발생하는지 확인할 것이다.




[발표용PPT](https://github.com/lim997/jojoTour/blob/main/%EC%A1%B0%EC%A1%B0%ED%88%AC%EC%96%B4_ppt.pdf)
