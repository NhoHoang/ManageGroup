CREATE DATABASE IF NOT EXISTS `Testing_System_Assignment_1`;
USE `Testing_System_Assignment_1`;

CREATE TABLE IF NOT EXISTS `Department`(
	DepartmentID 	int,
	DepartmentName 	varchar(50)
);
CREATE TABLE IF NOT EXISTS `Positon`(
	PositionID 		int,
	PositonName 	varchar(50)
);

CREATE TABLE IF NOT EXISTS `Account`(
	AccountID 		int,
	Email 			varchar(50),
	Username		varchar(50),
	Fullname 		varchar(50),
	DepartmentID 	varchar(50),
	PositionID 		varchar(50),
	Createdate 		date
);
 

CREATE TABLE IF NOT EXISTS `Group`(
	GroupID 		int,
	Groupname 		varchar(50),
	CreatorID 		varchar(50),
	Createdate 		date
);

CREATE TABLE IF NOT EXISTS `GroupAccount`(
	GroupID 		varchar(50),
	AccountId 		varchar(50),
	Joindate 		date
);

CREATE TABLE IF NOT EXISTS`TypeQuestion`(
	TypeID 			int,
	Typename 		varchar(50)
);


CREATE TABLE IF NOT EXISTS `Categoryquestion`(
	CategoryID 		int,
	CategoryName 	varchar(50)
);


CREATE TABLE IF NOT EXISTS `Question`(
	QuestionID 		int,
	Content 		varchar(1500),
	CategoryID 		varchar(50),
	TypeID 			varchar(50),
	CreatorID 		varchar(50),
	CreatorDate 	date
);


CREATE TABLE IF NOT EXISTS `Answer`(
	AnswerID 		int,
	Content 		varchar(1500),
	Questionid 		varchar(50),
	IsCorrect 		varchar(50)
);

CREATE TABLE IF NOT EXISTS `Exam`(
	ExamID 			int,
	`code` 			varchar(50),
	Title 			varchar(50),
	CategoryID 		varchar(50),
	Duration 		time,
	CreatorID 		varchar(50),
	Createdate 		date
);

CREATE TABLE IF NOT EXISTS `Examquestion`(
	ExamID 			varchar(50),
	QuestionID 		varchar(50)
);


-- updated
