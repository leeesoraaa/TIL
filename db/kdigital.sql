-- 테이블 목록 확인
select * from tab;

-- 테이블 삭제
drop table product cascade constraint;

-- 테이블 생성
create table product(
  product_id number primary key,  -- 상품번호 숫자 기본키 설정
  product_name varchar2(50),  -- 상품명
  price number default 0,  -- 상품가격 숫자 초기값 0
  description clob,   -- 상품설명  긴문자열
  picture_url varchar2(500)  
);

-- 레코드 삽입
insert into product values(1, '레몬', 1500, '맛있는 레몬', 'lemon.jpg');
insert into product values(2, '오렌지', 1300, '맛있는 오렌지', 'orange.jpg');
insert into product values(3, '키위', 2000, '맛있는 키위', 'kiwi.jpg');
insert into product values(4, '포도', 1800, '맛있는 포도', 'grape.jpg');
insert into product values(5, '딸기', 1300, '맛있는 딸기', 'strawberry.jpg');

-- db 반영
commit;
select * from product;

-- product 갯수 확인
select count(*) from product;