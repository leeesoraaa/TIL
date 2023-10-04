-- 회원정보를 저장할 테이블 생성
drop table member;
create table member(
   userid varchar2(10) primary key,
   userpass varchar2(20) not null,
   username varchar2(20) not null
);
-- DDL은 자동 commit이 수행된다.

-- 레코드 삽입
insert into member values('admin', 'admin', '관리자');
insert into member values('aaa', '1234', '이소라');
commit;
selct * from member;

