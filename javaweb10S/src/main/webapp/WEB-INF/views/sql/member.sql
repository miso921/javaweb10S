show tables;

create table member2(
	idx int not null auto_increment,    /* 회원 고유번호 */
	name varchar(20) not null,          /* 회원 이름 */
	mid varchar(20) not null,           /* 회원 아이디 */
	pwd varchar(100) not null,           /* 회원 비밀번호 */
	email varchar(50) not null,         /* 회원 이메일 */
	address varchar(100),               /* 회원 주소 */
	tel     varchar(15),                /* 회원 연락처 */
	birthday datetime,                  /* 회원 생년월일 */
	gender   varchar(5) default '미선택', /* 회원 성별 */
	userDel  char(2) default 'NO',      /* 탈퇴 신청 유무 */
	level    int default 1,             /* 회원 등급 */
	point    int default 1000,          /* 회원 적립금(하루에 1번 로그인 시 포인트 100증가) */
	todayCnt int default 0,             /* 오늘 방문횟수 */
	startDate	datetime default now(),   /* 가입일 */
	lastDate  datetime default now(),   /* 최초접속일 */
	photo     varchar(100) default 'noimage.jpg' /* 회원사진 */
	
	primary key(idx),
	unique (mid)
);

CREATE TABLE member2 (
    idx int not null auto_increment,
    name varchar(20) not null,
    mid varchar(20) not null,
    pwd varchar(100) not null,
    email varchar(50) not null,
    address varchar(100),
    tel varchar(15),
    birthday datetime,
    gender varchar(5) default '미선택',
    userDel char(2) default 'NO',
    level int default 1,
    point int default 1000,
    todayCnt int default 0,
    startDate datetime default now(),
    lastDate datetime default now(),
    photo varchar(100) default 'noimage.jpg',
    primary key (idx),
    unique key (mid)
);


desc member2;