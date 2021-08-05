DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE  TestingSystem;

CREATE TABLE Department (
	DepartmentID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,	
	DepartmentName		VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `Position` (
	PositionID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
	PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

CREATE TABLE  `Account` (
	AccountID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Email				VARCHAR(50) NOT NULL,
	Username			VARCHAR(50) NOT NULL,
	FullName			VARCHAR(50) NOT NULL,
	DepartmentID		TINYINT UNSIGNED NOT NULL,
	PositionID			TINYINT UNSIGNED NOT NULL ,
	CreateDate			DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

CREATE TABLE `Group` (
	GroupID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	GroupName		  	VARCHAR(50) NOT NULL,
	CreatorID			TINYINT UNSIGNED CHECK (CreatorID > 0),
	CreateDate			DATETIME DEFAULT NOW()
);

CREATE TABLE GroupAccount (
	GroupID				TINYINT UNSIGNED,
	AccountID			TINYINT UNSIGNED,
	JoinDate			DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);


CREATE TABLE TypeQuestion (
	TypeID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	TypeName			ENUM('Essay', 'Multiple-Choice') NOT NULL
);

CREATE TABLE CategoryQuestion (
	CategoryID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	CategoryName		VARCHAR(50) NOT NULL
);

CREATE TABLE  Question (
	QuestionID			TINYINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
	Content				VARCHAR(50) NOT NULL,
	CategoryID			TINYINT UNSIGNED NOT NULL,
	TypeID				TINYINT UNSIGNED NOT NULL,
	CreatorID			TINYINT UNSIGNED NOT NULL,
	CreateDate			DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) 	REFERENCES TypeQuestion(TypeID)
);

CREATE TABLE  Answer (
	AnswerID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content				VARCHAR(100) NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
	IsCorrect			BIT DEFAULT 1,
     FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
    );

CREATE TABLE  Exam (
	ExamID 				TINYINT UNSIGNED ,
	`Code`			 	VARCHAR(50) NOT NULL,
	Title				VARCHAR(50) NOT NULL,
	CategoryID			TINYINT UNSIGNED NOT NULL,
	Duration			TINYINT UNSIGNED NOT NULL,
	CreatorID     		TINYINT UNSIGNED NOT NULL,
	CreateDate			DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

CREATE TABLE  ExamQuestion (
	ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL
);
-- add data Department
INSERT INTO  Department( DepartmentName)
VALUES						('finance'),
							('sale'),
							('marketing'),
                            ('telesale'),
                            ('protect');
					
							
-- add data  `Position`
INSERT INTO 	`Position`(PositionName)
  VALUES
							('Dev'),
							('Test'),
                            ('Scrum Master'),
                            ('PM');
 
INSERT INTO `account` (Email,				 Username, 		FullName,	 	DepartmentID, PositionID)
VALUES				('thanh123@gmail.com',  'thanh123',	'Nguyen Hoai Thanh',    	1,			1),
					('hau95@gmail.com', 	'hau95',	'Bui Van Hau',				1,			2),
					('linh94@gmail.com', 	'linh94',	'Le Tuan Linh',    			2,			2),
					('duymanh95@gmail.com', 'duymanh95', 'Dang Duy Manh',    		3,			3),
					('thoan98@gmail.com', 	'thoan98',	'Nguyen Ngoc Thoan',    	4,			4),
					('viet.dinh@gmail.com', 'viet93',	'Dinh Tuan Viet',	    	2,			4),
					('anhhoang99@gmail.com', 'hoanganh', 'Bui Hoang Anh',	    	3,			2),
					('thuylinh@gmail.com', 	 'thuylinh ', 'Nguyen Thuy Linh',    	5,			4),
					('duc.trung@gmail.com', 'ductrung',	 'Tran Trung Duc',  		4,			3),
					('hoaiphan@gmail.com', 'phanhoai',	'Phan Van Hoai',  		  	2,			4);
INSERT INTO `Group` ( GroupName , CreatorID , CreateDate)
VALUES 				(N'Testing System' , 5,'2019-03-05'),
					(N'Development' , 1,'2020-03-07'),
					(N'VTI Sale 01' , 2 ,'2020-03-09'),
					(N'VTI Sale 02' , 3 ,'2020-03-10'),
					(N'VTI Sale 03' , 4 ,'2020-03-28'),
					(N'VTI Creator' , 6 ,'2020-04-06'),
					(N'VTI Marketing 01' , 7 ,'2020-04-07'),
					(N'Management' , 8 ,'2020-04-08'),
					(N'Chat with love' , 9 ,'2020-04-09'),
					(N'Vi Ti Ai' , 10 ,'2020-04-10');
INSERT INTO `GroupAccount` ( GroupID , AccountID , JoinDate )
VALUES 						( 1 , 			1,	'2019-03-05'),
							( 1 , 			2,	'2020-03-07'),
							( 3 , 			3,	'2020-03-09'),
							( 3 , 			4,	'2020-03-10'),
							( 5 ,			 5,	'2020-03-28'),
							( 1 , 			3,	'2020-04-06'),
							( 1 , 			7,	'2020-04-07'),
							( 8 , 			3,	'2020-04-08'),
							( 1 , 			9,	'2020-04-09'),
							( 10 , 			10,	'2020-04-10');
INSERT INTO TypeQuestion (TypeName ) 
VALUES ('Essay' ), 
('Multiple-Choice' ); 
INSERT INTO CategoryQuestion (CategoryName )
VALUES							 ('Java' ),
								('ASP.NET' ),
								('ADO.NET' ),
								('SQL' ),
								('Postman' ),
								('Ruby' ),
								('Python' ),
								('C++' ),
								('C Sharp' ),
('PHP' );

INSERT INTO Question (Content , CategoryID, TypeID , CreatorID, CreateDate )
VALUES 							(N'Câu hỏi về Java' , 1 , '1' , '2' ,'2020-04-05'),
								(N'Câu Hỏi về PHP' , 10 , '2' , '2' ,'2020-04-05'),
								(N'Hỏi về C#' , 9 , '2' , '3' ,'2020-04-06'),
								(N'Hỏi về Ruby' , 6 , '1' , '4' ,'2020-04-06'),
								(N'Hỏi về Postman' , 5 , '1' , '5' ,'2020-04-06'),
								(N'Hỏi về ADO.NET' , 3 , '2' , '6' ,'2020-04-06'),
								(N'Hỏi về ASP.NET' , 2 , '1' , '7' ,'2020-04-06'),
								(N'Hỏi về C++' , 8 , '1' , '8' ,'2020-04-07'),
								(N'Hỏi về SQL' , 4 , '2' , '9' ,'2020-04-07'),
								(N'Hỏi về Python' , 7 , '1' , '10' ,'2020-04-07');
INSERT INTO Answer ( Content , QuestionID , isCorrect )
VALUES 				(N'Trả lời 01' ,	 1 ,	 0),
					(N'Trả lời 02' ,	 1 ,	 1),
					 (N'Trả lời 03',	 1 ,	 0 ),
					 (N'Trả lời 04', 	1 ,	 1 ),
					 (N'Trả lời 05', 	2 , 	1 ),
					 (N'Trả lời 06', 	3 , 	1 ),
					 (N'Trả lời 07', 	4 , 	0 ),
					 (N'Trả lời 08', 	8 , 	0 ),
					 (N'Trả lời 09', 	9 ,	 	1 ),
					 (N'Trả lời 10', 	10 , 	1 );
 INSERT INTO Exam (`Code` ,		 Title , 		CategoryID, 	Duration , 	CreatorID , 	CreateDate )
VALUES 				('VTIQ001' , N'Đề thi C#' ,			1 , 			60 , 		'5' ,'		2019-04-05'),
					('VTIQ002' , N'Đề thi PHP' ,		10 ,			 60 , 		'2' ,		'2019-04-05'),
					('VTIQ003' , N'Đề thi C++' ,		 9 ,			120 , 		'2' ,		'2019-04-07'),
					('VTIQ004' , N'Đề thi Java' ,		 6 , 			60, 		'3' ,		'2020-04-08'),
					('VTIQ005' , N'Đề thi Ruby' ,		 5 , 			120, 		'4' ,		'2020-04-10'),
					('VTIQ006' , N'Đề thi Postman' , 	3 ,				60 , 		'6' ,		'2020-04-05'),
					('VTIQ007' , N'Đề thi SQL' ,		 2 ,			60 , 		'7' ,		'2020-04-05'),
					('VTIQ008' , N'Đề thi Python' ,		 8 ,			60 , 		'8' ,		'2020-04-07'),
					('VTIQ009' , N'Đề thi ADO.NET' ,	 4 ,			90 , 		'9' ,		'2020-04-07'),
					('VTIQ010' , N'Đề thi ASP.NET' , 7 ,90 , '10' ,'2020-04-08');
 
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