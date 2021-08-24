
DROP DATABASE IF EXISTS `Testing_System_test8`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_test8`;
/* Lenh su dung Database */
USE `Testing_System_test8`;

DROP TABLE IF EXISTS `ORDER_TABLE`;
/* Len tao bang va cac cot du lieu cua bang--*/
CREATE TABLE `ORDER_TABLE`
(
    `customer_name`  VARCHAR(50) ,
    `merchandise_number` VARCHAR(50)
);

DROP TABLE IF EXISTS `merchandise_table`;
/* Len tao bang va cac cot du lieu cua bang--*/
CREATE TABLE `merchandise_table`
(
    `merchandise_number`  VARCHAR(50) ,
    `merchandise_NAME` VARCHAR(50),
    `unit_price` VARCHAR(50)
    );


INSERT INTO `order_table` 
VALUES ('OyamaShoten' , 'TV28'),
       ('OyamaShoten' , 'TV28W'),
       ('OyamaShoten' , 'TV32'),
       ('Oyama Shokai' , 'TV32'),
       ('Oyama Shokai' , 'TV32W');
       
       
     

INSERT INTO `merchandise_table` 
VALUES ('TV28' , '28-inch', '250,000'),
		('TV28W' , '28-inch', '250,000'),	
		('TV32' , '32-inch', '300,000'),	
		('TV32W' , '32-inch', '300,000');

SELECT DISTINCT customer_name, merchandise_name, unit_price
FROM order_table, merchandise_table
WHERE order_table.merchandise_number = merchandise_table.merchandise_number;


