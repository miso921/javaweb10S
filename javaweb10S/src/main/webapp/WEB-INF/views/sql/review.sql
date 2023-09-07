/* guest2.sql */
show tables;

CREATE TABLE review2 (
  idx         int not null auto_increment PRIMARY KEY,  /* 후기글 고유번호 */
  productIdx  int not null,															/* 상품 연결 외래키 */
  mid         varchar(20) not null,            					/* 후기 작성자 아이디 */
  content     text not null,                   					/* 방명록 내용 */
  star        char(8) not null,                					/* 후기 별점 */
  reviewDate  datetime default now(),	         					/* 후기 작성일자 */
  FOREIGN KEY (productIdx) references product2(idx)
);


desc review2;

select * from review2;
