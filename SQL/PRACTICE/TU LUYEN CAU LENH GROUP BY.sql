DROP DATABASE IF EXISTS `GROUP_BY`;
CREATE DATABASE IF NOT EXISTS `GROUP_BY`;
USE `GROUP_BY`;

CREATE TABLE IF NOT EXISTS `Answer`(
	AnswerID 		TINYINT UNSIGNED AUTO_INCREMENT,
	Content 		varchar(1500),
	Questionid 		TINYINT UNSIGNED,
	IsCorrect 		ENUM('1','0') DEFAULT ('0'),
   
	PRIMARY KEY (AnswerID)
);
INSERT INTO Answer ( Content , 		QuestionID , isCorrect )
VALUES 				 ('Trả lời 01' ,	 '1' ,	 '0'),
					 ('Trả lời 02' ,	 '1' ,	 '1'),
					 ('Trả lời 03',	 	 '1' ,	 '0'),
					 ('Trả lời 04', 	 '1' ,	 '1' ),
					 ('Trả lời 05', 	'2' , 	'1' ),
					 ('Trả lời 06', 	'3' , 	'1' ),
					 ('Trả lời 07', 	'2' , 	'0' ),
					 ('Trả lời 08', 	'4' , 	'0' ),
					 ('Trả lời 09', 	'2' ,	 '1' ),
					 ('Trả lời 10', 	'1' , 	'1' );
                     
                     
SELECT QUESTIONID, COUNT(*) AS 'SOCAUTRALOI' 
FROM `ANSWER`
GROUP BY (QUESTIONID) HAVING COUNT(QUESTIONID)>'4';                     
                     

SELECT * FROM ANSWER;

SELECT QuestionID, COUNT(*) FROM ANSWER
 GROUP BY (QuestionID);
 
 
 
 SELECT QuestionID, COUNT(QuestionID) AS SOCAUTRALOI FROM ANSWER
 GROUP BY (QuestionID)
 HAVING COUNT(QuestionID)> '4';
 
 CREATE TABLE IF NOT EXISTS `Account`(
	`AccountID` 		TINYINT UNSIGNED AUTO_INCREMENT,
	`Email` 			varchar(50) NOT NULL UNIQUE KEY ,
	`Username`			varchar(50) NOT NULL UNIQUE KEY ,
	`Fullname` 			varchar(50) ,
	`DepartmentID` 		TINYINT UNSIGNED,
	`PositionID` 		TINYINT UNSIGNED,
	`CreateDate` 		DATETIME DEFAULT NOW(),
	
     PRIMARY KEY (AccountID)
     
);

INSERT INTO `Account`  
		(`Email`,        `Username`,   `Fullname`, `DepartmentID`, `PositionID`) 
VALUES  ('ONISHI@1.COM', 'ONISHI_1', 'KENTSUKE1', 	     '1', 		'1'),
		('ONISHI@2.COM', 'ONISHI_2', 'KENAATSUKE2',      '2', 		'1'),
		('ONISHI@3.COM', 'ONISHI_3', 'KENTSAUKAAAE3',    '2', 		'2'),
		('ONISHI@4.COM', 'ONISHI_4', 'KENTSAUKAAAE45',   '3', 		'3'),
		('ONISHI@5.COM', 'ONISHI_5', 'KENTSAAUKE5', 	 '2', 		'4'),
		('ONISHI@6.COM', 'ONISHI_6', 'KENTAASUKE6', 	 '5', 		'5');
        
        SELECT * FROM `ACCOUNT`;
	
   SELECT   USERNAME, FULLNAME, COUNT(*) 
   FROM `ACCOUNT`;
   
  SELECT max(character_length(Fullname)) FROM `Account` ;

        
 SELECT COUNT(DEPARTMENTID) FROM `ACCOUNT`
WHERE DEPARTMENTID = '5';

SELECT * FROM `ACCOUNT`
WHERE FULLNAME LIKE 'k%5';


SELECT `DepartmentID` FROM `ACCOUNT`
GROUP BY (DEPARTMENTID) ;


 --  HAVING COUNT(DepartmentID)> '2';

dROP TABLE IF EXISTS `ACCOUNT`;   
CREATE TABLE IF NOT EXISTS `Account`(
	`AccountID` 		TINYINT UNSIGNED AUTO_INCREMENT,
	`Email` 			varchar(50) NOT NULL UNIQUE KEY ,
	`Username`			varchar(50) NOT NULL UNIQUE KEY ,
	`Fullname` 			varchar(50) ,
	`DepartmentID` 		TINYINT UNSIGNED,
	`PositionID` 		TINYINT UNSIGNED,
	`CreateDate` 		DATETIME DEFAULT NOW(),
	
     PRIMARY KEY (AccountID)
);

INSERT INTO `Account`  
		(`Email`,        `Username`,   `Fullname`, `DepartmentID`, `PositionID`) 
VALUES  ('ONISHI@1.COM', 'ONISHI_1', 'KENTSUKE1', 	     '1', 		'1'),
		('ONISHI@2.COM', 'ONISHI_2', 'KENAATSUKE2',      '2', 		'1'),
		('ONISHI@3.COM', 'ONISHI_3', 'KENTSAUKAAAE3',    '2', 		'2'),
		('ONISHI@4.COM', 'ONISHI_4', 'KENTSAUKAAAE45',   '3', 		'3'),
		('ONISHI@5.COM', 'ONISHI_5', 'KENTSAAUKE5', 	 '4', 		'4'),
		('ONISHI@6.COM', 'ONISHI_6', 'KENTAASUKE6', 	 '5', 		'5');
        
        
        
        drop table luongNV;
        CREATE TABLE IF NOT EXISTS `luongNV`(
	IDnhanvien 		TINYINT UNSIGNED AUTO_INCREMENT,
	Department		varchar(500),
	Salary 			varchar(500),
	GRADE			varchar(500),
	PRIMARY KEY (IDnhanvien)
);
INSERT INTO luongNV ( department , 	salary,		GRADE) 
VALUES 				 ('PQA' ,	 	'10' ,		'G3' ),
					 ('MQA' ,	 	'11' ,		'G2'),
					 ('PUR' ,	 	'8' , 		'G1'),
                     ('PUS' ,	 	'5' , 		'G1'),
                     ('PQA' ,	 	'15' , 		'G4'),
                     ('MQA' ,	 	'20' ,		'G5'),
                     ('PUR' ,	 	'15' ,		'G3' ),
                     ('PQA' ,	 	'10' ,  	'G3' );
        
SELECT * FROM LUONGNV;    

SELECT DEPARTMENT , MAX(SALARY)
FROM LUONGNV
GROUP BY (department); 
-- HAVING MAX(SALARY);

SELECT DEPARTMENT , GRADE, COUNT(GRADE)
FROM LUONGNV
GROUP BY (department); 
       
                    
                    
                    
                    
                    