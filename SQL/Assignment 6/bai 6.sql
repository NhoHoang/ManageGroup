
DROP DATABASE IF EXISTS `Testing_System_test5`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_test5`;
/* Lenh su dung Database */
USE `Testing_System_test5`;


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
    CONSTRAINT fk_eq1 FOREIGN KEY (ExamID) REFERENCES Exam (ExamID) ON UPDATE CASCADE ON DELETE cascade,
    CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID) ON UPDATE CASCADE ON DELETE cascade
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
ALTER TABLE `Account` DROP CONSTRAINT `fk_dp_id`, DROP CONSTRAINT `fk_ps_id`;
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
VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-07-01'),
       ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       ('Câu hỏi JAVA 1', 1, 1, 10, '2021-04-01'),
       ('Câu hỏi JAVA1 2', 1, 2, 5, '2021-06-01'),
       ('Câu hỏi JAVA2 2', 1, 2, 5, '2021-01-01'),
       ('Câu hỏi JAVA3 2', 1, 2, 5, '2021-05-01'),
       ('Câu hỏi JAVA4 2', 1, 2, 5, '2021-06-01'),
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
       ('MS_02', 'De thi 02', 1, 60, 5, '2015-08-14 16:11:48'),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, '2015-08-14 16:11:48'),
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
       (2, 3),
       (2, 3),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4);
     ##
     
     
     
     
     
     
     
     
     
     
     
     
 ##    
SET GLOBAL log_bin_trust_function_creators = 1;
## QUESTION 1:

DROP PROCEDURE IF EXISTS get_accountid_from_deptID;
DELIMITER $$
CREATE PROCEDURE get_accountid_from_deptID 
(IN deptID TINYINT UNSIGNED)
BEGIN
SELECT DEPARTMENTID, AccountID
FROM `ACCOUNT` AS A
WHERE deptID = DepartmentID;
END$$
DELIMITER ;

CALL get_accountid_from_deptID(1);













## QUESTION 2:
DROP PROCEDURE IF EXISTS get_acc_of_group;
DELIMITER $$
CREATE PROCEDURE get_acc_of_group ()
BEGIN
		SELECT G.GroupID, G.GroupName, COUNT(GA.GroupID) AS SL_ACCOUNT
		FROM `GROUP` AS G
		LEFT JOIN `GROUPACCOUNT` AS GA
		ON G.GroupID = GA.GroupID
		GROUP BY (G.GroupID);
END$$
DELIMITER ;

CALL get_acc_of_group();







## QUESTION 3:

DROP PROCEDURE IF EXISTS QUESTION_QTY_FROM_TYPE_QUESTION_InThiMonth;
DELIMITER $$
CREATE PROCEDURE QUESTION_QTY_FROM_TYPE_QUESTION_InThiMonth()
BEGIN
SELECT TypeID, COUNT(TypeID) AS SL, MONTH(CreateDate) AS CreateMonth_in_2021
FROM `QUESTION` AS Q
WHERE 	MONTH(CreateDate) = MONTH(NOW())
AND 	YEAR(CreateDate) = YEAR(NOW())
GROUP BY (TypeID);
END$$
DELIMITER ;

CALL QUESTION_QTY_FROM_TYPE_QUESTION_InThiMonth ();













## QUESTION 4:
DROP PROCEDURE IF EXISTS MAX_QUES_BY_TYPE;
DELIMITER $$
CREATE PROCEDURE MAX_QUES_BY_TYPE( OUT out_of_typeID TINYINT)
BEGIN
		SELECT TQ.TypeID INTO out_of_typeID
		FROM `QUESTION` AS Q
		JOIN `TYPEQUESTION` AS TQ
		USING (TYPEID)
		GROUP BY (TQ.TYPEID)
		HAVING  COUNT(TYPEID) = (SELECT MAX(T.SL) FROM (SELECT TYPEID, COUNT(TYPEID) AS SL
											FROM `QUESTION`
											GROUP BY (TYPEID)) AS T                   
			);
END$$
DELIMITER ;

CALL MAX_QUES_BY_TYPE(@ID4);
SELECT @ID4;


## khai báo 2 biến count và name , tách 2 declare thành 2 biến riêng 2 ;
DROP PROCEDURE IF EXISTS MAX_QUES_BY_TYPE;
DELIMITER $$
CREATE PROCEDURE MAX_QUES_BY_TYPE( OUT out_of_typeID TINYINT)
BEGIN
		DECLARE COUNTQ4 VARCHAR(50);
			DECLARE	NAMEQ4  VARCHAR(50);
		SELECT TQ.TypeID, TQ.TypeName , COUNT(Q.TYPEID) AS SL INTO out_of_typeID, NAMEQ4, COUNTQ4
		FROM `QUESTION` AS Q
		JOIN `TYPEQUESTION` AS TQ
		USING (TYPEID)
		GROUP BY (TQ.TYPEID)
		HAVING  SL = (SELECT MAX(T.SL) FROM (SELECT TYPEID, COUNT(TYPEID) AS SL
											FROM `QUESTION`
											GROUP BY (TYPEID)) AS T                   
			);
END$$
DELIMITER ;





## QUESTION 5:
SELECT * FROM TYPEQUESTION
WHERE TYPEID = @ID4;















##QUESTION 6:

DROP PROCEDURE IF EXISTS STRING_TO_GOUP_OR_USERNAME;
DELIMITER $$
CREATE PROCEDURE STRING_TO_GOUP_OR_USERNAME (IN `INPUT` VARCHAR(50))
BEGIN
SELECT  USERNAME 
FROM `ACCOUNT` 	AS A
WHERE A.USERNAME LIKE concat('%',INPUT,'%')
UNION 
SELECT GROUPNAME 
FROM  `GROUP`	AS G
WHERE G.GROUPNAME LIKE concat('%',INPUT,'%');
END$$
DELIMITER ;

CALL STRING_TO_GOUP_OR_USERNAME('nhom 1');










##QUESTION 7:
SELECT * FROM `ACCOUNT`;

DROP PROCEDURE IF EXISTS QUESTION7;
DELIMITER $$
CREATE PROCEDURE QUESTION7 (
							 IN_EMAIL    VARCHAR(50),
                             IN_FULLNAME VARCHAR(50))
BEGIN
DECLARE V_USERNAME VARCHAR(50) DEFAULT SUBSTRING_INDEX(IN_EMAIL,"@",1);
DECLARE v_POSITIONID TINYINT UNSIGNED DEFAULT 1 OR 2;
DECLARE V_DEPARTMENTID TINYINT UNSIGNED DEFAULT NULL;

INSERT INTO  `ACCOUNT` (Email, 		USERname,	 FULLNAME,	   DepartmentID,	PositionID)
				VALUE  (IN_EMAIL,  V_USERNAME,  IN_FULLNAME,  V_DEPARTMENTID,  v_POSITIONID);

SELECT USERNAME, POSITIONID , DEPARTMENTID
FROM `ACCOUNT` 
WHERE AccountID = (SELECT MAX(AccountID) FROM `ACCOUNT`);
END$$                             
DELIMITER ;

CALL QUESTION7 ('ANHEM4@GMAIL.COM','NGUYEN VAN ANH EM4');











## QUESTION 8:
SELECT * FROM testing_system_test5.question;

WITH CTE_MAXCONTENT1 AS
(
SELECT TQ.TYPENAME, Q.Content, TYPEID, character_length(Q.Content) AS DODAI
FROM `QUESTION` AS Q
JOIN typequestion AS TQ
USING (TYPEID)
WHERE Q.TYPEID = 1
ORDER BY (character_length(Q.Content)) DESC LIMIT 1)
SELECT * FROM CTE_MAXCONTENT1;

WITH CTE_MAXCONTENT2 AS
(
SELECT TQ.TYPENAME, Q.Content, TYPEID, character_length(Q.Content) AS DODAI
FROM `QUESTION` AS Q
JOIN typequestion AS TQ
USING (TYPEID)
WHERE Q.TYPEID = 2
ORDER BY (character_length(Q.Content)) DESC LIMIT 1)
SELECT * FROM CTE_MAXCONTENT2;

DROP PROCEDURE IF EXISTS QUESTION8 ;
DELIMITER $$
CREATE PROCEDURE QUESTION8 ( IN_TYPENAME VARCHAR(50))
BEGIN
SELECT * FROM CTE_MAXCONTENT1
WHERE 
IN_TYPENAME = 'MULTIPLE-CHOICE'

UNION 

SELECT * FROM CTE_MAXCONTENT2
WHERE 
IN_TYPENAME = 'ESSAY';

END$$
DELIMITER ;

CALL QUESTION8 ('ESSAY');
CALL QUESTION8 ('MULTIPLE-CHOICE');

## NGOAI LE TAO FUNCTION:
DROP FUNCTION IF EXISTS QUESTION8;
DELIMITER $$
CREATE FUNCTION QUESTION8 ( IN_TYPEID TINYINT UNSIGNED )
RETURNS VARCHAR(50)
BEGIN
DECLARE OUT_DODAI VARCHAR(50);

SELECT character_length(Q.Content) INTO OUT_DODAI
FROM `QUESTION` AS Q
JOIN typequestion AS TQ
USING (TYPEID)
WHERE Q.TYPEID = IN_TYPEID
ORDER BY (character_length(Q.Content)) DESC LIMIT 1;
RETURN OUT_DODAI;
END$$
DELIMITER ;
SELECT QUESTION8(2);













## QUESTION 9:
DROP PROCEDURE IF EXISTS QUESTION9;
DELIMITER $$
CREATE PROCEDURE QUESTION9 (IN IN_TYPEID TINYINT UNSIGNED)
BEGIN
DELETE FROM `EXAM`
WHERE EXAMID = IN_TYPEID 
ORDER BY(ExamID);
END$$
DELIMITER ;

CALL QUESTION9();











## QUESTION 10:

DROP PROCEDURE IF EXISTS QUESTION10;
DELIMITER $$
CREATE PROCEDURE QUESTION10()
BEGIN
DECLARE i tinyint unsigned  DEFAULT 1; 
DECLARE v_DEM1 tinyint;
DECLARE v_DEM2 tinyint;
DECLARE v_print_Del_info_Exam VARCHAR(50);
DECLARE v_IDReal tinyint;

## TẠO 1 BẢNG ẢO ĐỂ LẤY TỪNG GIÁ TRỊ TYPEID TÌM ĐƯỢC:
DROP TABLE IF EXISTS bang_ao;
create table IF NOT EXISTS bang_ao     (
										id_AO 	 tinyint PRIMARY KEY auto_increment,
										id_chuan tinyint );

## CHÈN TYPEID TÌM ĐƯỢC VÀO BẢNG ẢO
INSERT INTO bang_ao (`ID_CHUAN`)
SELECT ExamID FROM `EXAM`
WHERE YEAR(NOW()) - YEAR(CreateDate) > 3;
-- SELECT * FROM BANG_AO;

SELECT COUNT(*) INTO V_DEM1
FROM bang_ao;

SELECT count(ExamID) into V_DEM2 from `examquestion`
where ExamID IN (select ID_CHUAN from bang_ao) ;

WHILE (i<=V_DEM1) DO
	SELECT ID_CHUAN INTO v_IDReal
    FROM bang_ao
	WHERE ID_AO = i;
	CALL QUESTION9(v_IDReal);
	SET i=i+1;
END WHILE;
DROP TABLE IF EXISTS bang_ao;
## in câu lệnh xóa:
SELECT CONCAT("Deleted ",V_DEM1," Row(s) in Exam ", "and ",V_DEM2 ," Row(s) in ExamQuestion") as Result;

END$$
DELIMITER ;

BEGIN WORK;

CALL QUESTION10();
ROLLBACK;

## JUST FOR REFERENCE:
SELECT ExamID FROM `EXAM`
WHERE YEAR(NOW()) - YEAR(CreateDate) > 3;






## QUESTION 11:
DROP PROCEDURE IF EXISTS QUESTION11;
DELIMITER $$
CREATE PROCEDURE `QUESTION11` ( IN_DeptName varchar(50))
BEGIN
DECLARE V_DEPT_ID TINYINT UNSIGNED;
DECLARE V_DEPT_NAME VARCHAR(50);

SELECT DepartmentID INTO V_DEPT_ID 
FROM DEPARTMENT
WHERE IN_DeptName = DepartmentName;

UPDATE `ACCOUNT` AS A
SET A.DepartmentID = '9'
WHERE A.DepartmentID = V_DEPT_ID;

DELETE FROM `DEPARTMENT` 
WHERE IN_DeptName = DepartmentName;

SELECT A.ACCOUNTID , A.Username , A. Fullname, D.DEPARTMENTNAME
FROM `ACCOUNT` AS A
RIGHT JOIN 
DEPARTMENT AS D
USING (DEPARTMENTID)
where DepartmentID = '9';
END$$
DELIMITER ;

CALL QUESTION11('Phong Ky Thuat 1');











##question 12:

DROP PROCEDURE IF EXISTS QUESTION12;
DELIMITER $$
CREATE PROCEDURE QUESTION12 ()
BEGIN
DROP TABLE IF EXISTS TEMPORARY_TABLE;
CREATE TABLE TEMPORARY_TABLE (
								`MONTH` TINYINT PRIMARY KEY AUTO_INCREMENT,
								`CREATEDATE`DATETIME );
INSERT INTO   TEMPORARY_TABLE 
							 (CREATEDATE)
VALUE                        ('2021-01-01'),     
							 ('2021-02-01'),
							 ('2021-03-01'),
							 ('2021-04-01'),
							 ('2021-05-01'),
							 ('2021-06-01'),
							 ('2021-07-01'),
							 ('2021-08-01'),
							 ('2021-09-01'),
							 ('2021-10-01'),
							 ('2021-11-01'),
							 ('2021-12-01');
-- SELECT * FROM   TEMPORARY_TABLE        

SELECT   TT.`MONTH`, COUNT(Q.CreateDate) AS SL_QUES
FROM 
QUESTION 		AS Q
RIGHT JOIN  
TEMPORARY_TABLE AS TT   
ON MONTH(Q.CREATEDATE) = (TT.`MONTH`)
AND YEAR(Q.CREATEDATE) = YEAR (NOW())
GROUP BY MONTH(TT.`CreateDate`);              
DROP TABLE IF EXISTS TEMPORARY_TABLE;
END$$
DELIMITER ;

CALL QUESTION12();





## HOAWJC CACH KHAC
DROP TABLE IF EXISTS TEMPORARY_TABLE2;
CREATE TABLE TEMPORARY_TABLE2 (
								`MONTH_TEMPO` TINYINT PRIMARY KEY AUTO_INCREMENT,
								`CREATEDATE`DATETIME );
INSERT INTO   TEMPORARY_TABLE2 
							 (CREATEDATE)
VALUE                        ('2021-01-01'),     
							 ('2021-02-01'),
							 ('2021-03-01'),
							 ('2021-04-01'),
							 ('2021-05-01'),
							 ('2021-06-01'),
							 ('2021-07-01'),
							 ('2021-08-01'),
							 ('2021-09-01'),
							 ('2021-10-01'),
							 ('2021-11-01'),
							 ('2021-12-01');
DROP VIEW IF EXISTS TEMPO_TABLE1;
CREATE VIEW TEMPO_TABLE1 AS
SELECT MONTH(CreateDate) AS `MONTH_Q` , COUNT(CreateDate) AS SL_CAUHOI
FROM `QUESTION` AS Q
WHERE 
YEAR(CreateDate) = YEAR(NOW())
GROUP BY (MONTH(CreateDate));


SELECT TT2.MONTH_TEMPO, TT1.SL_CAUHOI
FROM TEMPO_TABLE1 AS TT1
JOIN TEMPORARY_TABLE2 AS TT2
ON TT2.MONTH_TEMPO = TT1.MONTH_Q

UNION

SELECT TT2.MONTH_TEMPO, 0
FROM TEMPO_TABLE1 AS TT1
RIGHT JOIN TEMPORARY_TABLE2 AS TT2
ON TT2.MONTH_TEMPO = TT1.MONTH_Q
WHERE TT1.SL_CAUHOI IS NULL;













##QUESTION 13:

DROP PROCEDURE IF EXISTS QUESTION13;
DELIMITER $$
CREATE PROCEDURE QUESTION13 ()
BEGIN
DROP TABLE IF EXISTS TEMPORARY_TABLE;
CREATE TABLE TEMPORARY_TABLE (
								`MONTH` TINYINT PRIMARY KEY AUTO_INCREMENT,
								`CREATEDATE`DATETIME );
INSERT INTO   TEMPORARY_TABLE 
							 (CREATEDATE)
VALUE                        ('2021-01-01'),     
							 ('2021-02-01'),
							 ('2021-03-01'),
							 ('2021-04-01'),
							 ('2021-05-01'),
							 ('2021-06-01'),
							 ('2021-07-01'),
							 ('2021-08-01'),
							 ('2021-09-01'),
							 ('2021-10-01'),
							 ('2021-11-01'),
							 ('2021-12-01');
-- SELECT * FROM   TEMPORARY_TABLE        

SELECT   TT.`MONTH`, COUNT(Q.CreateDate) AS SL_QUES
FROM 
QUESTION 		AS Q
RIGHT JOIN  
TEMPORARY_TABLE AS TT   
ON MONTH(Q.CREATEDATE) = (TT.`MONTH`)
AND (Q.CREATEDATE) >=  date_sub(now(),interval 6 month )
GROUP BY MONTH(TT.`CreateDate`);              
DROP TABLE IF EXISTS TEMPORARY_TABLE;

END$$
DELIMITER ;

CALL QUESTION13();







SELECT DATEDIFF( '2021-12-01', NOW()) <=6;
							



























## 
## 
## ############################################
##################################################
## tHAM KHẢO


DROP FUNCTION IF EXISTS GET_DEPTNAME_FROM_DEPTID;

DELIMITER $$
CREATE FUNCTION GET_DEPTNAME_FROM_DEPTID (IN_DEPARTMENTID TINYINT unsigned)
RETURNS VARCHAR(50)
BEGIN
DECLARE V_DEPARTMENTNAME  VARCHAR(50);
SELECT 
    DEPARTMENTNAME
INTO V_DEPARTMENTNAME FROM
    DEPARTMENT
WHERE
    DEPARTMENTID = IN_DEPARTMENTID;
    RETURN V_DEPARTMENTNAME;
END$$
DELIMITER ;

SELECT GET_DEPTNAME_FROM_DEPTID(2);




     ## CÓ THỂ CHÈN NHIỀU PARAMETER VÀO ĐIỀU KIỆN 
##     
  DELIMITER $$
CREATE FUNCTION FROM_ID_TO_NAME (IN_ACCOUNTID MEDIUMINT UNSIGNED)
RETURNS VARCHAR(50)

BEGIN
DECLARE v_FULLNAME VARCHAR(50);
SELECT FULLNAME INTO v_FULLNAME
FROM `ACCOUNT`
WHERE IN_ACCOUNTID = ACCOUNTID;
RETURN v_FULLNAME;
END$$
DELIMITER ;


SELECT FROM_ID_TO_NAME(2);
SELECT FULLNAME
FROM `ACCOUNT`
WHERE ACCOUNTID = '1';   
     
     
     
	##
    
DELIMITER $$
CREATE PROCEDURE GET_NAME_DEPT ()
BEGIN


## GỌI 1 PHÁT 3 CÂU LỆNH
SELECT *
FROM `ACCOUNT`;
SELECT *
FROM `DEPARTMENT`;
SELECT *
FROM `GROUPACCOUNT`;

END$$
DELIMITER ;
     
     
## TRUYỀN THAM SỐ: PROCEDURE
DELIMITER $$
CREATE PROCEDURE GET_NAME_DEPT1 (IN DEPARTMENT_ID TINYINT UNSIGNED)
BEGIN


SELECT DEPARTMENTNAME
FROM `DEPARTMENT`
WHERE DEPARTMENTID = DEPARTMENT_ID;

END$$
DELIMITER ;
     
CALL     GET_NAME_DEPT1(2); 
     
     
     
## QUESTION 1:

DROP PROCEDURE GET_ACCOUNT_BY_DEPTNAME;
DELIMITER $$
CREATE PROCEDURE GET_ACCOUNT_BY_DEPTNAME 
(IN DEPT_NAME VARCHAR(50))
BEGIN

SELECT A.AccountID
FROM `ACCOUNT` AS A
JOIN DEPARTMENT AS D
USING (DEPARTMENTID)
WHERE D.DepartmentName LIKE DEPT_NAME ;

END$$
DELIMITER ;
CALL GET_ACCOUNT_BY_DEPTNAME ('%DEV%'); 



## QUESTION 2

SELECT *-- G.GroupID, COUNT(GA.GroupID)
FROM `ACCOUNT` AS A
JOIN GROUPACCOUNT AS GA
USING (ACCOUNTID)
RIGHT JOIN `GROUP` AS G
USING (GROUPID)
GROUP BY (GA.GroupID);




DROP PROCEDURE spGETDEPTID;
DELIMITER $$
CREATE PROCEDURE spGETDEPTID  
(	IN 	DEPT_NAME VARCHAR(50),
	OUT DEPT_ID_OUT INT)
BEGIN

SELECT DEPARTMENTID INTO DEPT_ID_OUT
FROM DEPARTMENT
WHERE DepartmentNAME LIKE DEPT_NAME ;

END$$
DELIMITER ;
     
     ## OUTPUT:
     
 CALL spGETDEPTID('%KY THUAT 1%' , @IDOUT);
 
 SELECT * FROM `ACCOUNT` WHERE DEPARTMENTID = @IDOUT;
 SELECT 
    *
FROM
    `DEPARTMENT`
WHERE
    DEPARTMENTID = @IDOUT;
     
     
     
     ## QUESTION 4
     
     DELIMITER $$
     CREATE PROCEDURE QUESTION4 
     ( OUT TYPEQUES_ID INT )
     BEGIN
     
	SELECT TQ.TypeID INTO TYPEQUES_ID
	FROM `QUESTION` AS Q
	JOIN TYPEQUESTION AS TQ
	USING (TypeID)
	GROUP BY (Q.TypeID)
	HAVING   COUNT(Q.TypeID) = (SELECT MAX(SL) FROM (SELECT COUNT(TypeID) AS SL
													FROM `QUESTION` 
													GROUP BY (TypeID)) AS T);

     END$$
     DELIMITER ;
     set @OUT_OF_TYPE = 0;
 CALL     QUESTION4(@OUT_OF_TYPE);
 
 SELECT @OUT_OF_TYPE;
 
 
 

-- #####################################################################
-- #####################################################################
-- #####################################################################
     
     
     DROP PROCEDURE IF EXISTS spGetDepartmentID;
DELIMITER $$
	CREATE PROCEDURE spGetDepartmentID (IN department_Name VARCHAR(50), OUT departmentIdOut INT, OUT deparmentNameOut VARCHAR(50))
		BEGIN
			## tap hop cac cau lenh cua procedure
			SELECT DepartmentID , DepartmentName INTO departmentIdOut, deparmentNameOut 
            FROM Department WHERE DepartmentName LIKE department_Name;
        END $$
DELIMITER ;

CALL spGetDepartmentID('%Sale%', @idDp, @nameDp);
set @idDp =0;
select @idDp;

SELECT * FROM Department WHERE DepartmentID = @idDp;

SELECT fGetDepartmentID('%Sale%');

SELECT * FROM Department WHERE DepartmentID = (SELECT fGetDepartmentID('%Sale%'));







SET GLOBAL log_bin_trust_function_creators = 1;
## Function
DROP FUNCTION IF EXISTS fGetDepartmentID;
DELIMITER $$
	CREATE FUNCTION fGetDepartmentID (department_Name VARCHAR(50)) 
    RETURNS INT
		BEGIN
			DECLARE idDepartmentSelected INT; 
			## tap hop cac cau lenh cua function
			SELECT DepartmentID INTO idDepartmentSelected
            FROM Department WHERE DepartmentName LIKE department_Name;

			RETURN idDepartmentSelected;
        END $$
DELIMITER ;

select fGetDepartmentID('Phong Dev 1');

DROP FUNCTION IF EXISTS fGetDepartmentID;
DELIMITER $$
	CREATE FUNCTION fGetDepartmentID (department_Name VARCHAR(50)) RETURNS INT
		BEGIN
			DECLARE idDepartmentSelected INT; 
			## tap hop cac cau lenh cua function
			SELECT DepartmentID INTO idDepartmentSelected
            FROM Department WHERE DepartmentName LIKE department_Name;

			RETURN idDepartmentSelected;
            SELECT * FROM `ACCOUNT` 
            WHERE ACCOUNTID = idDepartmentSelected;
        END $$
DELIMITER ;

     
     
     
     DELIMITER $$
	CREATE TRIGGER trigger_delete_department
	BEFORE DELETE ON Department
    FOR EACH ROW
    BEGIN
		DELETE FROM `ACCOUNT` WHERE DepartmentID IN (OLD.DepartmentID);
    END $$
DELIMITER ;

SELECT accountid, departmentid FROM `Account` WHERE DepartmentID = 1
UNION
SELECT * FROM `Department` WHERE DepartmentID = 1;

begin work;
	DELETE from `Department` ;
rollback;
    
    
    
 select * from `account`;   
    
    
    
    
    
    
    
    
    
    
    
    
    WITH CTE_QUES8_1 AS
(
SELECT TypeID, CHARACTER_LENGTH(Content) AS DODAI
FROM question
where 
TypeID = 1
)
SELECT * FROM CTE_QUES8_1;
WITH CTE_QUES8_2 AS
(
SELECT TypeID, CHARACTER_LENGTH(Content) AS DODAI
FROM question
where 
TypeID = 2
)
SELECT * FROM CTE_QUES8_2;
   DROP PROCEDURE IF EXISTS QUES_LENGTH_MAX;
   DELIMITER $$
   CREATE PROCEDURE QUES_LENGTH_MAX ( IN_TYPENAME VARCHAR(50))
   BEGIN
		    DECLARE V_TYPENAME VARCHAR(50);
			SELECT TypeID 
            FROM `TYPEQUESTION`
            WHERE V_TYPENAME = TypeName;
        IF     
   END$$
   DELIMITER ;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     