show tables;

create table mainSetting2 (
	idx 		 	 int not null auto_increment,  /* 캐러셀 고유번호 */
	slideName	 varchar(10) not null,         /* 슬라이드 이름 */
	todayRecipeIdx int not null,             /* 오늘의 레시피 고유번호 */
	slideImg 	 varchar(200),               	 /* 슬라이드 이미지 */
	PRIMARY KEY (idx)   
);

desc mainSetting2;