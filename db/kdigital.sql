-- ���̺� ��� Ȯ��
select * from tab;

-- ���̺� ����
drop table product cascade constraint;

-- ���̺� ����
create table product(
  product_id number primary key,  -- ��ǰ��ȣ ���� �⺻Ű ����
  product_name varchar2(50),  -- ��ǰ��
  price number default 0,  -- ��ǰ���� ���� �ʱⰪ 0
  description clob,   -- ��ǰ����  �乮�ڿ�
  picture_url varchar2(500)  
);

-- ���ڵ� ����
insert into product values(1, '����', 1500, '���ִ� ����', 'lemon.jpg');
insert into product values(2, '������', 1300, '���ִ� ������', 'orange.jpg');
insert into product values(3, 'Ű��', 2000, '���ִ� Ű��', 'kiwi.jpg');
insert into product values(4, '����', 1800, '���ִ� ����', 'grape.jpg');
insert into product values(5, '����', 1300, '���ִ� ����', 'strawberry.jpg');

-- db �ݿ�
commit;
select * from product;

-- product ���� Ȯ��
select count(*) from product;