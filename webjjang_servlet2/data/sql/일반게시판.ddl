
DROP SEQUENCE board_reply_seq;



CREATE SEQUENCE board_reply_seq;



DROP SEQUENCE board_seq;



CREATE SEQUENCE board_seq;



DROP SEQUENCE message_seq;



CREATE SEQUENCE message_seq;



DROP SEQUENCE qna_seq;



CREATE SEQUENCE qna_seq;



DROP TABLE qna CASCADE CONSTRAINTS;



DROP TABLE Board_Reply CASCADE CONSTRAINTS;



DROP TABLE Board CASCADE CONSTRAINTS;



DROP TABLE message CASCADE CONSTRAINTS;



DROP TABLE member CASCADE CONSTRAINTS;



DROP TABLE grade CASCADE CONSTRAINTS;



CREATE TABLE grade
(
	gradeNo               NUMBER(2)  NOT NULL ,
	gradeName             VARCHAR2(21)  NOT NULL ,
CONSTRAINT  XPKȸ����� PRIMARY KEY (gradeNo)
);



CREATE TABLE member
(
	id                    VARCHAR2(20)  NOT NULL ,
	pw                    VARCHAR2(20)  NOT NULL ,
	name                  VARCHAR2(30)  NOT NULL ,
	gender                VARCHAR2(6)  NOT NULL  CONSTRAINT  member_gender_ck CHECK (gender in('����','����')),
	birth                 DATE  NOT NULL ,
	tel                   VARCHAR2(13)  NULL ,
	email                 VARCHAR2(50)  NOT NULL ,
	regDate               DATE   DEFAULT  sysdate NULL ,
	conDate               DATE   DEFAULT  sysdate NULL ,
	status                VARCHAR2(6)   DEFAULT  '����' NULL  CONSTRAINT  member_status_ck CHECK (status in('����','����','Ż��','�޸�')),
	photo                 VARCHAR2(200)  NULL ,
	newMsgCnt             NUMBER   DEFAULT  0 NULL ,
	gradeNo               NUMBER(2)   DEFAULT  1 NULL ,
CONSTRAINT  XPKȸ�� PRIMARY KEY (id),
CONSTRAINT  R_3 FOREIGN KEY (gradeNo) REFERENCES grade(gradeNo) ON DELETE SET NULL
);



CREATE TABLE message
(
	no                    NUMBER  NOT NULL ,
	acceptDate            DATE  NULL ,
	content               VARCHAR2(1000)  NOT NULL ,
	sendDate              DATE   DEFAULT  sysdate NULL ,
	accepterId            VARCHAR2(20)  NOT NULL ,
	senderId              VARCHAR2(20)  NOT NULL ,
CONSTRAINT  XPK�޽��� PRIMARY KEY (no),
CONSTRAINT  R_7 FOREIGN KEY (accepterId) REFERENCES member(id) ON DELETE SET NULL,
CONSTRAINT  R_8 FOREIGN KEY (senderId) REFERENCES member(id) ON DELETE SET NULL
);



CREATE TABLE Board
(
	no                    NUMBER  NOT NULL ,
	title                 VARCHAR2(300)  NOT NULL ,
	content               VARCHAR2(2000)  NOT NULL ,
	writer                VARCHAR2(30)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	pw                    VARCHAR2(20)  NOT NULL ,
	hit                   NUMBER   DEFAULT  0 NULL ,
CONSTRAINT  XPK�ϹݰԽ��� PRIMARY KEY (no)
);



CREATE TABLE Board_Reply
(
	rno                   NUMBER  NOT NULL ,
	no                    NUMBER  NOT NULL ,
	content               VARCHAR2(1500)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	pw                    VARCHAR2(20)  NOT NULL ,
	writer                VARCHAR2(30)  NOT NULL ,
CONSTRAINT  XPK�ϹݰԽ���_��� PRIMARY KEY (rno),
CONSTRAINT  R_1 FOREIGN KEY (no) REFERENCES Board(no) ON DELETE CASCADE
);



CREATE TABLE qna
(
	no                    NUMBER  NOT NULL ,
	parentNo              NUMBER  NULL ,
	refNo                 NUMBER  NULL ,
	id                    VARCHAR2(20)  NULL ,
	title                 VARCHAR2(100)  NOT NULL ,
	content               VARCHAR2(1000)  NOT NULL ,
	writeDate             DATE   DEFAULT  sysdate NULL ,
	ordNo                 NUMBER  NULL ,
	levNo                 NUMBER  NULL ,
CONSTRAINT  XPK�����亯 PRIMARY KEY (no),
CONSTRAINT  R_27 FOREIGN KEY (refNo) REFERENCES qna(no) ON DELETE SET NULL,
CONSTRAINT  R_28 FOREIGN KEY (parentNo) REFERENCES qna(no) ON DELETE cascade,
CONSTRAINT  R_29 FOREIGN KEY (id) REFERENCES member(id) ON DELETE SET NULL
);


