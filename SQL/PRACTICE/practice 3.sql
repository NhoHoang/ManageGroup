DROP DATABASE IF EXISTS `Practice`;
CREATE DATABASE IF NOT EXISTS `Practice`;
USE `Practice`;

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
	CreateDate 		DATE ,
    
    PRIMARY KEY (QuestionID ),
	FOREIGN KEY (CategoryID) REFERENCES `Categoryquestion`(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES `TypeQuestioN`(TypeID)
);

INSERT INTO `Question` 
		(Content , CategoryID, TypeID , CreatorID, CreateDate)
VALUES 	('Câu hỏi về Java' , '1' , '1' , '2' ,'2020-04-05'),
		('Câu Hỏi về PHP' , '10' , '2' , '2' ,'2020-04-05'),
		('Hỏi về C#' , '9' , '2' , '3' ,'2020-04-06'),
		('Hỏi về Ruby' , '6' , '1' , '4' ,'2020-04-06'),
		('Hỏi về Postman' , '5' , '1' , '5' ,'2020-04-06'),
		('Hỏi về ADO.NET' , '3 ', '2' , '6' ,'2020-04-06'),
		('Hỏi về ASP.NET' , '2' , '1' , '7' ,'2020-04-06'),
		('Hỏi về C++' , '8' , '1' , '8' ,'2020-04-07'),
		('Hỏi về SQL' , '4' , '2' , '9' ,'2020-04-07'),
		('Hỏi về Python' , '7' , '1' , '10' ,'2020-04-07');

SELECT * FROM `QUESTION`;

DELETE FROM `QUESTION`
WHERE
 CONTENT LIKE ('CÂU HỎI%');
 -- (SUBSTRING_INDEX(Content,' ',2)) ='câu hỏi';





CREATE TABLE IF NOT EXISTS `Answer`(
	AnswerID 		TINYINT UNSIGNED AUTO_INCREMENT,
	Content 		varchar(1500),
	Questionid 		TINYINT UNSIGNED,
	IsCorrect 		ENUM('1','0') DEFAULT ('0'),
   
	PRIMARY KEY (AnswerID),
    FOREIGN KEY (Questionid) REFERENCES `Question`(Questionid) on delete cascade
);

INSERT INTO Answer ( Content , 		QuestionID , isCorrect )
VALUES 				 ('Trả lời 01',		'1' ,		 '0'),
					 ('Trả lời 02',		'1' ,		 '1'),
					 ('Trả lời 03',	 	'6' ,		 '0'),
					 ('Trả lời 04', 	'1' ,		 '1'),
					 ('Trả lời 05', 	'6' , 		'1' ),
					 ('Trả lời 06', 	'3' , 		'1' ),
					 ('Trả lời 07', 	'2' , 		'0' ),
					 ('Trả lời 08', 	'4' , 		'0' ),
					 ('Trả lời 09', 	'2' ,		 '1' ),
					 ('Trả lời 10', 	'1' , 		'1' );

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
	(`Code` ,		 Title , 		CategoryID, 	Duration , 	CreatorID , 		CreateDate )
VALUES 				
	('VTIQ001' , 	'Đề thi C#' ,			'1' , 			'240' , 		'5' ,		'2019-04-05'),
	('VTIQ002' , 	'Đề thi PHP' ,			'10' ,			 '120' , 	'2' ,		'2019-04-05'),
	('VTIQ003' ,	 'Đề thi C++' ,		 	'9' ,			'120' , 	'2' ,		'2019-04-07'),
	('VTIQ004' ,	'Đề thi Java' ,			 '6' , 			'50', 		'3' ,		'2020-04-08'),
	('VTIQ005' , 	'Đề thi Ruby' ,			 '5' , 			'120', 		'4' ,		'2019-04-10'),
	('VTIQ006' , 	'Đề thi Postman' , 		 '3' ,			'10' , 		'6' ,		'2020-04-05'),
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



drop table `examquestion`;
CREATE TABLE IF NOT EXISTS `Examquestion`(
	ExamID 			TINYINT UNSIGNED,
	QuestionID 		varchar(50),
    
constraint `fk_exam`     foreign key (examid) references `exam`(examid)
);
SET FOREIGN_KEY_CHECKS=0;

alter table `examquestion`
drop constraint `fk_exam`;


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
                             
                             



INSERT INTO ExamQuestion(ExamID , QuestionID ) 
VALUES						 ( 1 , 5 ),
							( 1 , 10 ), 
							( 1 , 4 ), 
							( 2 , 3 ), 
							( 3 , 7 ), 
							( 2 , 10 ), 
							( 4 , 2 ), 
							( 4 , 10 ), 
							( 3 , 9 ), 
							 ( 2 , 8 );


