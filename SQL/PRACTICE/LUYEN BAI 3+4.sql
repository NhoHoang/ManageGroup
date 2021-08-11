
DROP DATABASE IF EXISTS `Testing_System_5`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_5`;
/* Lenh su dung Database */
USE `Testing_System_5`;


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
    CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position` (`PositionID`) ON UPDATE CASCADE ON DELETE SET NULL
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
    -- Anh có drop cnstraint ở đây r nhỉalter
    -- Chắc là nó không nhận nối Dep1 với PosNull đâu :v
    -- Vì làm j có PosNull mà nối :))
    -- thế tóm lại h làm j :v 
    -- Kiểm tra count(*) e thường dùng với 1 row không phải FK :))
    -- Lần đầu thử thế này mà cái join với FK lại chặn không cho đi hướng đó r :))
-- ảo thật đấy :v 
-- Do không tồn tại giá trị PostionID Null trong bảng Postion nên không nối đc là đúng r :)
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
     ##
     
     
     
     
     
     -- ASSIGNMENT 3
     #
     # #
     #  # #
     #    # #
     #  # #
     #
   -- QUESTION 3  
SELECT  D.DepartmentID, A.Fullname, D.DepartmentName, A.Email 
FROM `ACCOUNT` AS A
RIGHT JOIN DEPARTMENT AS D
ON   A.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DepartmentName LIKE '%SALE%'
ORDER BY D.DEPARTMENTID;

     -- QUESTION 4  
     
SELECT A.AccountID, A.Fullname, D.DepartmentName, character_length(A.Fullname) AS do_dai
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
ON   A.DEPARTMENTID = D.DEPARTMENTID
WHERE character_length(A.Fullname) =  ( SELECT MAX(`T`.`L`) FROM (  SELECT A.AccountID, A.Fullname, D.DepartmentName, character_length(A.Fullname) AS `L`
												FROM `ACCOUNT` AS A
												JOIN DEPARTMENT AS D
												ON   A.DEPARTMENTID = D.DEPARTMENTID) AS T  );

 -- QUESTION 5
SELECT A.AccountID, A.Fullname, D.DepartmentID ,D.DepartmentName, character_length(A.Fullname) AS BUOI
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
ON   A.DEPARTMENTID = D.DEPARTMENTID
WHERE character_length(A.Fullname) =  ( SELECT MAX(`T`.`L`) FROM (  SELECT A.AccountID, A.Fullname, D.DepartmentName, character_length(A.Fullname) AS `L`
												FROM `ACCOUNT` AS A
												JOIN DEPARTMENT AS D
												ON   A.DEPARTMENTID = D.DEPARTMENTID) AS T  )
AND D.DepartmenTID ='3';									
                                                
                                                
                                                
 -- QUESTION 7
SELECT Q.QuestionID, Q.Content, COUNT(A.QuestionID) AS SL
FROM `ANSWER` AS A
JOIN `QUESTION` AS Q
ON A.QUESTIONID = Q.QUESTIONID
GROUP BY A.QuestionID
HAVING COUNT(A.QuestionID) >'3';



 -- QUESTION 8
 SELECT * FROM testing_system_5.exam

WHERE Duration >= '60'
AND CreateDate < '2021-08-09';

 -- QUESTION 9
 
 SELECT * FROM testing_system_5.group

order by CreateDate desc limit 2;

 -- QUESTION 10
 # SỐ NHÂN VIÊN THEO TỪNG PHÒNG
 SELECT D.DepartmentID , D.DepartmentName, A.Fullname, COUNT(A.DepartmentID)
 FROM DEPARTMENT AS D
 LEFT JOIN `ACCOUNT`  AS A
 ON
 D.DEPARTMENTID = A.DEPARTMENTID
 group by D.DEPARTMENTID;
 
# SỐ NHÂN VIÊN CỦA PHÒNG CÓ ID=2

SELECT D.DepartmentID , D.DepartmentName, A.Fullname, COUNT(A.DepartmentID) AS SL
 FROM DEPARTMENT AS D
 JOIN `ACCOUNT`  AS A
 ON
 D.DEPARTMENTID = A.DEPARTMENTID
 WHERE A.DepartmentID ='2';



 -- QUESTION 11
	#
     delete from `exam`
where examid='1';
	

alter TABLE `EXAM`
CHANGE CREATORID CREATOO INT;

UPDATE `EXAM`
SET CREATOO = '3'
WHERE EXAMID = '2';
    
   -- QUESTION 14
   
   UPDATE `ACCOUNT`
SET FULLNAME = 'SUATEN',
	EMAIL = 'AAAAAAAAAAAAA'
	WHERE ACCOUNTID ='5';
    
    
    ### ASSIGMENT 4
    
    
    
-- QUESTION 1


SELECT *
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
ON  D.DEPARTMENTID = A.DEPARTMENTID;


    
-- QUESTION 2
SELECT A.AccountID, A.Email, A.Fullname, A.DepartmentID, D.DepartmentName, A.CreateDate
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
ON  D.DEPARTMENTID = A.DEPARTMENTID
WHERE A.CreateDate > '2020-07-01'
GROUP BY ACCOUNTID;

-- QUESTION 3

SELECT   A.Fullname, A.Email, A.DepartmentID, P.PositionName
FROM `ACCOUNT` AS A
JOIN POSITION AS P
ON  P.POSITIONID = A.POSITIONID
WHERE P.PositionName LIKE '%dev%';

-- QUESTION 4
SELECT  D.DepartmentID, D.DepartmentName, COUNT(A.DepartmentID) AS SL_NV
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
ON  D.DEPARTMENTID = A.DEPARTMENTID
GROUP BY A.DepartmentID
HAVING sl_nv = ( SELECT MAX(T.SL_NV) FROM (SELECT  D.DepartmentID, D.DepartmentName, COUNT(A.DepartmentID) AS SL_NV
													FROM `ACCOUNT` AS A
													JOIN DEPARTMENT AS D
													ON  D.DEPARTMENTID = A.DEPARTMENTID
													GROUP BY A.DepartmentID) AS T         
                                                    
								);


-- QUESTION 5
SELECT Q.QuestionID ,Q.Content, COUNT(EQ.QuestionID) AS SL
FROM EXAMQUESTION AS EQ
JOIN QUESTION 	  AS Q
ON   EQ.QuestionID = Q.QuestionID
GROUP BY EQ.QuestionID
HAVING 
COUNT(EQ.QuestionID)  = (SELECT    MAX(T.SL)  FROM( SELECT Q.QuestionID ,Q.Content, COUNT(EQ.QuestionID) AS SL
													FROM EXAMQUESTION AS EQ
													JOIN QUESTION 	  AS Q
													ON   EQ.QuestionID = Q.QuestionID
													GROUP BY EQ.QuestionID) AS T  );


-- QUESTION 7
SELECT Q.QuestionID, Q.Content, COUNT(EQ.QuestionID) AS SL
FROM EXAMQUESTION AS EQ
RIGHT JOIN QUESTION 	  AS Q
ON   EQ.QuestionID = Q.QuestionID
GROUP BY EQ.QuestionID;

-- QUESTION 9

SELECT  G.GroupID, G.GroupName, COUNT(GA.GROUPID) AS SL
FROM `GROUPACCOUNT` AS GA
JOIN `ACCOUNT`  AS A
ON GA.AccountID = A.AccountID
JOIN `GROUP` AS G
ON GA.GroupID = G.GroupID
GROUP BY GA.GROUPID ;

-- QUESTION 10

SELECT P.PositionID, P.PositionName, COUNT(A.PositionID) AS S_LUONG
FROM 		`POSITION` AS P
LEFT JOIN   `ACCOUNT`  AS A
ON 			A.positionID = P.positionID
GROUP BY (A.PositionID)
HAVING   S_LUONG = (       
						SELECT MAX(T.SL)   FROM(SELECT P.PositionID, P.PositionName, COUNT(A.PositionID) AS SL
												FROM 		`POSITION` AS P
												LEFT JOIN   `ACCOUNT`  AS A
												ON 			A.positionID = P.positionID
												GROUP BY (A.PositionID))  AS T         

			  );


-- QUESTION 11

SELECT D.DepartmentID, D.DepartmentName AS TENPHONG , A.PositionID, P.positionNAME AS VITRI, COUNT(A.positionID) AS SL_NGUOI
FROM `DEPARTMENT` 	AS D
LEFT JOIN `ACCOUNT` AS A
ON 		  			   D.departmentID = A.departmentID
LEFT JOIN `POSITION` AS P
ON                     A.positionID   = P.positionID
GROUP BY D.departmentID, A.positionID
order by D.departmentID;



-- QUESTION 12
SELECT Q.QuestionID, Q.Content,  A.Content, CQ.CategoryName, TQ.TypeName, Q.CreatorID, AC.Username,AC.Fullname
FROM 
	 `question` 			AS Q
JOIN `ANSWER`   			AS A
ON 			     		Q.QuestionID = A.QuestionID

JOIN `categoryquestion` 	AS CQ
ON						Q.CategoryID = CQ.CategoryID

JOIN `typequestion` 		AS TQ
ON 						Q.TypeID = TQ.TypeID

JOIN `account`			AS AC
ON 						Q.CreatorID = AC.AccountID
ORDER BY Q.QuestionID;



-- QUESTION 13

SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID)
FROM question AS Q
JOIN typequestion AS TQ
ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

-- QUESTION 14

SELECT G.GroupID, G.GroupName, GA.AccountID
FROM `group` AS G
LEFT JOIN groupaccount AS GA
ON G.GroupID = GA.GroupID
WHERE GA.AccountID IS NULL;



-- QUESTION 15

SELECT 
    *
FROM
    testing_system_5.group AS G
WHERE
    G.GroupID NOT IN (SELECT 
            GroupID
        FROM
            groupaccount);


-- QUESTION 16
select *
from question as q
left join answer as a
on q.QuestionID =a.QuestionID;

SELECT q.QuestionID FROM answer a
RIGHT JOIN question q on a.QuestionID = q.QuestionID
WHERE a.QuestionID IS NULL;



-- QUESTION 17
select GA.AccountID, G.GroupName
FROM `GROUP` AS G
JOIN groupaccount AS GA
ON G.GroupID = GA.GroupID
WHERE GA.GroupID = '1'



UNION


select GA.AccountID, G.GroupName
FROM `GROUP` AS G
JOIN groupaccount AS GA
ON G.GroupID = GA.GroupID
WHERE GA.GroupID = '5';


-- QUESTION 18

SELECT GA.GroupID, COUNT(GA.GroupID) AS SLNV
FROM groupaccount AS GA
JOIN `account` AS A
ON GA.AccountID = A.AccountID
GROUP BY GA.GroupID
HAVING SLNV > '3';


SELECT  G.GroupID, G.GroupName, COUNT(GA.ACCOUNTID) AS SL
FROM `GROUPACCOUNT` AS GA
JOIN `ACCOUNT`  AS A
ON GA.AccountID = A.AccountID
JOIN `GROUP` AS G
ON GA.GroupID = G.GroupID
GROUP BY GA.GROUPID ;




SELECT * FROM testing_system_5.account;

DROP VIEW IF EXISTS  `V_ACCOUNT_SALE`;

CREATE VIEW `V_ACCOUNT_SALE` AS
SELECT A.*, DEPARTMENTNAME, POSITIONNAME
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
USING (DEPARTMENTID)
JOIN POSITION AS P
USING (POSITIONID)
WHERE DEPARTMENTNAME LIKE'%SALE%';





# buoi 5
WITH CTE_ACCOUNT AS 
(
SELECT A.*, DEPARTMENTNAME, POSITIONNAME
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
ON  A.DEPARTMENTID=D.departmentID
JOIN POSITION AS P
ON A.POSITIONID=P.positionID
) 
SELECT * FROM CTE_ACCOUNT;
SELECT departmentNAME FROM CTE_ACCOUNT;





