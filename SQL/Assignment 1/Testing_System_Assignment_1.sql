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
	DepartmentID 	int,
	PositionID 		int,
	Createdate 		date
);
 

CREATE TABLE IF NOT EXISTS `Group`(
	GroupID 		int,
	Groupname 		varchar(50),
	CreatorID 		int,
	Createdate 		date
);

CREATE TABLE IF NOT EXISTS `Groupaccount`(
	GroupID 		int,
	Accountid 		int,
	Joindate 		date
);

CREATE TABLE IF NOT EXISTS`Typequestion`(
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
	CategoryID 		int,
	TypeID 			int,
	CreatorID 		int,
	CreatorDate 	date
);


CREATE TABLE IF NOT EXISTS `Answer`(
	AnswerID 		int,
	Content 		varchar(1500),
	Questionid 		int,
	Iscorrect 		varchar(50)
);

CREATE TABLE IF NOT EXISTS `Exam`(
	ExamID 			int,
	`code` 			varchar(50),
	Title 			varchar(50),
	CategoryID 		int,
	Duration 		time,
	CreatorID 		int,
	Createdate 		date
);

CREATE TABLE IF NOT EXISTS `Examquestion`(
	ExamID 			int,
	QuestionID 		int
);


-- updated
