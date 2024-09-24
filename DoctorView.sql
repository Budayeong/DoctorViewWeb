-- == DOCTORVIEW ���� ���� ==
-- ���� ����
-- alter session set "_ORACLE_SCRIPT"=true;
-- create user doctorview identified by 1234;
-- grant connect, resource, unlimited tablespace to doctorview;




-- == ���̺�� ������ ���� ==
drop table emoji;
drop sequence seq_emoji_idx;
drop table store;
drop sequence seq_store_idx;
drop table chat;
drop sequence seq_chat_idx;
drop table appointment;
drop sequence seq_appointment_idx;

drop table likes;
drop sequence seq_likes_idx;
drop table hashtag;
drop sequence seq_hashtag_idx;
drop table comments;
drop sequence seq_comments_idx;
drop table board;
drop sequence seq_board_idx;
drop table dreview;
drop sequence seq_dreview_idx;
drop table hreview;
drop sequence seq_hreview_idx;
drop table hours;
drop sequence seq_hours_idx;
drop table doctor;
drop sequence seq_doctor_idx;
drop table detail;
drop sequence seq_detail_idx;
drop table member;




-- == MEMBER ���̺� ==
-- ȸ�� ���̺� ����
drop table member;
-- ȸ�� ���̺� ����
create table member (
    id varchar2(15) primary key, -- ���̵�
    password varchar2(100) not null, -- ��й�ȣ
    name varchar2(30) not null, -- �̸�
    nickname varchar2(30), -- �г���
    tel varchar2(15), -- ����ó
    address varchar2(100), -- �ּ�
    rrn varchar2(20), -- �ֹε�Ϲ�ȣ
    point number default 0, -- ����Ʈ
    emoji varchar2(10), -- Īȣ
    taxid varchar2(15), -- ����ڹ�ȣ
    department varchar2(30), -- ���� ����
    visitcount number default 0, -- ��ȸ��
    photo varchar2(200), -- ���� ����
    enable number(1) default 1 not null, -- Ȱ��ȭ ����
    auth varchar2(15) not null -- ����
);
-- ���̵����� ����
-- ������ ȸ��
insert into member (id, password, name, enable, auth) values ('admin', '1234', '������', 1, 'ROLE_ADMIN');
-- �Ϲ� ����� ȸ��
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('harim', '1234', '���ϸ�', '�ϸ�', '010-0000-0000', '��⵵ �����ν�', '001104-4000000', '(-.-)', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('dayeong', '1234', '�δٿ�', '�ٿ�', '010-1111-1111', '�����', '021209-4000000', '(>_<)', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('leehr', '1234', '��ȸ��', 'ȸ��', '010-2222-2222', '��⵵ �����ν�', '010102-4000000', '(*_*)', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, enable, auth)
    values ('cat', '1234', '�����', '�߿�', '010-3333-3333', '��⵵ ��õ��', '090403-3000000', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('rabbit', '1234', '�䳢', '����', '010-4444-4444', '�����', '931204-1000000', '��', 1, 'ROLE_USER');
insert into member (id, password, name, nickname, tel, address, rrn, emoji, enable, auth)
    values ('tiger', '1234', 'ȣ����', '����', '010-5555-5555', '��⵵ ������', '990212-2000000', '��', 0, 'ROLE_USER');
-- ���� ȸ��
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital1', '1234', '����1', '����1', '010-6666-6666', '�����', '666-666-6666', '����', 1, 'ROLE_HOSP');
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital2', '1234', '����2', '����2', '010-7777-7777', '��⵵ �����ν�', '777-777-7777', '�Ű�ܰ�', 1, 'ROLE_HOSP');  
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital3', '1234', '����3', '����3', '010-8888-8888', '��⵵ ��õ��', '888-888-8888', '�����ܰ�', 1, 'ROLE_HOSP');
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital4', '1234', '����4', '����4', '010-9999-9999', '��⵵ ������', '999-999-9999', '����ΰ�', 1, 'ROLE_HOSP');
insert into member (id, password, name, nickname, tel, address, taxid, department, enable, auth)
    values ('hospital5', '1234', '����5', '����5', '010-1010-1010', '�����', '6101-010-1010', '�Ǻΰ�', 0, 'ROLE_HOSP');
commit;




-- == DETAIL ���̺� ==
-- ���� ������ ���̺� ����
drop table detail;
-- ���� ������ ���̺� ����
create table detail (
    idx number primary key, -- �Ϸù�ȣ
    introduce varchar2(100), -- �Ұ���
    traffic varchar2(100), -- ������
    parking varchar2(20), -- ���� ���� ����
    pcr varchar2(20), -- PCR �˻� ���� ����
    hospitalize varchar2(20), -- �Կ� ���� ����
    system varchar2(20), -- ������ ����
    hosp_ref varchar2(15) not null -- ����
);
-- ���� ������ ���̺� �ܷ�Ű ����
alter table detail drop constraint const_detail_member;
-- ���� ������ ���̺� �ܷ�Ű ����
alter table detail
    add constraint const_detail_member foreign key(hosp_ref)
    references member(id) on delete cascade;
-- ���� ������ ���̺� ������ ����
drop sequence seq_detail_idx;
-- ���� ������ ���̺� ������ ����
create sequence seq_detail_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���������� ����
insert into detail values (seq_detail_idx.nextval, '����1�� ���Ű� ȯ���մϴ�', '���￪ 1�� �ⱸ���� 100m', '���� ����', '�˻� ����', '�Կ� ����', '������', 'hospital1');
insert into detail values (seq_detail_idx.nextval, '����4�� ���Ű� ȯ���մϴ�', '������ 2�� �ⱸ���� 400m', '���� ����', '�˻� �Ұ�', '�Կ� �Ұ�', '������', 'hospital4');
insert into detail values (seq_detail_idx.nextval, '����5�� ���Ű� ȯ���մϴ�', '���￪ 3�� �ⱸ���� 200m', '���� �Ұ�', '�˻� �Ұ�', '�Կ� �Ұ�', '�񿹾���', 'hospital5');
commit;




-- == DOCTOR ���̺� ==
-- �ǻ� ���̺� ����
drop table doctor;
-- �ǻ� ���̺� ����
create table doctor (
    doc_idx number primary key, -- �Ϸù�ȣ
    name varchar2(30) not null, -- �̸�
    major varchar2(30) not null, -- ����
    career varchar2(30) not null, -- ���
    photo varchar2(200), -- ����
    hours varchar2(50) not null, -- ���� ���� �� �ð�
    hosp_ref varchar2(15) not null -- �Ҽ� ����
);
-- �ǻ� ���̺� �ܷ�Ű ����
alter table doctor drop constraint const_doctor_member;
-- �ǻ� ���̺� �ܷ�Ű ����
alter table doctor
    add constraint const_doctor_member foreign key(hosp_ref)
    references member(id) on delete cascade;
-- �ǻ� ���̺� ������ �輼
drop sequence seq_doctor_idx;
-- �ǻ� ���̺� ������ ����
create sequence seq_doctor_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� �߰�
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�1-1', '����', '3��', '��-�� 09:00-15:00', 'hospital1');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�1-2', '����', '6��', '��-�� 09:00-15:00','hospital1');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�2-1', '�Ű�ܰ�', '1��', 'ȭ-�� 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�2-2', '�Ű�ܰ�', '3��', '��-�� 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�2-3', '�Ű�ܰ�', '4��', '��-�� 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�2-4', '�Ű�ܰ�', '6��', '��-�� 09:00-15:00','hospital2');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�3-1', '�����ܰ�', '1��', '��-�� 09:00-15:00','hospital3');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�4-1', '�Ǻΰ�', '4��', '��-�� 09:00-15:00','hospital4');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�4-2', '�Ǻΰ�', '3��', '��-�� 09:00-15:00','hospital4');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�4-3', '�Ǻΰ�', '3��', '��-�� 09:00-15:00','hospital4');
insert into doctor (doc_idx, name, major, career, hours, hosp_ref) values (seq_doctor_idx.nextval, '�ǻ�5-1', '����ΰ�', '2��', '��-�� 09:00-15:00','hospital5');
commit;




-- == HOURS ���̺� ==
-- ���� �ð� ���̺� ����
drop table hours;
-- ���� �ð� ���̺� ����
create table hours (
    hours_idx number primary key,
    week varchar2(15) not null,
    starttime varchar2(15) not null,
    endtime varchar2(15) not null,
    startbreak varchar2(15),
    endbreak varchar2(15),
    deadline varchar2(15) not null,
    hosp_ref varchar2(15) not null
);
-- ���� �ð� ���̺� �ܷ�Ű ����
alter table hours drop constraint const_hours_member;
-- ���� �ð� ���̺� �ܷ�Ű ����
alter table hours
    add constraint const_hours_member foreign key(hosp_ref)
    references member(id) on delete cascade;
-- ���� �ð� ���̺� ������ ����
drop sequence seq_hours_idx;
-- ���� �ð� ���̺� ������ ����
create sequence seq_hours_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into hours values (seq_hours_idx.nextval, '������', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, 'ȭ����', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '������', '09:00', '12:00', '11:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '�����', '09:00', '17:00', '12:00', '13:00', '13:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '�ݿ���', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '�����', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital1');
insert into hours values (seq_hours_idx.nextval, '������', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, 'ȭ����', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '������', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '�����', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '�ݿ���', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital2');
insert into hours values (seq_hours_idx.nextval, '������', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, 'ȭ����', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '������', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '�ݿ���', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '�����', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '�Ͽ���', '09:00', '18:00', '13:00', '14:00', '17:30', 'hospital3');
insert into hours values (seq_hours_idx.nextval, '������', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, 'ȭ����', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '������', '09:00', '12:00', '11:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '�����', '09:00', '17:00', '12:00', '13:00', '13:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '�ݿ���', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '�����', '09:00', '17:00', '12:00', '13:00', '16:00', 'hospital4');
insert into hours values (seq_hours_idx.nextval, '������', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, 'ȭ����', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '������', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '�����', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
insert into hours values (seq_hours_idx.nextval, '�ݿ���', '08:00', '20:00', '13:00', '14:00', '19:00', 'hospital5');
commit;




-- == HREVIEW ���̺� ==
-- ���� ���� ���̺� ����
drop table hreview;
-- ���� ���� ���̺� ����
create table hreview (
    review_idx number primary key, -- �Ϸù�ȣ
    original_idx number not null, -- ������ �Ϸù�ȣ
    postdate date default sysdate not null, -- �ۼ���
    score number, -- ����
    content varchar2(1000) not null, -- ����
    cost number, -- ���
    treat varchar2(100), -- ġ�� ����
    purpose varchar2(100), -- �湮 ����
    doctor varchar2(30), -- �����
    rewrite varchar2(1) default 'F' not null, -- ���� ����
    writer_ref varchar2(15) not null, -- �ۼ���
    hosp_ref varchar2(15) not null -- �湮 ����
);
-- ���� ���� ���̺� �ܷ�Ű ����
alter table hreview drop constraint const_hreview_member1;
alter table hreview drop constraint const_hreview_member2;
-- ���� ���� ���̺� �ܷ�Ű ����
alter table hreview
    add constraint const_hreview_member1 foreign key(writer_ref)
    references member(id) on delete set null;
alter table hreview
    add constraint const_hreview_member2 foreign key(hosp_ref)
    references member(id) on delete cascade;
-- ���� ���� ���̺� ������ ����
drop sequence seq_hreview_idx;
-- ���� ���� ���̺� ������ ����
create sequence seq_hreview_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 4, '���並 �ۼ��غ��ƿ�', 'harim', 'hospital1');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '���並 �ۼ��غ��ƿ�', 'leehr', 'hospital1');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 4, '���並 �ۼ��غ��ƿ�', 'dayeong', 'hospital1');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 1, '���信 ���� ������ �غ��ƿ�', 'hospital1', 'hospital1');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 2, '���信 ���� ������ �غ��ƿ�', 'hospital1', 'hospital1');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 3, '���信 ���� ������ �غ��ƿ�', 'hospital1', 'hospital1');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 4, '���並 �ۼ��غ��ƿ�', 'harim', 'hospital2');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '���並 �ۼ��غ��ƿ�', 'leehr', 'hospital2');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 3, '���並 �ۼ��غ��ƿ�', 'dayeong', 'hospital2');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 7, '���信 ���� ������ �غ��ƿ�', 'hospital2', 'hospital2');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 8, '���信 ���� ������ �غ��ƿ�', 'hospital2', 'hospital2');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 9, '���信 ���� ������ �غ��ƿ�', 'hospital2', 'hospital2');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '���並 �ۼ��غ��ƿ�', 'harim', 'hospital3');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '���並 �ۼ��غ��ƿ�', 'leehr', 'hospital3');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 3, '���並 �ۼ��غ��ƿ�', 'dayeong', 'hospital3');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 13, '���信 ���� ������ �غ��ƿ�', 'hospital3', 'hospital3');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 14, '���信 ���� ������ �غ��ƿ�', 'hospital3', 'hospital3');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 15, '���信 ���� ������ �غ��ƿ�', 'hospital3', 'hospital3');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '���並 �ۼ��غ��ƿ�', 'harim', 'hospital4');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '���並 �ۼ��غ��ƿ�', 'leehr', 'hospital4');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 5, '���並 �ۼ��غ��ƿ�', 'dayeong', 'hospital4');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 19, '���信 ���� ������ �غ��ƿ�', 'hospital4', 'hospital4');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 20, '���信 ���� ������ �غ��ƿ�', 'hospital4', 'hospital4');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 21, '���信 ���� ������ �غ��ƿ�', 'hospital4', 'hospital4');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '���並 �ۼ��غ��ƿ�', 'harim', 'hospital5');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '���並 �ۼ��غ��ƿ�', 'leehr', 'hospital5');
insert into hreview (review_idx, original_idx, score, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, seq_hreview_idx.nextval, 1, '���並 �ۼ��غ��ƿ�', 'dayeong', 'hospital5');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 25, '���信 ���� ������ �غ��ƿ�', 'hospital5', 'hospital5');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 26, '���信 ���� ������ �غ��ƿ�', 'hospital5', 'hospital5');
insert into hreview (review_idx, original_idx, content, writer_ref, hosp_ref)
    values (seq_hreview_idx.nextval, 27, '���信 ���� ������ �غ��ƿ�', 'hospital5', 'hospital5');
commit;




-- == DREVIEW ���̺� ���� ==
-- �ǻ� ���� ���̺� ����
drop table dreview;
-- �ǻ� ���� ���̺� ����
create table dreview (
    review_idx number primary key,
    original_idx number not null,
    postdate date default sysdate not null,
    score number,
    content varchar2(1000) not null,
    rewrite varchar2(1) default 'F' not null,
    writer_ref varchar2(15) not null,
    doc_ref number not null
);
-- �ǻ� ���� ���̺� �ܷ�Ű ����
alter table dreview drop constraint const_dreview_member;
alter table dreivew drop constraint const_dreview_doctor;
-- �ǻ� ���� ���̺� �ܷ�Ű ����
alter table dreview
    add constraint const_dreview_member foreign key(writer_ref)
    references member(id) on delete set null;
alter table dreview
    add constraint const_dreview_doctor foreign key(doc_ref)
    references doctor(doc_idx) on delete cascade;
-- �ǻ� ���� ���̺� ������ ����
drop sequence seq_dreview_idx;
-- �ǻ� ���� ���̺� ������ ����
create sequence seq_dreview_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into dreview (review_idx, original_idx, score, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, seq_dreview_idx.nextval, 3, '�ǻ翡�� ���並 �ۼ��غ��ƿ�', 'harim', 1);
insert into dreview (review_idx, original_idx, score, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, seq_dreview_idx.nextval, 4, '�ǻ翡�� ���並 �ۼ��غ��ƿ�', 'dayeong', 1);
insert into dreview (review_idx, original_idx, score, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, seq_dreview_idx.nextval, 5, '�ǻ翡�� ���並 �ۼ��غ��ƿ�', 'leehr', 1);
insert into dreview (review_idx, original_idx, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, 1, '���信 ���� �亯�� �غ��ƿ�', 'hospital1', 1);
insert into dreview (review_idx, original_idx, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, 2, '���信 ���� �亯�� �غ��ƿ�', 'hospital1', 1);
insert into dreview (review_idx, original_idx, content, writer_ref, doc_ref)
    values (seq_dreview_idx.nextval, 3, '���信 ���� �亯�� �غ��ƿ�', 'hospital1', 1);
commit;




-- == BOARD ���̺� ==
-- �Խ��� ���̺� ����
drop table board;
-- �Խ��� ���̺� ����
create table board (
    board_idx number primary key, -- �Ϸù�ȣ
    boardname varchar2(15) not null, -- �Խ��� �̸�
    postdate date default sysdate not null, -- �ۼ���
    title varchar2(200) not null, -- ����
    content varchar2(2000) not null, -- ����
    visitcount number default 0 not null, -- ��ȸ��
    reportcount number default 0 not null, -- �Ű��
    writer_ref varchar2(15) -- �ۼ���
);
-- �Խ��� �ܷ�Ű ����
alter table board drop constraint const_board_member;
-- �Խ��� �ܷ�Ű ����
alter table board
    add constraint const_board_member foreign key(writer_ref)
    references member(id) on delete set null;
-- �Խ��� ������ ����
drop sequence seq_board_idx;
-- �Խ��� ������ ����
create sequence seq_board_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '����1', '����1�Դϴ�', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '����2', '����2�Դϴ�', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '����3', '����3�Դϴ�', 'leehr');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '����4', '����1�Դϴ�', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '����5', '����2�Դϴ�', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'freeboard', '����6', '����3�Դϴ�', 'leehr');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '����1', '����1�Դϴ�', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '����2', '����2�Դϴ�', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '����3', '����3�Դϴ�', 'leehr');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '����4', '����1�Դϴ�', 'harim');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '����5', '����2�Դϴ�', 'dayeong');
insert into board (board_idx, boardname, title, content, writer_ref)
    values (seq_board_idx.nextval, 'qnaboard', '����6', '����3�Դϴ�', 'leehr');
commit;
-- Ʈ���� ����
-- create or replace trigger trig_delete_when_reportcount_three
--     after update
--     of reportcount on board
--     for each row
-- begin
    -- reportcount�� 3�� �Ǿ��� ���� ���� ����
--     if :old.reportcount = 3 then
--         delete from board
--         where board_idx = :old.board_idx;
--     end if;
-- end;
-- /






-- == COMMENT ���̺� ==
-- �Խ��� ��� ���̺� ����
drop table comments;
-- �Խ��� ��� ���̺� ����
create table comments (
    comm_idx number primary key, -- �Ϸù�ȣ
    postdate date default sysdate not null, -- �ۼ���
    content varchar2(2000) not null, -- ����
    board_ref number not null, -- �Խù� �Ϸù�ȣ
    writer_ref varchar2(15) -- �ۼ���
);
-- �Խ��� ��� �ܷ�Ű ����
alter table comments drop constraint const_comments_board;
alter table comments drop constraint const_comments_member;
-- �Խ��� ��� �ܷ�Ű ����
alter table comments
    add constraint const_comments_board foreign key(board_ref)
    references board(board_idx) on delete cascade;
alter table comments
    add constraint const_comments_member foreign key(writer_ref)
    references member(id) on delete set null;
-- �Խ��� ��� ������ ����
drop sequence seq_comments_idx;
-- �Խ��� ��� ������ ����
create sequence seq_comments_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 1, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 1, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 1, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 2, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 2, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 2, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 3, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 3, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 3, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 4, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 4, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 4, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 5, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 5, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 5, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 6, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 6, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 6, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 7, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 7, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 7, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 8, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 8, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 8, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 9, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 9, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 9, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 10, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 10, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 10, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 11, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 11, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 11, 'leehr');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���1�Դϴ�', 12, 'harim');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���2�Դϴ�', 12, 'dayeong');
insert into comments (comm_idx, content, board_ref, writer_ref)
    values (seq_comments_idx.nextval, '���3�Դϴ�', 12, 'leehr');
commit;




-- == HASHTAG ���̺� ==
-- �ؽ��±� ��� ���̺� ����
drop table hashtag;
-- �ؽ��±� ��� ���̺� ����
create table hashtag (
    tag_idx number primary key,
    hosp_ref varchar2(15),
    review_ref number,
    tag varchar2(100) not null
);
-- �ؽ��±� ��� �ܷ�Ű ����
alter table hashtag drop constraint const_hashtag_member;
alter table hashtag drop constraint const_hashtag_hreview;
-- �ؽ��±� ��� �ܷ�Ű ����
alter table hashtag
    add constraint const_hashtag_member foreign key(hosp_ref)
    references member(id) on delete cascade;
alter table hashtag
    add constraint const_hashtag_hreview foreign key(review_ref)
    references hreview(review_idx) on delete cascade;
-- �ؽ��±� ��� ������ ����
drop sequence seq_hashtag_idx;
-- �ؽ��±� ��� ������ ����
create sequence seq_hashtag_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
-- ����
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital1', '�±�1');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital1', '�±�2');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital1', '�±�3');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital2', '�±�1');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital3', '�±�2');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital3', '�±�3');
insert into hashtag (tag_idx, hosp_ref, tag)
    values (seq_hashtag_idx.nextval, 'hospital3', '�±�4');
-- ����
insert into hashtag (tag_idx, review_ref, tag)
    values (seq_hashtag_idx.nextval, 1, '�±�1');
insert into hashtag (tag_idx, review_ref, tag)
    values (seq_hashtag_idx.nextval, 1, '�±�2');
insert into hashtag (tag_idx, review_ref, tag)
    values (seq_hashtag_idx.nextval, 1, '�±�3');
commit;




-- == LIKES ���̺� ==
-- ���ƿ� ��� ���̺� ����
drop table likes;
-- ���ƿ� ��� ���̺� ����
create table likes (
    like_idx number primary key,
    member_ref varchar2(15),
    tablename varchar2(15) not null,
    recodenum varchar2(15) not null
);
-- ���ƿ� ��� �ܷ�Ű ����
alter table likes drop constraint const_likes_member;
-- ���ƿ� ��� �ܷ�Ű ����
alter table likes
    add constraint const_likes_member foreign key(member_ref)
    references member(id) on delete set null;
-- ���ƿ� ��� ������ ����
drop sequence seq_likes_idx;
-- ���ƿ� ��� ������ ����
create sequence seq_likes_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
-- �Խ���
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '1');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '1');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'board', '1');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '3');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '5');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '6');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'board', '6');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '7');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '7');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '8');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '10');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '10');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'board', '10');
insert into likes values (seq_likes_idx.nextval, 'harim', 'board', '11');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '11');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'board', '12');
-- ����
insert into likes values (seq_likes_idx.nextval, 'harim', 'member', 'hospital1');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital1');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'member', 'hospital1');
insert into likes values (seq_likes_idx.nextval, 'harim', 'member', 'hospital2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital3');
insert into likes values (seq_likes_idx.nextval, 'harim', 'member', 'hospital4');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'member', 'hospital5');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'member', 'hospital5');
-- �ǻ�
insert into likes values (seq_likes_idx.nextval, 'harim', 'doctor', '1');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '1');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'doctor', '1');
insert into likes values (seq_likes_idx.nextval, 'harim', 'doctor', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '2');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '3');
insert into likes values (seq_likes_idx.nextval, 'harim', 'doctor', '4');
insert into likes values (seq_likes_idx.nextval, 'dayeong', 'doctor', '5');
insert into likes values (seq_likes_idx.nextval, 'leehr', 'doctor', '5');
commit;




-- == REPORT ���̺� ==
-- �Ű� ��� ���̺� ����
drop table report;
-- �Ű� ��� ���̺� ����
create table report (
    report_idx number primary key,
    member_ref varchar2(15),
    board_ref number not null
);
-- �Ű� ��� �ܷ�Ű ����
alter table report drop constraint const_report_member;
alter table report drop constraint const_report_board;
-- �Ű� ��� �ܷ�Ű ����
alter table report
    add constraint const_report_member foreign key(member_ref)
    references member(id) on delete set null;
alter table report
    add constraint const_report_board foreign key(board_ref)
    references board(board_idx) on delete cascade;
-- �Ű� ��� ������ ����
drop sequence seq_report_idx;
-- ���ƿ� ��� ������ ����
create sequence seq_report_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into report values (seq_report_idx.nextval, 'harim', 1);
insert into report values (seq_report_idx.nextval, 'dayeong', 1);
insert into report values (seq_report_idx.nextval, 'leehr', 1);
commit;





-- == APPOINTMENT ���̺� ==
-- ���� ���̺� ����
drop table appointment;
-- ���� ���̺� ����
create table appointment (
    app_id number primary key, -- �Ϸù�ȣ
    hospname varchar2(30) not null, -- ���� �̸�
    doctorname varchar2(30), -- �ǻ� �̸�
    username varchar2(30) not null, -- ������ �̸�
    tel varchar2(30) not null, -- ������ ����ó
    rrn varchar2(30) not null, -- ������ �ֹε�Ϲ�ȣ
    address varchar2(100) not null, -- ������ �ּ�
    postdate date not null, -- ������
    posttime varchar2(30) not null, -- ���� �ð�
    alarm varchar2(1) default 'T' not null, -- �˸� ����
    review varchar2(1) default 'F' not null, -- ���� ��� ����
    hide varchar2(1) default 'F' not null, -- ����� ����
    user_ref varchar2(15), -- �����
    hosp_ref varchar2(15) -- ����
);
-- ���� ���̺� �ܷ�Ű ����
alter table appointment drop constraint const_appointment_member1;
alter table appointment drop constraint const_appointment_member2;
-- ���� ���̺� �ܷ�Ű ����
alter table appointment
    add constraint const_appointment_member1 foreign key(user_ref)
    references member(id) on delete set null;
alter table appointment
    add constraint const_appointment_member2 foreign key(hosp_ref)
    references member(id) on delete set null;
-- ���� ���̺� ������ ����
drop sequence seq_appointment_idx;
-- ���� ���̺� ������ ����
create sequence seq_appointment_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
commit;




-- == CHAT ���̺� ==
-- ä�� ���̺� ����
drop table chat;
-- ä�� ���̺� ����
create table chat (
    chat_idx number primary key,
    member_ref varchar2(15) not null,
    roomid number not null,
    message varchar2(1000) not null,
    postdate date default sysdate not null
);
-- ä�� ���̺� �ܷ�Ű ����
alter table chat drop constraint const_chat_member;
-- ä�� ���̺� �ܷ�Ű ����
alter table chat
    add constraint const_chat_member foreign key(member_ref)
    references member(id) on delete cascade;
-- ä�� ���̺� ������ ����
drop sequence seq_chat_idx;
-- ä�� ���̺� ������ ����
create sequence seq_chat_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
commit;




-- == STORE ���̺� ==
-- ���� ���̺� ����
drop table store;
-- ���� ���̺� ����
create table store (
    store_idx number primary key,
    price number not null,
    emoji varchar2(10) not null,
    title varchar2(100) not null
);
-- ���� ������ ����
drop sequence seq_store_idx;
-- ���� ������ ����
create sequence seq_store_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into store values (seq_store_idx.nextval, 100, '(*_*)', '���� ���̿���');
insert into store values (seq_store_idx.nextval, 90, '(@_@)', '����������');
insert into store values (seq_store_idx.nextval, 110, '(^_^)', '�ູ�ؿ�');
insert into store values (seq_store_idx.nextval, 120, '(>_<)', '�����ؿ�');
insert into store values (seq_store_idx.nextval, 130, '(+_+)', '�����߾��');
insert into store values (seq_store_idx.nextval, 130, '(-.-)', '������');
commit;




-- == EMOJI ���̺� ==
-- �̸��� ���̺� ����
drop table emoji;
-- �̸��� ���̺� ����
create table emoji (
    emoji_idx number primary key,
    user_ref varchar2(15) not null,
    emoji varchar2(10) not null
);
-- �̸��� �ܷ�Ű ����
alter table emoji drop constraint const_emoji_member;
-- �̸��� �ܷ�Ű ����
alter table emoji
    add constraint const_emoji_member foreign key(user_ref)
    references member(id) on delete cascade;
-- �̸��� ������ ����
drop sequence seq_emoji_idx;
-- �̸��� ������ ����
create sequence seq_emoji_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ���̵����� ����
insert into emoji values (seq_emoji_idx.nextval, 'harim', '(-.-)');
insert into emoji values (seq_emoji_idx.nextval, 'harim', '(@_@)');
insert into emoji values (seq_emoji_idx.nextval, 'harim', '(>_<)');
insert into emoji values (seq_emoji_idx.nextval, 'dayeong', '(>_<)');
insert into emoji values (seq_emoji_idx.nextval, 'dayeong', '(+_+)');
insert into emoji values (seq_emoji_idx.nextval, 'leehr', '(*_*)');
insert into emoji values (seq_emoji_idx.nextval, 'leehr', '(^_^)');
insert into emoji values (seq_emoji_idx.nextval, 'leehr', '(@_@)');
commit;