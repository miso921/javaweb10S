show tables;

CREATE TABLE dibs2 (
  idx 			INT NOT NULL AUTO_INCREMENT, /* 찜하기 고유번호 */
  recipeIdx INT NOT NULL,								 /* 찜한 레시피 연결 외래키 */
  dibsMid   VARCHAR(20) NOT NULL,				 /* 찜한 사용자 아이디 */
  PRIMARY KEY (idx),
 	FOREIGN KEY (recipeIdx) REFERENCES recipe2(idx)
);	

DROP TABLE dibs2;