show tables;

create table todayRecipeSub2 (
	idx  		 int not null auto_increment,  /* 오늘의레시피 구독 고유번호 */
	mail 		 varchar(100) not null,        /* 구독자 이메일 */
	nickName varchar(100) not null,        /* 구독자 닉네임 */
	primary key(idx)
);

desc todayRecipeSub2;
drop table todayRecipeSub2;