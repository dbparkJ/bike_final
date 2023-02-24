# Project_Bikeway_ver 2.0
#### 프로젝트기간 : 2023.01.31 ~ 2023.02.23
---
#### 팀원 및 업무분담
* 박종민(리더) : 프로젝트 매니지먼트, ajax와 카카오맵 API를 활용한 동적 지도 시각화, 따릉이 대여소 시계열 분석
* 이예지(팀원) : 식당, 아이템 추천알고리즘 제작, SNS키워드 기반 사용자 동향분석, 데이터 크롤링
* 김유진(팀원) : 공공데이터 포털의 초단기날씨예보 openAPI를 활용한 데이터 수집 Scheduler 생성, 데이터 크롤링
---
### 프로젝트 목적
1. 팀원간의 커뮤니케이션 능력 향상
2. 에자일(Ajile) 프로젝트 관리 기법을 활용
3. Java, Python언어의 다양한 툴 활용
4. 데이터 분석 및 웹페이지 제작 업무 취업 스펙 확보
### 프로젝트 진행방식
1. OpenApi, Web Scraping, Scheduler 활용한 데이터 및 실시간 데이터 수집
2. 수집된 데이터를 ETL 도구를 사용하여 데이터 가공
3. Chart.js, 다음지도 API등을 활용한 빅데이터 시각화
4. JavaScript.Ajax통신을 활용하여 정적인 페이지 -> 동적인 페이지 제작
5. Oracle Cloud DBMS를 사용하여 데이터 보관 및 사용
6. NeuralProphet, Multivariate 모델을 활용하여 따릉이 대여건수 시계열 예측
---
### 프로젝트 모델링 - 텍스트 시각화
![image](https://user-images.githubusercontent.com/113589300/221070516-1b1c6567-d644-42a9-b0b9-db89b439615c.png)
1. SNS 키워드 단어 빈도 기반 라이딩 유저 데이터 수집
  - 선정 데이터셋 
    - 네이버 뉴스 : 1~50Page Crawlling
    - 네이버 블로그 : 약 500개의 블로그 Crawlling
2. 데이터 빈도를 바탕으로 텍스트 시각화
3. 데이터 기반의 분석결과 코스, 날씨, 제품, 사진 등 워드의 빈도가 높음을 확인  
---
### 프로젝트 모델링 - 페르소나 분석
#### 1. 주말엔 라이딩
##### 프로필
(1) 나이 : 40대
(2) 직업 : 회사 부장급
(3) SNS활용도 : 한달에 한번
(4) 자전거 관심도 : 상
##### 특이사항
(1) 주말에 거의 거의 대부분 자전거 타는 것에 매진
(2) 날씨를 확인하지 않고 라이딩을 하다가 비를 맞아 고생한 기억이 있음
(3) 한번은 자전거 부품이 고장 나 고생했던 기억도 있음
(4) 자전거 라이딩은 좋아하나 다양한 정보를 얻는 것에 피로감을 느낌
##### 타깃확보 방법
코스와 맛집 날씨를 보여줄 수 있는 All in One 페이지를 제작해 유저 확보
---
#### 2. 확찐자
##### 프로필
(1) 나이 : 20대~30대
(2) 직업 : 대리급 직원
(3) SNS활용도 : 주 3~4회
(4) 자전거 관심도 : 하
##### 특이사항
(1) 코로나 19이후 집 회사를 반복해 보통 체형에서 살이 급격히 찜
(2) 운동에는 관심이 없고 시간도 투자하기 싫어함
(3) 보유 차량이 없어 이동 수단은 대중교통을 이용, 서울거주
##### 타깃확보 방법
따릉이 공유자전거로 출퇴근길에 자전거를 이용해 자연스럽게 운동을 유도하여 유저의 유입을 기대
따릉이 대여소의 시계열 예측을 통하여 특정시간 어느날 대여소가 붐비는 데이터 제공

---
#### 3. 오운완
##### 프로필
(1) 나이 : 20대 중 후반
(2) 직업 : 회사 초년생
(3) SNS활용도 : 매일
(4) 자전거 관심도 : 중
##### 특이사항
(1) 최근 헬스장에 지루함을 느껴 다른 운동을 찾는중임
(2) SNS에 예쁜 사진을 올리는 것이 삶의 낙이여서 돈쓰는것을 가끼지 않음
##### 타깃확보 방법
신규 자전거를 구매하여 유입할 수 있도록 자전거 추천 페이지 제작하여 유입기대
다양한 자전거코스와 코스 근처의 맛집, 장소등을 추천
---
