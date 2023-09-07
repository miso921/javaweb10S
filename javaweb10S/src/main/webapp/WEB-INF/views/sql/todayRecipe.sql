show tables;

create table todayRecipe2 (
	idx       int not null auto_increment,       /* 오늘의레시피 고유번호 */
	title     varchar(100) not null,             /* 레터 제목 */
	article   varchar(200) not null,             /* 레터 기사 */
	issueDate datetime DEFAULT CURRENT_TIMESTAMP,/* 레터 작성일 */
	openSw    char(2) default "OK",              /* 공개유무 */
	readNum   int default 0,                     /* 조회수 */
	primary key(idx),
	foreign key(recipeIdx) references recipe2(idx)
);

SELECT * FROM todayRecipe2 ORDER BY idx DESC LIMIT 0, 5;


create table todayRecipe2 (
	idx       int not null auto_increment,  /* 오늘의레시피 고유번호 */
	title     varchar(100) not null,        /* 레터 제목 */
	article   text not null,                /* 레터 기사 */
	issueDate date not null,                /* 레터 작성일 */
	primary key(idx)
);

desc todayRecipe2;
drop table todayRecipe2;

SELECT *,IF(TIMESTAMPDIFF(HOUR, issueDate, NOW())) AS hour_diff FROM todayRecipe2 ORDER BY idx DESC LIMIT #{startIndexNo}, #{pageSize};