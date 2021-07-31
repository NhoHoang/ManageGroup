CREATE DATABASE IF NOT EXISTS `testing_system_assignment_1`;
USE `testing_system_assignment_1`;


CREATE TABLE IF NOT EXISTS `department`(
department_ID int,
department_name varchar(50)
);
CREATE TABLE IF NOT EXISTS `Positon`(
Position_ID int,
Positon_name varchar(50)
);

CREATE TABLE IF NOT EXISTS `Account`(
AccountID int,
Email varchar(50),
username varchar(50),
fullname varchar(50),
departmentID int,
positionID int,
createdate date
);
 

CREATE TABLE IF NOT EXISTS `group`(
groupID int,
groupname varchar(50),
creatorID int,
createdate date
);

CREATE TABLE IF NOT EXISTS `groupaccount`(
groupID int,
accountid int,
joindate date
);

CREATE TABLE IF NOT EXISTS`typequestion`(
TypeID int,
typename varchar(50)
);


CREATE TABLE IF NOT EXISTS `categoryquestion`(
categoryID int,
categoryname varchar(50)
);


CREATE TABLE IF NOT EXISTS `question`(
questionID int,
content varchar(1500),
categoryid int,
typeid int,
creatorid int,
creatordate date
);


CREATE TABLE IF NOT EXISTS `answer`(
answerID int,
content varchar(1500),
questionid int,
iscorrect varchar(50)
);

CREATE TABLE IF NOT EXISTS `exam`(
examID int,
`code` varchar(50),
title varchar(50),
categoryID int,
duration time,
creatorID int,
createdate date
);

CREATE TABLE IF NOT EXISTS `examquestion`(
examID int,
questionID int
);
-- update
