/* Lenh xoa Database */
DROP DATABASE IF EXISTS `Testing_System_4`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_4`;
/* Lenh su dung Database */
USE `Testing_System_4`;


/*------------------- Create table ----------------------- */

/* Lenh xoa bang */
DROP TABLE IF EXISTS `Department`;
/* Len tao bang va cac cot du lieu cua bang--*/
CREATE TABLE `Department`
(
    `DepartmentID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `DepartmentName` VARCHAR(50) NOT NULL UNIQUE KEY
);
Select * From `Department`;

DROP TABLE IF EXISTS `Position`;
CREATE TABLE IF NOT EXISTS `Position`
(
    `PositionID`   TINYINT UNSIGNED AUTO_INCREMENT,
    `PositionName` ENUM ('Dev1', 'Dev2', 'Test', 'Scrum Master', 'PM'),
    CONSTRAINT pk_1 PRIMARY KEY (PositionID)
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE IF NOT EXISTS `Account`
(
    `AccountID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Email`        VARCHAR(100) UNIQUE,
    `Username`     VARCHAR(50) NOT NULL,
    `Fullname`     VARCHAR(50),
    `DepartmentID` TINYINT UNSIGNED,
    `PositionID`  TINYINT UNSIGNED,
    `CreateDate`   DATETIME ,
    CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position` (`PositionID`) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS `Group`
(
    `GroupID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `GroupName`  VARCHAR(50) NOT NULL,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE IF NOT EXISTS `GroupAccount`
(
    `GroupID`   MEDIUMINT,
    `AccountID` MEDIUMINT,
    `JoinDate`  DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE IF NOT EXISTS `TypeQuestion`
(
    `TypeID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `TypeName` VARCHAR(50)
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE IF NOT EXISTS `CategoryQuestion`
(
    `CategoryID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE IF NOT EXISTS `Question`
(
    `QuestionID` TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `CategoryID` TINYINT UNSIGNED,
    `TypeID`     TINYINT UNSIGNED,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME ,
    CONSTRAINT fk_q1 FOREIGN KEY (`CreatorID`) REFERENCES `Account` (`AccountID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_q2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion` (`CategoryID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_q3 FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion` (`TypeID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE IF NOT EXISTS `Answer`
(
    `AnswerID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `QuestionID` TINYINT UNSIGNED,
    `isCorrect`  BIT, 
    CONSTRAINT fk_qid FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`QuestionID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE IF NOT EXISTS `Exam`
(
    `ExamID`     TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`       VARCHAR(20) NOT NULL,
    `Title`      VARCHAR(50) NOT NULL,
    `CategoryID` TINYINT UNSIGNED,
    `Duration`   TINYINT,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME ,
    CONSTRAINT fk_ex_1 FOREIGN KEY (CreatorID) REFERENCES Account (AccountID) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_ex_2 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON UPDATE CASCADE ON DELETE SET NULL
);


DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE IF NOT EXISTS `ExamQuestion`
(
    `ExamID`     TINYINT UNSIGNED,
    `QuestionID` TINYINT UNSIGNED,
    CONSTRAINT fk_eq1 FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);


/* ---------------------- INSERT DATA ---------------------------- */
/* INSERT DATA bang Department */
INSERT INTO `Department`(`DepartmentName`)
VALUES ('Phong Ky Thuat 1'),
       ('Phong Ky Thuat 2'),
       ('Phong Dev 1'),
       ('Phong Dev 2'),
       ('Phong Sale'),
       ('Phong Marketing'),
       ('Phong Giam Doc'),
       ('Phong Tai Chinh');

/* Lenh sua bang `Position` sua kieu du lieu cot `PositionName` */
ALTER TABLE `Position`
    MODIFY COLUMN `PositionName` ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master' , 'Test');
/* INSERT DATA bang Position */
INSERT INTO `Position`(`PositionName`)
VALUES ('Dev1'),
       ('Dev2'),
       ('Test'),
       ('PM'),
       ('Leader'),
       ('Scrum Master');

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Account`
    DROP CONSTRAINT `fk_dp_id`,
    DROP CONSTRAINT `fk_ps_id`;
/* INSERT DATA bang Account */
INSERT INTO `Account`(`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`)
VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
       ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
       ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
       ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
       ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
       ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
       ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Thất Tùng', 3, 3, '2020-10-01'),
       ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
       ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
       ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
       ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01');

/* INSERT DATA bang Group */
INSERT INTO `Group`(`GroupName`, `CreatorID`, CreateDate)
VALUES ('Nhom 1', '3', '2021-04-03'),
       ('Nhom 2', '3', '2019-01-03'),
       ('Nhom 3', '2', '2020-04-03'),
       ('Nhom 4', '1', NOW()),
       ('Nhom 5', '3', '2021-06-03'),
       ('Nhom 6', '1', '2020-04-03'),
       ('Nhom 7', '5', '2021-04-03'),
       ('Nhom 8', '5', '2019-05-03'),
       ('Nhom 9', '3', '2019-01-03'),
       ('Nhom 10', '1', NOW());

/* INSERT DATA bang GroupAccount */
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES ('1', '1', '2021-06-01'),
       ('1', '3', '2020-01-01'),
       ('1', '2', NOW()),
       ('1', '4', '2021-06-01'),
       ('2', '1', '2021-06-01'),
       ('2', '10', '2019-05-01'),
       ('5', '1', '2021-06-01'),
       ('5', '3', '2020-01-01'),
       ('5', '4', '2021-07-01'),
       ('3', '1', '2021-06-01'),
       ('9', '2', '2021-06-01'),
       ('10', '1', NOW());

/* INSERT DATA bang TypeQuestion */
INSERT INTO `TypeQuestion`(`TypeName`)
VALUES ('Trac nghiem'),
       ('Tu Luan');

/* INSERT DATA bang CategoryQuestion */
/*`CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')*/
INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES ('Java'),
       ('SQL'),
       ('HTML'),
       ('CSS '),
       ('.NET'),
       ('Python'),
       ('Ruby'),
       ('JavaScript');

/* Lenh sua bang `Question` Xoa rang buoc khoa ngoai Foreign Key */
ALTER TABLE `Question`
    DROP CONSTRAINT `fk_q1`,
    DROP CONSTRAINT `fk_q2`,
    DROP CONSTRAINT `fk_q3`;
/* INSERT DATA bang Question */
INSERT INTO `Question`(`Content`, CategoryID, TypeID, CreatorID, CreateDate)
VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
       ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       ('Câu hỏi JAVA 1', 1, 1, 10, '2021-07-01'),
       ('Câu hỏi JAVA 2', 1, 2, 5, '2021-06-01'),
       ('Câu hỏi HTML 1', 3, 1, 2, NOW()),
       ('Câu hỏi HTML 2', 3, 2, 2, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Answer`
    DROP CONSTRAINT `fk_qid`;
/* INSERT DATA bang Answer */
INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES ('Câu trả lời 1 - question SQL 1', 1, 1),
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

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Exam`
    DROP CONSTRAINT `fk_ex_1`;
ALTER TABLE `Exam`
    DROP CONSTRAINT `fk_ex_2`;
/* INSERT DATA bang Exam */
INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
       ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
       ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
       ('MS_07', 'De thi 07', 1, 60, 1, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `ExamQuestion`
    DROP CONSTRAINT `fk_eq1`,
    DROP CONSTRAINT `fk_eq2`;
/* INSERT DATA bang Examquestion */

INSERT INTO `ExamQuestion`
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 2),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 3),
       (10, 3),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 5),
       (16, 5);
       
       
       
       
       
       
       
       
       
       
       -- ================================ Assignment 4 --=================================
-- =================================	-- =================================
-- =================================-	- =================================
-- =================================     -- =================================

select * from `account`;
select * from `department`;


update `account`
set departmentid = null
where `accountid` = '3';

SELECT A.`AccountID`, A.`EMAIL`, A.`FULLNAME` ,  D.`DEPARTMENTID`, D.`DEPARTMENTNAME`
FROM `ACCOUNT` AS A 
LEFT JOIN  `DEPARTMENT` AS D
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`;

SELECT A.`AccountID`, A.`EMAIL`, A.`FULLNAME` ,  D.`DEPARTMENTID`, D.`DEPARTMENTNAME`
FROM `ACCOUNT` AS A 
INNER JOIN  `DEPARTMENT` AS D
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`;

SELECT A.`AccountID`, A.`EMAIL`, A.`FULLNAME` ,  D.`DEPARTMENTID`, D.`DEPARTMENTNAME`
FROM `ACCOUNT` AS A 
RIGHT JOIN  `DEPARTMENT` AS D
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`;


# PHONG BAN KO CO NHAN VIEN NAO
SELECT  D.`DEPARTMENTID`, D.`DEPARTMENTNAME`
FROM `ACCOUNT` AS A 
LEFT JOIN  `DEPARTMENT` AS D
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`
WHERE A.`AccountID` IS NULL;

-- ==> Question 1:
-- ================================================================================================
-- ================================================================================================
SELECT A.`AccountID`, A.`EMAIL`, A.`FULLNAME` ,  D.`DEPARTMENTID`, D.`DEPARTMENTNAME`
FROM `ACCOUNT` AS A 
INNER JOIN  `DEPARTMENT` AS D
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`;
-- ================================================================================================
-- ================================================================================================


SELECT A.`AccountID`, A.`EMAIL`, A.`FULLNAME` ,  D.`DEPARTMENTID`, D.`DEPARTMENTNAME`
FROM `ACCOUNT` AS A 
LEFT JOIN  `DEPARTMENT` AS D
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`;

select * from `account`;

SELECT  *
FROM `ACCOUNT` AS A
WHERE `CREATEDATE` > '2020-12-20';


-- ==> Question 2:
-- ========================

SELECT  *
FROM `ACCOUNT` AS A
WHERE `CREATEDATE` > '2020-12-20';

# OR

SELECT D.DepartmentName, A.Fullname, A.CreateDate
FROM `ACCOUNT` AS A
JOIN
`DEPARTMENT` AS D
ON D.DEPARTMENTID = A.DEPARTMENTID
WHERE A.CreateDate > '2020-12-20';


-- ========================
-- ========================


SELECT A.`FULLNAME` , A.`EMAIL` , A.`USERNAME`, P.`POSITIONNAME`
FROM `ACCOUNT` AS A 
INNER JOIN  `POSITION` AS P
ON A.`POSITIONID` = P.`POSITIONID`
WHERE P.`POSITIONNAME` LIKE  'DEV%' or
	  P.`POSITIONNAME` LIKE  'pm%';



-- ==> Question 3:
-- ========================

SELECT A.`FULLNAME` , A.`EMAIL` , A.`USERNAME`, P.`POSITIONNAME`
FROM `ACCOUNT` AS A 
INNER JOIN  `POSITION` AS P
ON A.`POSITIONID` = P.`POSITIONID`
WHERE P.`POSITIONNAME` LIKE  'DEV%';




-- ========================
-- ========================
# NHỮNG PHÒNG BAN CÓ TỪ 3 NGƯỜI ĐỔ LÊN
SELECT A.DepartmentID , D.DepartmentName, COUNT(A.DepartmentID) AS `SL`
FROM department AS D
JOIN `ACCOUNT` AS A
ON D.DEPARTMENTID = A.DepartmentID
GROUP BY (A.DepartmentID)
HAVING SL> '2';

## CHỌN RA NHỮNG PHÒNG BAN KO CÓ NHÂN VIÊN NÀO" 

SELECT *
FROM DEPARTMENT AS D
LEFT JOIN `ACCOUNT` AS A
ON D.departmentID = A.DEPARTMENTID
WHERE
A.departmentID IS NULL;

# CASCH 2
SELECT D.DepartmentName, A.Fullname, A.PositionID
FROM DEPARTMENT AS D
JOIN `ACCOUNT` AS A
ON D.departmentID = A.DEPARTMENTID

UNION 
SELECT D.DepartmentName, A.Fullname, A.PositionID
FROM DEPARTMENT AS D
LEFT JOIN `ACCOUNT` AS A
ON D.departmentID = A.DEPARTMENTID
WHERE A.DepartmentID IS NULL;


-- ========================
-- ========================
-- A.COUNT(DEPARTMENTID) AS SL_NVIEN
-- COUNT(DEPARTMENTID) AS SL_NVIEN 
-- ==> Question 4:
-- ========================

SELECT 	    D.`DEPARTMENTID`,  D.`DEPARTMENTNAME`,  COUNT(A.`DEPARTMENTID`) AS SL_NVIEN
FROM  	  	`DEPARTMENT` AS D
INNER JOIN  `ACCOUNT` AS A
ON  D.`DEPARTMENTID` = A.`DEPARTMENTID`
GROUP BY A.`DEPARTMENTID`;
-- HAVING COUNT(A.DepartmentID) >3;





-- ========================
-- ========================
-- ========================
-- ========================
 -- COUNT(QUESTIONID) AS SL_CAUHOITRONGDETHI
SELECT  QUESTIONID,  COUNT(EXAMID) AS SL FROM `EXAMQUESTION`
GROUP BY QUESTIONID 
ORDER BY SL DESC
LIMIT 1;




SELECT * FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;



## LẤY RA GROUP KO CÓ ACCOUNT NÀoptimize

SELECT *
FROM `GROUP` AS G
LEFT JOIN `GROUPACCOUNT` AS GA
ON G.`GROUPID` = GA.`GROUPID`
WHERE GA.`GROUPID` IS NULL;









-- UNION TEST 
SELECT `FULLNAME` , `EMAIL` ,`USERNAME`
FROM `ACCOUNT`

UNION

SELECT `POSITIONNAME`
FROM `POSITION`
WHERE `POSITIONNAME` LIKE 'DEV%';
-- =================-- =================-- =================

-- =================-- =================-- =================

# PREPARE FOR QUESTION5:
SELECT q.QuestionID, COUNT(EQ.QuestionID) AS `SL`
FROM QUESTION AS Q
JOIN examquestion AS EQ
ON
Q.QuestionID = EQ.QuestionID
GROUP BY (EQ.QuestionID)
HAVING `SL` = (     SELECT MAX(T.SL) 
					FROM (
					SELECT q.QuestionID, COUNT(EQ.QuestionID) AS `SL`
					FROM QUESTION AS Q
					JOIN examquestion AS EQ
					ON
					Q.QuestionID = EQ.QuestionID
					GROUP BY (EQ.QuestionID))  AS T
                    
);


SELECT  D.DepartmentName, count(*) AS 'SLnv' 
FROM `account` AS A 
JOIN `department` AS D 
ON A.DepartmentID = D.DepartmentID 
GROUP BY (A.DepartmentID)
HAVING `SLnv`=(  	 	SELECT MAX(T.SL) 
						FROM (SELECT  D.DepartmentName, count(*) AS 'SL' 
						FROM `account` AS A 
						JOIN `department` AS D 
						ON A.DepartmentID = D.DepartmentID 
						GROUP BY (A.DepartmentID)) AS T
                
			 );


# ONE MỎE TIME
SELECT EQ.QuestionID, COUNT(EQ.QuestionID) AS `SL`
FROM examquestion AS EQ
JOIN question AS Q
ON EQ.QuestionID = Q.QuestionID
GROUP BY (EQ.QuestionID)
HAVING `SL` = 
				(SELECT MAX(T.SL) FROM (SELECT EQ.QuestionID, COUNT(EQ.QuestionID) AS `SL`
									FROM examquestion AS EQ
									JOIN question AS Q
									ON EQ.QuestionID = Q.QuestionID
									GROUP BY (EQ.QuestionID)) AS T
				);
	
    -- ==> CAU 5 XONG            

## CONTENT CỦA NHỮNG CÂU ĐÓ LÀ GÌ?

SELECT EQ.QuestionID, Q.CONTENT , COUNT(EQ.QuestionID) AS `SL`
FROM examquestion AS EQ
JOIN question AS Q
ON EQ.QuestionID = Q.QuestionID
GROUP BY (EQ.QuestionID)
HAVING `SL` = 
				(SELECT MAX(T.SL) FROM (SELECT EQ.QuestionID, COUNT(EQ.QuestionID) AS `SL`
									FROM examquestion AS EQ
									JOIN question AS Q
									ON EQ.QuestionID = Q.QuestionID
									GROUP BY (EQ.QuestionID)) AS T
				);


#### NHỮNG CÂU HỎI KO XUẤT HIỆN TRONG ĐỀ THI:

SELECT Q.QuestionID, EQ.ExamID
FROM 
examquestion AS EQ
RIGHT JOIN question AS Q
ON EQ.QuestionID = Q.QuestionID
WHERE EQ.QuestionID IS NULL
GROUP BY Q.QuestionID;





-- ==> Question 5:
-- ========================
select * from `examquestion`;

-- THỰC HIỆN LẠI REMAKE CÂU LỆNH:
select QUESTIONID, COUNT(QUESTIONID) AS `SL`
FROM `examquestion` 
GROUP BY (QuestionID);

SELECT QUESTIONID, MAX(T.SL)
FROM (select QUESTIONID, COUNT(QUESTIONID) AS `SL`
FROM `examquestion` 
GROUP BY (QuestionID) ) AS T;


-- ĐẾM SỐ LƯỢNG TỪNG QUESTION ID TRONG ĐỀ THI
SELECT QUESTIONID, COUNT(QUESTIONID) AS `SL`

FROM EXAMQUESTION 
GROUP BY (QUESTIONID);

##SO LUONG NHIEU NHAT
-- CÁCH 1:
 SELECT QUESTIONID, MAX(`T`.`SL`) 
 FROM(SELECT QUESTIONID, COUNT(QUESTIONID) AS `SL`

FROM EXAMQUESTION 
GROUP BY (QUESTIONID)) AS `T`;
-- CÁCH 2: ORDER BY:

SELECT QUESTIONID, COUNT(QUESTIONID) AS `SL`
FROM EXAMQUESTION 
GROUP BY (QUESTIONID)
ORDER BY `SL` DESC LIMIT 1;


-- LẤY DANH SÁCH CÂU HỎI ĐƯỢC USE NHIỀU NHẤT:
SELECT QUESTIONID, COUNT(QUESTIONID) AS `SL`
FROM EXAMQUESTION 
GROUP BY (QUESTIONID)
HAVING `SL` =      (SELECT COUNT(QUESTIONID) AS `SL`
					FROM EXAMQUESTION 
					GROUP BY (QUESTIONID) 
					ORDER BY `SL` DESC LIMIT 1);
                    
# KẾT NỐI (JOIN) THÊM CONTENT CỦA CÂU HỎI
SELECT Q.QUESTIONID, COUNT(Q.QUESTIONID) AS `SL`, Q.CONTENT, Q.TYPEID
FROM EXAMQUESTION EQ 
JOIN QUESTION Q 
ON EQ.QUESTIONID = Q.QUESTIONID 
GROUP BY (Q.QUESTIONID)
HAVING `SL` =      (SELECT COUNT(QUESTIONID) AS `SL`
					FROM EXAMQUESTION 
					GROUP BY (QUESTIONID) 
					ORDER BY `SL` DESC LIMIT 1);









## DEPARTMENT COS NHIEU NHAN VIEN NHAT

-- ĐẾM SỐ LƯỢNG TỪNG SO LUONG NV TRONG TUNG PHONG
SELECT DEPARTMENTID, COUNT(DEPARTMENTID) AS `SLNV`

FROM `ACCOUNT` 
GROUP BY (DEPARTMENTID);

##SO LUONG NHAN VIEN NHIEU NHAT


SELECT DEPARTMENTID, COUNT(DEPARTMENTID) AS `SLNV`
FROM `ACCOUNT`
GROUP BY (DEPARTMENTID)
ORDER BY `SLNV` DESC LIMIT 1;


-- LẤY NHAN VIEN NHIỀU NHẤT:
SELECT DEPARTMENTID, COUNT(DEPARTMENTID) AS `SLNV`
FROM `ACCOUNT` 
GROUP BY (DEPARTMENTID)
HAVING `SLNV` =      (SELECT COUNT(DEPARTMENTID) AS `SLNV`
					FROM `ACCOUNT`
					GROUP BY (DEPARTMENTID) 
					ORDER BY `SLNV` DESC LIMIT 1);
## 

SELECT DE.DEPARTMENTID, DE.DEPARTMENTNAME, COUNT(DE.DEPARTMENTID) AS `SLNV`
FROM DEPARTMENT AS DE
JOIN `ACCOUNT` AS ACC
ON  DE.DEPARTMENTID = ACC.DEPARTMENTID
GROUP BY (DE.DEPARTMENTID)
HAVING `SLNV` = (SELECT COUNT(DEPARTMENTID) AS `SLNV`
				  FROM `account`
                  GROUP BY (DepartmentID)
                  order by `SLNV` DESC LIMIT 1);
				
                


SELECT A
FROM `ACCOUNT`;

## 





SELECT DEPARTMENTID, COUNT(DEPARTMENTID) AS `SLNV`
FROM `ACCOUNT` 
GROUP BY (DEPARTMENTID)
HAVING SLNV = (SELECT MAX(`OK`.SLNV)  
				FROM      (SELECT DEPARTMENTID, COUNT(DEPARTMENTID) AS `SLNV`
										FROM `ACCOUNT` 
										GROUP BY (DEPARTMENTID)) AS `OK`);

















-- LONG SẼ ----
SELECT  D.DepartmentName, count(*) AS 'SL' 
FROM `account` AS A 
JOIN `department` AS D 
ON A.DepartmentID = D.DepartmentID 
GROUP BY (A.DepartmentID)
HAVING `SL`=(   SELECT MAX(T.SL) 
				FROM (SELECT `departmentID`, count(*) AS 'SL' 
				FROM `account` GROUP BY `DepartmentID`) AS T
                
			 );

















## OR CACH KHAC:

SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) as maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);

-- nối 3 bảng cùng lúc

SELECT A.`FULLNAME` , A.`DEPARTMENTID` , D.`DEPARTMENTNAME`, 
		A.`POSITIONID`, P.`POSITIONID`
FROM `ACCOUNT` A JOIN `DEPARTMENT` D 
ON A.`DEPARTMENTID` = D.`DEPARTMENTID`
				JOIN  `POSITION` P 
ON A.`POSITIONID` = P.`POSITIONID` ;



-- QUESTION 6 ---
SELECT  Q.CategoryID ,C.CategoryNAME, COUNT(Q.CATEGORYID) AS SOLANXUATHIEN  
FROM QUESTION AS Q 
INNER JOIN categoryquestion AS C
ON Q.CategoryID = C.CategoryID
GROUP BY Q.CategoryID;


# LÀM LẠI 

SELECT Q.CategoryID, CQ.CategoryNAME, COUNT(Q.CategoryID) AS SL
FROM categoryquestion AS CQ
INNER JOIN question AS Q
ON  	Q.CategoryID = CQ.CategoryID
GROUP BY Q.CategoryID;









-- OR ANOTHER WAY:

SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) FROM categoryquestion cq
JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;











# QUESTION 6
# CASCH 1
SELECT CQ.CATEGORYID,CQ.CATEGORYNAME , COUNT(Q.CATEGORYID) AS `SL`
FROM CATEGORYQUESTION AS CQ 
LEFT JOIN `QUESTION` AS Q
ON
CQ.CATEGORYID = Q.CATEGORYID
GROUP BY (CQ.CATEGORYID);



# cACH 2
SELECT CQ.CATEGORYNAME , COUNT(Q.CATEGORYID) AS `SL`
FROM CATEGORYQUESTION AS CQ 
JOIN `QUESTION` AS Q
ON
CQ.CATEGORYID = Q.CATEGORYID
GROUP BY (CQ.CATEGORYID)
UNION
SELECT CQ.CATEGORYNAME , 0
FROM CATEGORYQUESTION AS CQ 
LEFT JOIN `QUESTION` AS Q
ON
CQ.CATEGORYID = Q.CATEGORYID
WHERE Q.CONTENT IS NULL;




############ QUESTION 7###############
######################################
SELECT Q.QuestionID ,q.Content, COUNT(EQ.QuestionID) AS SOLAN
FROM examquestion AS EQ
RIGHT JOIN question AS Q
ON EQ.QuestionID = Q.QuestionID
GROUP BY Q.QuestionID;



############ QUESTION 8 ###############
######################################

## QUESTION COS NHIEEUF CAU TRL NHAT
SELECT Q.QuestionID , COUNT(A.QuestionID) AS SOLAN
FROM question AS Q
JOIN answer AS A
ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING SOLAN = 		(SELECT MAX(T.SOLAN) FROM(  SELECT Q.QuestionID , COUNT(A.QuestionID) AS SOLAN
												FROM question AS Q
												JOIN answer AS A
												ON Q.QuestionID = A.QuestionID
												GROUP BY A.QuestionID) AS T 
);
					
## QUESTION COS NHIỀU CAU TRL ĐÚNG NHAT

SELECT QuestionID, isCorrect, COUNT(isCorrect) AS QTY_CORRECT
FROM `ANSWER` 
GROUP BY QuestionID,isCorrect
HAVING isCorrect ='1'
AND 
QTY_CORRECT = (SELECT MAX(T.QTY_CORRECT)  FROM (SELECT QuestionID, isCorrect, COUNT(isCorrect) AS QTY_CORRECT
												FROM `ANSWER` 
												GROUP BY QuestionID,isCorrect
												HAVING isCorrect ='1') AS T);



### JOIN ĐỂ LẤY THÔNG TIN CONTENT QUESTION 
SELECT Q.QuestionID, Q.Content, COUNT(A.isCorrect) AS QTY_CORRECT
FROM `question` AS Q
JOIN 
	`answer` AS A
ON Q.QuestionID = A.QuestionID
GROUP BY QuestionID,isCorrect
HAVING isCorrect ='1'
AND
QTY_CORRECT = (SELECT MAX(T.QTY_CORRECT)  FROM (	SELECT Q.QuestionID, Q.Content, COUNT(A.isCorrect) AS QTY_CORRECT
													FROM `question` AS Q
													JOIN 
														`answer` AS A
													ON Q.QuestionID = A.QuestionID
													GROUP BY QuestionID,isCorrect
													HAVING isCorrect ='1') AS T);













## LẤY RA THE QUESTIONS WHICH HAVE NOT THE ANSWER:
##################################################			
##################################################			

SELECT Q.QuestionID, COUNT(A.QuestionID) AS SOLAN
FROM
question AS Q
LEFT JOIN
answer AS A 
ON Q.QuestionID = A.QuestionID
GROUP BY Q.QuestionID;




############ QUESTION 9 ###############
######################################

SELECT G.GroupID, G.GroupName,  COUNT(GA.GroupID)
FROM `GROUP` AS G
LEFT JOIN groupaccount AS GA
ON        G.GroupID = GA.GroupID
GROUP BY G.GROUPID;





############ QUESTION 10 ###############
######################################
-- SO LUONG NGUOI THEO TUNG CHUC VU

SELECT *
FROM 	     position AS P
LEFT JOIN 	`account` AS A
ON 			 P.PositionID = A.PositionID

















































