CREATE DATABASE if not exists `testing_system_assignment_1`;
use `testing_system_assignment_1`;


drop table if exists `department`;
CREATE table if not exists `department`(
department_ID int,
department_name varchar(50)
);
create table if not exists `Positon`(
Position_ID int,
Positon_name varchar(50)
);

create table if not exists `Account`(
AccountID int,
Email varchar(50),
username varchar(50),
fullname varchar(50),
departmentID int,
positionID int,
createdate date
);
 

create table if not exists `group`(
groupID int,
groupname varchar(50),
creatorID int,
createdate date
);

create table if not exists `groupaccount`(
groupID int,
accountid int,
joindate date
);

create table if not exists `typequestion`(
TypeID int,
typename varchar(50)
);


create table if not exists `categoryquestion`(
categoryID int,
categoryname varchar(50)
);


create table if not exists `question`(
questionID int,
content varchar(1500),
categoryid int,
typeid int,
creatorid int,
creatordate date

);


create table if not exists `answer`(
answerID int,
content varchar(1500),
questionid int,
iscorrect varchar(50)
);

create table if not exists `exam`(
examID int,
`code` varchar(50),
title varchar(50),
categoryID int,
duration time,
creatorID int,
createdate date
);

create table if not exists `examquestion`(
examID int,
questionID int
);
-- update
