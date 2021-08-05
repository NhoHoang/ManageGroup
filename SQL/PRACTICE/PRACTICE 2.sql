DROP DATABASE IF EXISTS `Fresher_Training_Management`;
CREATE DATABASE IF NOT EXISTS `Fresher_Training_Management`;
USE `Fresher_Training_Management`;


CREATE TABLE IF NOT EXISTS `Trainee`(
	`TraineeID` 	 	TINYINT UNSIGNED AUTO_INCREMENT,
	`Full_name` 		varchar(50) NOT NULL,
	`Birth_date` 		varchar(50) NOT NULL,
    `Gender` 			ENUM('MALE', "FEMALE","UNKNOWN"),
    `ET_IQ` 			TINYINT UNSIGNED CHECK(ET_IQ>0 AND ET_IQ<20),
     PRIMARY KEY (TraineeID)
);

ALTER TABLE `Trainee` 
ADD COLUMN `VTI_Account` VARCHAR(50) NOT NULL UNIQUE KEY 

