show tables;

create table recipe2 (
	idx      int not null auto_increment,  /* 레시피 고유번호 */
	part     varchar(10) not null,         /* 분류 */
	foodName varchar(100) not null,        /* 요리명 */
	file     varchar(100) not null,        /* 대표사진 */
	star     char(8) not null,             /* 난이도 */
	cookTime varchar(50) not null, 	       /* 조리시간 */
	openSw   char(6) default 'OK',         /* 공개여부 */
	item     varchar(200),                 /* 관련상품 */
	primary key(idx)
);

desc recipe2;

drop table recipe2;

select * from recipe2 where file like '%20236120165349_가지무침.jpg%' limit 1;
