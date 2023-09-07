show tables;

create table product2(
	idx             int not null auto_increment,   /* 상품 고유번호 */
	part            char(20) not null,             /* 상품 분류 : 신선식품, 가공식품, 주방용품 */     
	productName     varchar(100) not null,         /* 상품명 */
	price           varchar(20) not null,          /* 상품 가격 */
	discount        varchar(20) default 0,         /* 상품 할인가 */
	discountRate    varchar(20) default 0,         /* 상품 할인률 */
	thumbnail        varchar(100) not null,        /* 상품 대표사진 */
	content         text not null,                 /* 상세설명 */
	ingredient      varchar(200) not null,         /* 상품 재료 */
	openSw          char(2) default 'OK',          /* 상품 공개여부 */
	PRIMARY KEY(idx)
);

desc product2;
drop table product2;

create table option2(
	idx int not null auto_increment,    /* 상품 옵션 고유번호 */
	productIdx int not null,            /* product2 테이블(상품)의 고유번호 - 외래키 지정 */
	optionName varchar(50) not null,    /* 옵션명 */
	optionPrice int not null default 0, /* 옵션 가격 */
	stock int not null, 								/* 상품 옵션 수량 */
	primary key(idx),
	foreign key(productIdx) references product2(idx) on update cascade on delete restrict
);

desc option2;

/* ================ 상품 주문 시작시에 사용하는 테이블들~ ==================== */

/* 장바구니 테이블 */
create table itemCart2 (
  idx   int not null auto_increment,			/* 장바구니 고유번호 */
  cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,							/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
  productName varchar(50) not null,				/* 장바구니에 담은 구입한 상품명 */
  price   int not null,								/* 메인상품의 기본 가격 */
  thumbnail		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionIdx	  varchar(50)	 not null,			/* 옵션의 고유번호리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx,mid),
  /* unique key(mid), */
  foreign key(productIdx) references product2(idx) on update cascade on delete restrict
  /* foreign key(mid) references member2(mid) on update cascade on delete cascade */
);
drop table itemCart2;
desc itemCart2;
delete from itemCart2;
select * from itemCart2;


/* 주문 테이블 */
create table itemOrder2 (
  idx         int not null auto_increment,	/* 고유번호 */
  orderNum    varchar(15) not null,   	   	/* 주문 고유번호(새롭게 만들어 주어야 한다.) */		
  mid         varchar(20) not null,   			/* 주문자 ID */
  productIdx  int not null,           			/* 상품 고유번호 */
  orderDate   datetime default now(), 			/* 실제 주문을 한 날짜 */
  productName varchar(50) not null,   			/* 상품명 */
  price       int not null,				    			/* 메인 상품 가격 */
  thumbnail   varchar(100) not null,  		  /* 썸네일(서버에 저장된 메인상품 이미지) */
  optionName  varchar(100) not null,  			/* 옵션명    리스트 -배열로 넘어온다- */
  optionPrice varchar(100) not null,    		/* 옵션가격  리스트 -배열로 넘어온다- */
  optionNum   varchar(50)  not null,  			/* 옵션수량  리스트 -배열로 넘어온다- */
  totalPrice  int not null,					  			/* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
  /* cartIdx     int not null,	*/					/* 카트(장바구니)의 고유번호 */ 
  primary key(idx, orderNum),
  foreign key(mid) references member2(mid),
  foreign key(productIdx) references product2(idx) on update cascade on delete cascade
);
drop table itemOrder2;
drop table;
desc itemOrder2;
delete from itemOrder2;
select * from itemOrder2;

/* 배송테이블 */
create table itemDelivery2(
  idx     		int not null auto_increment,
  orderIdx    int not null,						/* 주문테이블의 고유번호를 외래키로 지정함 */
  orderNum    varchar(15) not null,   /* 주문 고유번호 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(20) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(100),						/* 받는사람 전화번호 */
  thumbImg		varchar(100),
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결제도구 */
  payMethod   varchar(50)  not null,  /* 결제도구에 따른 방법(카드번호) */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료 -> 배송중 -> 배송완료 -> 구매완료) */
  primary key(idx),
  foreign key(orderIdx) references itemOrder2(idx) on update cascade on delete cascade
);
desc itemDelivery2;
drop table itemDelivery2;
delete from itemDelivery2;
select * from itemDelivery2;


/* 메인 이미지 관리 */
create table mainImage(
  idx         int not null auto_increment primary key,	/* 메인 이미지 고유번호 */
  productCode varchar(20) not null,											/* 어느 품목에 사용될 메인이미지인지 상품의 고유코드를 저장 */
  mainFName   varchar(200) not null,										/* 서버에 저장될 메인 이미지명 */
  unique key(productCode),
  foreign key(productCode) references dbProduct(productCode)
);

desc mainImage;
drop table mainImage;

DROP DATABASE javaweb10;

create DATABASE javaweb10;
