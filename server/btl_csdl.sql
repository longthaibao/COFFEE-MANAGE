CREATE DATABASE IF NOT EXISTS CSDL_database;
USE CSDL_database;
CREATE TABLE IF NOT EXISTS `job_role` 
(
	`JID`        int NOT NULL ,
	`job_type` varchar(45) NOT NULL,
	PRIMARY KEY (`JID`)
);

CREATE TABLE IF NOT EXISTS `store`
(
	`SID` int NOT NULL,
	`store_name` varchar(100) NOT NULL,
	`store_phone` varchar(12) NOT NULL,
	`store_des` longtext,
	`store_add` mediumtext,
	PRIMARY KEY (`SID`)
);

CREATE TABLE  IF NOT EXISTS `employee`
(
	`ID` int NOT NULL,
	`employee_name` varchar(45) NOT NULL,
    `employee_gender` varchar(10),
    `employee_email` varchar(30) NOT NULL,
    `employee_SID` int NOT NULL,
    `employee_MID` int NOT NULL,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`employee_SID`) REFERENCES `store`(`SID`),
    FOREIGN KEY (`employee_MID`) REFERENCES `employee`(`ID`)
);

CREATE TABLE IF NOT EXISTS `employee_phone`
(
	`employee_phone_ID` int NOT NULL,
    `employee_phone_phone` varchar(12),
    PRIMARY KEY(`employee_phone_ID`,`employee_phone_phone`),
    FOREIGN KEY (`employee_phone_ID`) REFERENCES `employee` (`ID`)
);

 CREATE TABLE IF NOT EXISTS `employee_job`
 (
	`employee_job_ID` int NOT NULL,
    `employee_job_JID` int NOT NULL,
    PRIMARY KEY(`employee_job_ID`,`employee_job_JID`),
    FOREIGN KEY (`employee_job_ID`) REFERENCES `employee`(`ID`),
    FOREIGN KEY (`employee_job_JID`) REFERENCES `job_role`(`JID`)
 );
 
 CREATE TABLE IF NOT EXISTS `account`
 (
	`AID` int NOT NULL,
    `username` varchar(30) NOT NULL,
    `password` varchar(30) NOT NULL,
    `employee_ID` int NOT NULL,
    PRIMARY KEY(`AID`),
    FOREIGN KEY (`employee_ID`) REFERENCES `employee` (`ID`)
 );
 
 CREATE TABLE IF NOT EXISTS `product`
 (
	`PID` int NOT NULL,
    `product_name` varchar(40) NOT NULL,
    `product_price` int NOT NULL,
    `product_size` varchar(1) NOT NULL,
    `product_image` varchar(100),
    PRIMARY KEY(`PID`)
 );
 
 CREATE TABLE IF NOT EXISTS `material`
 (
	`MID` int NOT NULL,
    `material_name` varchar(40) NOT NULL,
    `material_type` varchar(40) NOT NULL,
    PRIMARY KEY(`MID`)
 );
 
 CREATE TABLE IF NOT EXISTS `supplier`
 (
	`supID` int NOT NULL,
    `sup_name` varchar(45) NOT NULL,
    `sup_add` varchar(100) NOT NULL,
    `sup_phone` varchar(12) NOT NULL,
    `sup_email` varchar(30) NOT NULL,
    PRIMARY KEY(`supID`)
 );
 
 CREATE TABLE IF NOT EXISTS `customer`
 (
	`phone` varchar(12) NOT NULL,
    `name` varchar(30) NOT NULL,
    `score` int,
    PRIMARY KEY(`phone`)
 );
 
 CREATE TABLE IF NOT EXISTS `bill`
 (
	`BID` int NOT NULL,
    `bill_sum` int NOT NULL,
    `bill_store` int NOT NULL,
    `bill_phone_cus` varchar(12) NOT NULL, 
    PRIMARY KEY (`BID`),
    FOREIGN KEY (`bill_store`) REFERENCES `store` (`SID`),
    FOREIGN KEY (`bill_phone_cus`) REFERENCES `customer`  (`phone`)
 );
 
 CREATE TABLE IF NOT EXISTS `product_bill`
 (
	`product_PID` int NOT NULL,
    `bill_BID` int NOT NULL,
    PRIMARY KEY (`product_PID`,`bill_BID`),
    FOREIGN KEY (`product_PID`) REFERENCES `product` (`PID`),
    FOREIGN KEY (`bill_BID`) REFERENCES `bill` (`BID`)
 );
 
  CREATE TABLE IF NOT EXISTS `product_bill_info`
 (
	`product_bill_info_PID` int NOT NULL,
    `product_bill_info_BID` int NOT NULL,
    `product_bill_info_quantity` int NOT NULL,
    `product_bill_info_price` int NOT NULL,
    PRIMARY KEY (`product_bill_info_PID`,`product_bill_info_BID`,`product_bill_info_quantity`,`product_bill_info_price`),
    FOREIGN KEY (`product_bill_info_PID`,`product_bill_info_BID`) REFERENCES `product_bill` (`product_PID`,`bill_BID`)
 );
 
 CREATE TABLE IF NOT EXISTS `gift`
 (
	`GID` int NOT NULL,
    `gift_name` varchar(40) NOT NULL,
    `gift_score` int NOT NULL,
    PRIMARY KEY (`GID`)
 );
 
 CREATE TABLE IF NOT EXISTS `customer_gift`
 (
	`customer_phone` varchar(12) NOT NULL,
    `gift_GID` int NOT NULL,
    `quantity` int NOT NULL,
    `date` DATE NOT NULL,
    PRIMARY KEY (`customer_phone`,`gift_GID`),
    FOREIGN KEY (`customer_phone`) REFERENCES `customer` (`phone`),
    FOREIGN KEY (`gift_GID`) REFERENCES `gift` (`GID`)
 );
 
 CREATE TABLE IF NOT EXISTS `store_product`
 (
	`product_PID` int NOT NULL,
    `store_SID` int NOT NULL,
    PRIMARY KEY(`product_PID`,`store_SID`),
    FOREIGN KEY (`product_PID`) REFERENCES `product` (`PID`),
    FOREIGN KEY (`store_SID`) REFERENCES `store` (`SID`)
 );
 
 CREATE TABLE IF NOT EXISTS `sup_material`
 (
	`material_MID` int NOT NULL,
    `sup_supID` int NOT NULL, 
    PRIMARY KEY (`material_MID`,`sup_supID`),
    FOREIGN KEY (`material_MID`) REFERENCES `material` (`MID`),
    FOREIGN KEY (`sup_supID`) REFERENCES `supplier` (`supID`)
 );
 
 CREATE TABLE IF NOT EXISTS `recipe`
 (
	`product_PID` int NOT NULL,
    `RID` int NOT NULL,
    `recipe_des` longtext,
    PRIMARY KEY (`product_PID`,`RID`),
    FOREIGN KEY (`product_PID`) REFERENCES `product` (`PID`)
 );
 
--  MAYBE WRONG
CREATE TABLE IF NOT EXISTS `recipe_material`
(
	`material_MID` int NOT NULL,
    `product_PID` int NOT NULL,
    `recipe_RID` int NOT NULL,
    `quantity` int NOT NULL,
    PRIMARY KEY (`material_MID`,`product_PID`,`recipe_RID`),
    FOREIGN KEY (`product_PID`,`recipe_RID`) REFERENCES `recipe` (`product_PID`,`RID`)
);

CREATE TABLE IF NOT EXISTS `time_store`
(
    `time_store_SID` int NOT NULL,
    `open_time` TIME NOT NULL,
    `close_time` TIME NOT NULL,
    `date` DATE NOT NULL,
    PRIMARY KEY (`time_store_SID`,`open_time`,`close_time`,`date`),
    FOREIGN KEY (`time_store_SID`) REFERENCES `store` (`SID`)
);

CREATE TABLE IF NOT EXISTS `coupoun`
(
	`KID` int NOT NULL,
    `coupoun_name` varchar(30) NOT NULL,
    `coupoun_des` longtext NOT NULL,
    `coupoun_quantity_limit` int NOT NULL,
    `coupoun_used_quantity`  int NOT NULL,
    `coupoun_start_date` DATE NOT NULL,
    `coupoun_end_date` DATE NOT NULL,
    `conditions` int NOT NULL,
    PRIMARY KEY (`KID`)
);

CREATE TABLE IF NOT EXISTS `coupoun_product`
(
	`KID` int NOT NULL,
    `coupoun_product_quantity` int NOT NULL,
    PRIMARY KEY (`KID`),
    FOREIGN KEY (`KID`) REFERENCES `coupoun` (`KID`)
);

CREATE TABLE IF NOT EXISTS `coupoun_bill`
(
	`KID` int NOT NULL,
    `coupoun_bill_max_discount` int NOT NULL,
    `flag_cash` TINYINT(1) ,
    `cash_value` int ,
    `flag_percent` TINYINT(1) ,
    `percent_value` int,
    FOREIGN KEY (`KID`) REFERENCES `coupoun` (`KID`)
);

CREATE TABLE IF NOT EXISTS `product_coupoun_product`
(
	`product_PID` int NOT NULL,
    `coupoun_KID` int NOT NULL,
    PRIMARY KEY (`product_PID`),
    FOREIGN KEY (`product_PID`) REFERENCES `product` (`PID`),
    FOREIGN KEY (`coupoun_KID`) REFERENCES `coupoun` (`KID`)
);

CREATE TABLE IF NOT EXISTS `bill_coupoun_bill`
(
	`bill_BID` int NOT NULL,
    `coupoun_KID` int NOT NULL,
    `discount_value` int NOT NULL,
    PRIMARY KEY (`bill_BID`),
    FOREIGN KEY (`bill_BID`) REFERENCES `bill` (`BID`),
    FOREIGN KEY (`coupoun_KID`) REFERENCES `coupoun` (`KID`)
);

INSERT INTO `job_role` (`JID`, `job_type`)
VALUES
    (1, 'Manager'),
    (2, 'Cashier'),
    (3, 'Salesperson');

INSERT INTO `store` (`SID`, `store_name`, `store_phone`, `store_des`, `store_add`)
VALUES
    (1, 'Store A', '123-456-7890', 'Description for Store A', 'Address for Store A'),
    (2, 'Store B', '987-654-3210', 'Description for Store B', 'Address for Store B');

INSERT INTO `employee` (`ID`, `employee_name`, `employee_gender`, `employee_email`, `employee_SID`, `employee_MID`)
VALUES
    (1, 'John Doe', 'Male', 'john.doe@example.com', 1, 1),
    (2, 'Jane Smith', 'Female', 'jane.smith@example.com', 1, 1);

INSERT INTO `employee_phone` (`employee_phone_ID`, `employee_phone_phone`)
VALUES
    (1, '111-222-3333'),
    (2, '444-555-6666');

INSERT INTO `employee_job` (`employee_job_ID`, `employee_job_JID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `account` (`AID`, `username`, `password`, `employee_ID`)
VALUES
    (1, 'john_doe', 'password123', 1),
    (2, 'jane_smith', 'securepass', 2);

INSERT INTO `product` (`PID`, `product_name`, `product_price`, `product_size`, `product_image`)
VALUES
    (1, 'Product A', 10, 'M', 'product_a_image.jpg'),
    (2, 'Product B', 20, 'L', 'product_b_image.jpg');

INSERT INTO `material` (`MID`, `material_name`, `material_type`)
VALUES
    (1, 'Material A', 'Type X'),
    (2, 'Material B', 'Type Y');

INSERT INTO `supplier` (`supID`, `sup_name`, `sup_add`, `sup_phone`, `sup_email`)
VALUES
    (1, 'Supplier X', 'Address X', '111-222-3333', 'supplier_x@example.com'),
    (2, 'Supplier Y', 'Address Y', '444-555-6666', 'supplier_y@example.com');

INSERT INTO `customer` (`phone`, `name`, `score`)
VALUES
    ('777-888-9999', 'Customer Z', 100),
    ('888-999-0000', 'Customer W', 150);

INSERT INTO `bill` (`BID`, `bill_sum`, `bill_store`, `bill_phone_cus`)
VALUES
    (1, 30, 1, '777-888-9999'),
    (2, 40, 2, '888-999-0000'),
	(3, 25, 1, '777-888-9999'),
    (4, 50, 2, '888-999-0000'),
    (5, 35, 1, '777-888-9999'),
    (6, 60, 2, '888-999-0000'),
    (7, 28, 1, '777-888-9999'),
    (8, 45, 2, '888-999-0000'),
    (9, 32, 1, '777-888-9999'),
    (10, 55, 2, '888-999-0000'),
    (11, 40, 1, '777-888-9999'),
    (12, 48, 2, '888-999-0000'),
    (13, 33, 1, '777-888-9999'),
    (14, 62, 2, '888-999-0000'),
    (15, 38, 1, '777-888-9999'),
    (16, 53, 2, '888-999-0000'),
    (17, 42, 1, '777-888-9999'),
    (18, 57, 2, '888-999-0000'),
    (19, 36, 1, '777-888-9999'),
    (20, 48, 2, '888-999-0000');
    
INSERT INTO `product_bill` (`product_PID`, `bill_BID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `product_bill_info` (`product_bill_info_PID`, `product_bill_info_BID`, `product_bill_info_quantity`, `product_bill_info_price`)
VALUES
    (1, 1, 2, 20),
    (2, 2, 3, 30);

INSERT INTO `gift` (`GID`, `gift_name`, `gift_score`)
VALUES
    (1, 'Gift X', 50),
    (2, 'Gift Y', 30);

INSERT INTO `customer_gift` (`customer_phone`, `gift_GID`, `quantity`, `date`)
VALUES
    ('777-888-9999', 1, 1, '2023-12-01'),
    ('888-999-0000', 2, 2, '2023-12-02');

INSERT INTO `store_product` (`product_PID`, `store_SID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `sup_material` (`material_MID`, `sup_supID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `recipe` (`product_PID`, `RID`, `recipe_des`)
VALUES
    (1, 1, 'Recipe for Product A'),
    (2, 2, 'Recipe for Product B');

INSERT INTO `recipe_material` (`material_MID`, `product_PID`, `recipe_RID`, `quantity`)
VALUES
    (1, 1, 1, 3),
    (2, 2, 2, 4);

INSERT INTO `time_store` (`time_store_SID`, `open_time`, `close_time`, `date`)
VALUES
    (1, '09:00:00', '18:00:00', '2023-12-05'),
    (2, '10:30:00', '20:00:00', '2023-12-06');

INSERT INTO `coupoun` (`KID`, `coupoun_name`, `coupoun_des`, `coupoun_quantity_limit`, `coupoun_used_quantity`, `coupoun_start_date`, `coupoun_end_date`, `conditions`)
VALUES
    (1, 'Coupon X', 'Description X', 50, 10, '2023-12-01', '2023-12-10', 1),
    (2, 'Coupon Y', 'Description Y', 30, 5, '2023-12-05', '2023-12-15', 2),
    (3, 'Coupon Z', 'Description Z', 40, 8, '2023-12-10', '2023-12-20', 1),
    (4, 'Coupon W', 'Description W', 25, 3, '2023-12-15', '2023-12-25', 2),
    (5, 'Coupon A', 'Description A', 30, 7, '2023-12-05', '2023-12-15', 1),
    (6, 'Coupon B', 'Description B', 20, 5, '2023-12-12', '2023-12-22', 2),
    (7, 'Coupon C', 'Description C', 35, 6, '2023-12-08', '2023-12-18', 1),
    (8, 'Coupon D', 'Description D', 22, 4, '2023-12-18', '2023-12-28', 2),
    (9, 'Coupon E', 'Description E', 28, 9, '2023-12-03', '2023-12-13', 1),
    (10, 'Coupon F', 'Description F', 18, 2, '2023-12-22', '2023-12-30', 2),
    (11, 'Coupon G', 'Description G', 33, 5, '2023-12-14', '2023-12-24', 1),
    (12, 'Coupon H', 'Description H', 15, 1, '2023-12-20', '2023-12-30', 2),
    (13, 'Coupon I', 'Description I', 25, 6, '2023-12-07', '2023-12-17', 1),
    (14, 'Coupon J', 'Description J', 12, 3, '2023-12-23', '2023-12-31', 2),
    (15, 'Coupon K', 'Description K', 20, 4, '2023-12-09', '2023-12-19', 1),
    (16, 'Coupon L', 'Description L', 10, 1, '2023-12-28', '2023-12-31', 2),
    (17, 'Coupon M', 'Description M', 30, 8, '2023-12-11', '2023-12-21', 1),
    (18, 'Coupon N', 'Description N', 18, 3, '2023-12-16', '2023-12-26', 2),
    (19, 'Coupon O', 'Description O', 25, 7, '2023-12-06', '2023-12-16', 1),
    (20, 'Coupon P', 'Description P', 15, 2, '2023-12-27', '2023-12-31', 2);

INSERT INTO `coupoun_product` (`KID`, `coupoun_product_quantity`)
VALUES
    (1, 2),
    (2, 3);

INSERT INTO `coupoun_bill` (`KID`, `coupoun_bill_max_discount`, `flag_cash`, `cash_value`, `flag_percent`, `percent_value`)
VALUES
    (1, 10, 1, 5, 0, 0),
    (2, 15, 0, 0, 1, 20),
    (3, 12, 1, 6, 0, 0),
    (4, 18, 0, 0, 1, 25),
    (5, 10, 1, 5, 0, 0),
    (6, 15, 0, 0, 1, 20),
    (7, 12, 1, 6, 0, 0),
    (8, 18, 0, 0, 1, 25),
    (9, 10, 1, 5, 0, 0),
    (10, 15, 0, 0, 1, 20),
    (11, 12, 1, 6, 0, 0),
    (12, 18, 0, 0, 1, 25),
    (13, 10, 1, 5, 0, 0),
    (14, 15, 0, 0, 1, 20),
    (15, 12, 1, 6, 0, 0),
    (16, 18, 0, 0, 1, 25),
    (17, 10, 1, 5, 0, 0),
    (18, 15, 0, 0, 1, 20),
    (19, 12, 1, 6, 0, 0),
    (20, 18, 0, 0, 1, 25);

INSERT INTO `product_coupoun_product` (`product_PID`, `coupoun_KID`)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO `bill_coupoun_bill` (`bill_BID`, `coupoun_KID`, `discount_value`)
VALUES
    (1, 1, 8),
    (2, 2, 12),
    (3, 1, 10),
    (4, 2, 15),
    (5, 1, 8),
    (6, 2, 12),
    (7, 1, 10),
    (8, 2, 15),
    (9, 1, 8),
    (10, 2, 12),
    (11, 1, 10),
    (12, 2, 15),
    (13, 1, 8),
    (14, 2, 12),
    (15, 1, 10),
    (16, 2, 15),
    (17, 1, 8),
    (18, 2, 12),
    (19, 1, 10),
    (20, 2, 15);
    
DELIMITER //
CREATE PROCEDURE Login(IN p_id VARCHAR(30), IN p_pass VARCHAR(30))
BEGIN
    SELECT `AID`
    FROM `account`
    WHERE `username` = p_id AND `password` = p_pass;
END //

CREATE PROCEDURE GetAdminInfo(IN p_id VARCHAR(255))
BEGIN
    -- Declare variables to store employee information
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(45);
    DECLARE emp_gender VARCHAR(10);
    DECLARE emp_email VARCHAR(30);
    DECLARE emp_sid INT;
    DECLARE emp_mid INT;

    -- Retrieve employee information based on the account ID
    SELECT
        E.`ID`,
        E.`employee_name`,
        E.`employee_gender`,
        E.`employee_email`,
        E.`employee_SID`,
        E.`employee_MID`
    INTO
        emp_id,
        emp_name,
        emp_gender,
        emp_email,
        emp_sid,
        emp_mid
    FROM
        `account` A
    JOIN
        `employee` E ON A.`employee_ID` = E.`ID`
    WHERE
        A.`AID` = p_id;

    -- Return the employee information
    SELECT
        emp_id AS 'ID',
        emp_name AS 'Employee_Name',
        emp_gender AS 'Gender',
        emp_email AS 'Email',
        emp_sid AS 'Store_ID',
        emp_mid AS 'Manager_ID';
END //

CREATE PROCEDURE VIEWALLCUSTOMER()
BEGIN
	SELECT * FROM csdl_database.customer;
END //


CREATE PROCEDURE INSERTCUSTOMER(
	IN p_phone varchar(12),
    IN p_name varchar(30),
    IN p_score int
)
BEGIN
	 -- Insert customer information
     insert into customer(phone,`name`,score)
     values( p_phone, convert( p_name using utf8mb4) , p_score);
END //

CREATE PROCEDURE `UPDATECUSTOMER`(
    IN p_phone VARCHAR(10),
    IN p_new_phone VARCHAR(10)
)
BEGIN

    -- Update customer information
    UPDATE customer
    SET
        phone = CONVERT(p_new_phone USING utf8mb4)
    WHERE
        phone = p_phone;
END //

CREATE PROCEDURE DELETECUSTOMER(
    IN p_phone VARCHAR(10)
)
BEGIN

    -- Delete customer information
    DELETE FROM customer
    WHERE phone = p_phone;
END //


DELIMITER ;
