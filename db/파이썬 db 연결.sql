-- ȸ�������� ������ ���̺� ����
drop table member;
create table member(
   userid varchar2(10) primary key,
   userpass varchar2(20) not null,
   username varchar2(20) not null
);
-- DDL�� �ڵ� commit�� ����ȴ�.

-- ���ڵ� ����
insert into member values('admin', 'admin', '������');
insert into member values('aaa', '1234', '�̼Ҷ�');
commit;
selct * from member;

