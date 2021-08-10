DROP DATABASE IF EXISTS `Testing_System_Assignment_2+3`;
CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment_2+3`;
USE `Testing_System_Assignment_2+3`;

DROP TABLE IF EXISTS  `Department`;
CREATE TABLE IF NOT EXISTS `Department`(
	`DepartmentID` 	 	TINYINT UNSIGNED AUTO_INCREMENT,
	`DepartmentName` 	varchar(50) NOT NULL,
	 
     PRIMARY KEY (DepartmentID)
);

INSERT INTO `Department`(`DepartmentName`) 
VALUES 		( 'Marketing'),
			( 'Sale'),
			( 'Bảo_vệ'),
			( 'Nhân_sự'),
			( 'Kỹ_thuật'),
			( 'Tài_chính'),
			( 'Phó_GĐ'),
			( 'GĐ'),
			( 'Thư_ký'),
			( 'Bán_hàng');
            
            
            
-- --------------QUESTION_2--------
SELECT * FROM DEPARTMENT;
         -- -----QUESTION_3-------- 
SELECT DEPARTMENTID FROM DEPARTMENT 
WHERE DEPARTMENTNAME = "SALE";        
            
            
-- SELECT * FROM DEPARTMENT ORDER BY DEPARTMENTID DESC ;

            
DROP TABLE IF EXISTS  `Position`;
CREATE TABLE IF NOT EXISTS `Position`(
	`PositionID` 	TINYINT UNSIGNED AUTO_INCREMENT,
	`PositonName` 	varchar(50)  NOT NULL,
	
	 PRIMARY KEY (PositionID)
);

INSERT INTO `Position` (`PositonName`)
	VALUE 	 ('GM'),
			 ('Manager'),
			 ('AGM'),
			 ('G6'),
			 ('G5'),
             ('G4'),
             ('G3'),
			 ('G2');
             
             
             
 DROP TABLE IF EXISTS `ACCOUNT`;   
CREATE TABLE IF NOT EXISTS `Account`(
	`AccountID` 		TINYINT UNSIGNED AUTO_INCREMENT,
	`Email` 			varchar(50) NOT NULL UNIQUE KEY ,
	`Username`			varchar(50) NOT NULL UNIQUE KEY ,
	`Fullname` 			varchar(50) ,
	`DepartmentID` 		TINYINT UNSIGNED,
	`PositionID` 		TINYINT UNSIGNED,
	`CreateDate` 		DATETIME DEFAULT NOW(),
	
     PRIMARY KEY (AccountID),
	 FOREIGN KEY (DEPARTMENTID) REFERENCES `Department`(`DepartmentID`),
     FOREIGN KEY (PositionID) REFERENCES `Position`(`PositionID`)
     
);

INSERT INTO `Account`  
		(`Email`,        `Username`,   `Fullname`, `DepartmentID`, `PositionID`) 
VALUES  ('ONISHI@1.COM', 'ONISHI_1', 'KENTSUKE1', 	     '1', 		'1'),
		('ONISHI@2.COM', 'ONISHI_2', 'KENAATSUKE2',      '2', 		'1'),
		('ONISHI@3.COM', 'ONISHI_3', 'KENTSAUKAAAE3',    '1', 		'5'),
		('ONISHI@64.COM', 'ONISHI_4', 'KENTSAUKAAAE45',   '3', 		'3'),
		('ONISHI@4.COM', 'ONISHI_11', 'KENTSAAUKE5', 	 '5', 		'5'),
		('ONISHI@5.COM', 'ONISHI_12', 'KENTSAAUKE5', 	 '4', 		'5'),
		('ONISHI@66.COM', 'ONISHI_112', 'KENTSAAUKE5', 	 '4', 		'7'),
		('ONISHI@6.COM', 'ONISHI_6', 'KENTAASUKE6', 	 '1', 		'5');

select * from `account`;

select positionid as capbac, count(positionid) as soluong 
from `account`
group by positionid;

select DepartmentID as phongban, count(DepartmentID) as soluong 
from `account`
group by DepartmentID;


-- số lượng từng position của từng phòng

select DepartmentID as phongban, PositionID as capbac, count(positionid) as soluong
from `account`
group by DepartmentID , positionid
order by DepartmentID;

-- ======QUESTION 11--======
-- ===============================


SELECT * FROM `ACCOUNT`
WHERE FULLNAME LIKE 'k%5';




	-- SELECT * FROM ACCOUNT;
	-- SELECT FULLNAME AS 'TEN',
-- CHARACTER_LENGTH(FULLNAME) AS 'TEN' FROM `ACCOUNT` 
    -- ORDER BY ('DoDai') DESC LIMIT 1 AND ;
    
    
    
    
    -- ===QUESTION 10-- ====
    -- ===================
    -- ==================
SELECT COUNT(DEPARTMENTID) FROM `ACCOUNT`
WHERE DEPARTMENTID = '2';

-- -----QUESTION 4--------

SELECT FULLNAME AS 'TEN', character_length(Fullname) AS 'DODAI'
FROM `ACCOUNT`  
ORDER BY 'DODAI' DESC LIMIT 1;

SELECT MAX(character_length(FULLNAME))
FROM `ACCOUNT`;

-- SELECT COUNT(MAX(character_length(FULLNAME))
-- FROM `ACCOUNT` 
-- WHERE (MAX(character_length(FULLNAME))); ==





SELECT FULLNAME FROM `Account` 
WHERE character_length(Fullname)= 
(SELECT max(character_length(Fullname)) FROM `Account`) ;

-- -----QUESTION_5--------
SELECT accountID , email, username, fullname  FROM `Account` 
WHERE character_length(Fullname)= 
(SELECT max(character_length(Fullname)) FROM `Account`) 
AND DEPARTMENTid = '3' ;
 
 
 
 
 drop table if exists `group`;
CREATE TABLE IF NOT EXISTS `Group` (
    `GroupID` TINYINT UNSIGNED AUTO_INCREMENT,
    `GroupName` VARCHAR(50),
    `CreatorID` VARCHAR(50),
    `CreateDate` DATE,
    
    PRIMARY KEY (GroupID)
);


INSERT INTO `group` 
        (`GroupName`, `CreatorID`, `CreateDate`) 
VALUES  ('Audit1',  	'101', 		'2019-11-20'),
		('Audit2', 		'102', 		'2021-11-20'),
        ('Audit3', 		'101', 		'2018-11-20'),
        ('Audit4', 		'102', 		'2017-11-20'),
        ('Audit5', 		'105', 		'2015-11-20'),
        ('Audit6', 		'106', 		'2020-12-21');
   

-- NGAY_TAO_GROUP_GAN_DAY_NHAT_----  QUESTION 9
SELECT GROUPNAME , CREATEDATE FROM `GROUP`
ORDER BY `CREATEDATE` DESC
LIMIT 5;



   -- -------qUESTION 6------     
SELECT GROUPNAME, CREATEDATE FROM `GROUP`     
WHERE `CreateDate` < '2019-12-20';
        
    
    
    
drop table if exists `GroupAccount`;       
CREATE TABLE IF NOT EXISTS `GroupAccount`(
	GroupID 		TINYINT UNSIGNED,
	AccountID 		TINYINT UNSIGNED,
	JoinDate 		DATETIME not null DEFAULT NOW(),
	FOREIGN KEY (GroupID) REFERENCES `GROUP`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
    
);

INSERT INTO `GROUPACCOUNT` 
        (`GROUPID`, `ACCOUNTID`) 
VALUE   (	'1',		'1'	    ),
		(	'1',		'2'		),
		(	'2',		'3'		),
		(	'2',		'4'		),
		(	'3',		'5'		),
		(	'4',		'6'		);


CREATE TABLE IF NOT EXISTS`TypeQuestion`(
	TypeID 			TINYINT UNSIGNED AUTO_INCREMENT,
	TypeName 		ENUM('ESSAY', 'MULTIPLE-CHOICE'),
   
   PRIMARY KEY (TypeID)
);

INSERT INTO `TYPEQUESTION` 
			(`TYPENAME`)
	VALUE   ('MULTIPLE-CHOICE'),
			('ESSAY');
			

DROP TABLE IF EXISTS `Categoryquestion`;
CREATE TABLE IF NOT EXISTS `Categoryquestion`(
	CategoryID 		TINYINT UNSIGNED AUTO_INCREMENT,
	CategoryName 	ENUM('JAVA', 'asp.NET', 'SQL', 'POSTMAN', 'ADO.NET',
							'Ruby', 'Python','C++', 'C_Sharp','PHP' ) ,
    
    PRIMARY KEY (CategoryID)
);

INSERT INTO `Categoryquestion`  (`CategoryName`)
	VALUE   					('Java'),
								('ASP.NET'),
								('ADO.NET'),
								('SQL'),
								('Postman'),
								('Ruby'),
								('Python'),
								('C++'),
								('C_Sharp'),
								('PHP');
			
DROP TABLE if exists `QUESTION`;
CREATE TABLE IF NOT EXISTS `Question`(
	QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT,
	Content 		varchar(1500),
	CategoryID 		TINYINT UNSIGNED,
	TypeID 			TINYINT UNSIGNED,
	CreatorID 		varchar(50),
	CreateDate 		DATEtime ,

    PRIMARY KEY (QuestionID ),
	FOREIGN KEY (CategoryID) REFERENCES `Categoryquestion`(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES `TypeQuestioN`(TypeID)
);



INSERT INTO `Question` 
		(Content , 		CategoryID, 	TypeID , 	CreatorID, 		CreateDate)
VALUES 	('Câu hỏi về Java' , '1' , 		'1' , 		'2' ,			'2020-04-05'),
		('Câu Hỏi về PHP' , '2' , 		'2' , 		'2' ,			'2020-04-05'),
		('Hỏi về C#' , 		'3' , 		'2' ,		'3' ,			'2020-04-06'),
		('Hỏi về Ruby' , 	'4' , 		'1' , 		'4' ,			'2020-04-06'),
		('Hỏi về Postman' , '5' , 		'1' , 		'5' ,			'2020-04-06'),
		('Hỏi về ADO.NET' , '6 ', 		'2' , 		'6' ,			'2020-04-06'),
		('Hỏi về ASP.NET' , '7' ,		'1' ,		'6' ,			'2020-04-06'),
		('Hỏi về C++' , 	'8' , 		'1' ,	    '5' ,			'2020-04-07'),
		('Hỏi về SQL' , 	'9' , 		'2' , 		'4' ,			'2020-04-07'),
		('Hỏi về Python' ,  '10' , 		'1' , 		'1' ,			'2020-04-07');

SELECT * FROM `QUESTION`;

DELETE FROM `QUESTION`
WHERE
 CONTENT LIKE ('CÂU HỎI%');
 -- (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi';




drop table if exists `answer`;
CREATE TABLE IF NOT EXISTS `Answer`(
	AnswerID 		TINYINT UNSIGNED AUTO_INCREMENT,
	Content 		varchar(1500),
	Questionid 		TINYINT UNSIGNED,
	IsCorrect 		varchar(50),
   
	PRIMARY KEY (AnswerID),
	constraint FK_Ques FOREIGN KEY (Questionid) REFERENCES `Question`(Questionid)
);


alter table `answer`
change column `iscorrect` `correct or not` varchar(50);

alter table `answer`
change column `correct or not` `iscorrect` varchar(50);
 
select * from `answer`;

INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES 				  ('Câu trả lời 1 - question SQL 1', 1, 1),
					   ('Câu trả lời 2 - question SQL 1', 1, 0),
					   ('Câu trả lời 3 - question SQL 1', 1, 0),
					   ('Câu trả lời 4 - question SQL 1', 1, 1),
					   ('Câu trả lời 1 - question SQL 2', 2, 0),
					   ('Câu trả lời 2 - question SQL 2', 2, 0),
					   ('Câu trả lời 3 - question SQL 2', 2, 0),
					   ('Câu trả lời 4 - question SQL 2', 2, 1),
					   ('Câu trả lời 1 - question JAVA 1', 3, 0),
					   ('Câu trả lời 2 - question JAVA 1', 3, 1),
					   ('Câu trả lời 1 - question JAVA 2', 4, 0),
					   ('Câu trả lời 2 - question JAVA 2', 4, 0),
					   ('Câu trả lời 3 - question JAVA 2', 4, 0),
					   ('Câu trả lời 4 - question JAVA 2', 4, 1),
					   ('Câu trả lời 1 - question HTML 1', 5, 1),
					   ('Câu trả lời 2 - question HTML 2', 5, 0);
					   
-- alter table `answer`
-- drop constraint  fk_ques ;

-- INSERT INTO `Answer` (    Content , 	 QuestionID , isCorrect )
-- VALUES 				 ('Trả lời 01',		'1' ,		 '0'),
	-- 				 ('Trả lời 02',		'1' ,		 '1'),
	-- 				 ('Trả lời 03',	 	'1' ,		 '0'),
	-- 				 ('Trả lời 04', 	'2' ,		 '1');
	-- 				--  ('Trả lời 05', 	'3' , 		 '1' ),
					 -- ('Trả lời 06', 	'3' , 		 '1' ),
					 -- ('Trả lời 07', 	'2' , 		 '0' ),
					 -- ('Trả lời 08', 	'4' , 		 '0' ),
					 -- ('Trả lời 09', 	'5' ,		 '1' ),
					 -- ('Trả lời 10', 	'4' , 		 '1' );

-- alter table `answer`
-- drop constraint  fk_ques ;

SELECT * FROM ANSWER;
SELECT QuestionID FROM ANSWER
 GROUP BY (QuestionID);
 
 
 SELECT QuestionID, COUNT(*) FROM ANSWER
 GROUP BY (QuestionID) HAVING COUNT(QuestionID)>= '4'; 
 -- ORDER BY (QUESTIONID) DESC ;
 
 
-- ========QUESTION 7 --====================
-- ==================================================
 SELECT QuestionID, COUNT(QuestionID) AS SOCAUTRALOI FROM ANSWER
 GROUP BY (QuestionID)
 HAVING COUNT(QuestionID)> '4';

-- ==================

DROP TABLE `EXAM`;
CREATE TABLE IF NOT EXISTS `Exam`(
	ExamID 			TINYINT UNSIGNED AUTO_INCREMENT,
	`code` 			varchar(50),
	Title 			varchar(50),
	CategoryID 		varchar(50),
	Duration 		SMALLINT,
	CreatorID 		varchar(50),
	Createdate 		DATE,

    PRIMARY KEY (ExamID)
);

INSERT INTO Exam 
	(`Code` ,			 Title , 		CategoryID, 	  Duration , 	CreatorID , 	 CreateDate )
VALUES 				
	('VTIQ001' , 	'Đề thi C#' ,			'1' , 			'240' , 		'5' ,		'2019-04-05'),
	('VTIQ002' , 	'Đề thi PHP' ,			'10' ,		    '120' , 		'2' ,		'2019-04-05'),
	('VTIQ003' ,	 'Đề thi C++' ,		 	'9' ,			'120' , 		'2' ,		'2019-04-07'),
	('VTIQ004' ,	'Đề thi Java' ,			 '6' , 			'50', 			'3' ,		'2020-04-08'),
	('VTIQ005' , 	'Đề thi Ruby' ,			 '5' , 			'120', 			'4' ,		'2019-04-10'),
	('VTIQ006' , 	'Đề thi Postman' , 		 '3' ,			'10' , 			'6' ,		'2020-04-05'),
	('VTIQ007' ,	'Đề thi SQL' ,			 '2' ,			'120' , 		'7' ,		'2020-04-05'),
	('VTIQ008' , 	'Đề thi Python' ,		 '8' ,			'120' , 		'8' ,		'2020-04-07'),
	('VTIQ009' , 	'Đề thi ADO.NET' ,		 '4' ,			'240' , 		'9' ,		'2020-04-07'),
	('VTIQ010' , 	'Đề thi ASP.NET' ,		 '7' ,			'120' , 		'10' ,		'2020-04-08');

-- QUESTION 8 -------
-- ==============
SELECT `CODE` 
FROM EXAM 
WHERE DURATION<'60' AND CREATEDATE <NOW();

-- QUESTION 12--
-- ============-- ============-- ============
-- ============-- ============
-- ============-- ============

DELETE FROM `EXAM`
WHERE CREATEDATE <'2020-04-05';

SELECT * FROM `EXAM`;




CREATE TABLE IF NOT EXISTS `Examquestion`(
	ExamID 			TINYINT UNSIGNED,
	QuestionID 		TINYINT UNSIGNED,
    
    -- constraint `fk_exam` 
    foreign key (examid) references `exam`(examid),
	CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);


INSERT INTO ExamQuestion(ExamID , QuestionID ) 
VALUES						 ( 1 , 5 ),
							( 2 , 10 ), 
							( 3 , 4 ), 
							( 4 , 3 ), 
							( 5 , 7 ), 
							( 6 , 10 ), 
							( 7 , 2 ), 
							( 8 , 10 ), 
							( 9 , 9 ), 
							 ( 10 , 8 );

-- ================================ Assignment 4 --=================================
-- =================================	-- =================================
-- =================================-	- =================================
-- =================================     -- =================================




