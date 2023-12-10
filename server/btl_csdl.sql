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
    `deleted` bool  DEFAULT FALSE NOT NULL,
    PRIMARY KEY(`phone`)
 );
 
 CREATE TABLE IF NOT EXISTS `bill`
 (
	`BID` int NOT NULL,
    `state` int NOT NULL, -- 0: đang nhập, 1: hoàn tất hóa đơn (đã check CTKM và giảm giá nếu có), 2: đã thanh toán
    `bill_sum` int NOT NULL,
    `bill_store` int NOT NULL,
    `bill_phone_cus` varchar(12) NOT NULL, 
    `bill_date` DATE NOT NULL, 
    `bill_AID` int NOT NULL DEFAULT 1,
    PRIMARY KEY (`BID`),
    FOREIGN KEY (`bill_store`) REFERENCES `store` (`SID`),
    FOREIGN KEY (`bill_AID`) REFERENCES `account` (`AID`),
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
    `date` INT NOT NULL,
    PRIMARY KEY (`time_store_SID`,`open_time`,`close_time`,`date`),
    FOREIGN KEY (`time_store_SID`) REFERENCES `store` (`SID`)
);

CREATE TABLE IF NOT EXISTS `coupoun`
(
	`KID` int NOT NULL,
    `coupoun_name` varchar(255) NOT NULL,
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
    `flag_cash` TINYINT(1) ,
    `cash_value` int ,
    `flag_percent` TINYINT(1) ,
    `percent_value` int,
    `coupoun_bill_max_discount` int NOT NULL,
    FOREIGN KEY (`KID`) REFERENCES `coupoun` (`KID`)
);

CREATE TABLE IF NOT EXISTS `product_coupoun_product`
(
	`product_PID` int NOT NULL,
    `coupoun_KID` int NOT NULL,
    PRIMARY KEY (`product_PID`,`coupoun_KID`),
    FOREIGN KEY (`product_PID`) REFERENCES `product` (`PID`),
    FOREIGN KEY (`coupoun_KID`) REFERENCES `coupoun_product` (`KID`)
);

CREATE TABLE IF NOT EXISTS `bill_coupoun_bill`
(
	`bill_BID` int NOT NULL,
    `coupoun_KID` int NOT NULL,
    `discount_value` int NOT NULL,
    PRIMARY KEY (`bill_BID`),
    FOREIGN KEY (`bill_BID`) REFERENCES `bill` (`BID`),
    FOREIGN KEY (`coupoun_KID`) REFERENCES `coupoun_bill` (`KID`)
);

DELIMITER //
DROP PROCEDURE IF EXISTS checkIfDiscount;//
CREATE PROCEDURE checkIfDiscount(
	IN p_BID INT
)
BEGIN
	DECLARE total_price_sum_var INT;
    DECLARE conditions_var INT;
    DECLARE KID_var INT;
    DECLARE discount_value_var INT;
    DECLARE bill_date_var DATE;
    
    SELECT
		bill_sum, bill_date INTO total_price_sum_var, bill_date_var
	FROM bill
    WHERE BID = p_BID
    LIMIT 1;
    
    SELECT
		conditions,KID INTO conditions_var,KID_var
	FROM
		coupoun
	WHERE
		bill_date_var BETWEEN coupoun_start_date AND coupoun_end_date;
        
    IF conditions_var IS NOT NULL THEN 
        IF conditions_var >= 1000 THEN
			IF total_price_sum_var >= conditions_var THEN
				INSERT INTO
					bill_coupoun_bill (bill_BID, coupoun_KID, discount_value)
				VALUES(
					p_BID,
					KID_var,
					CASE
						WHEN (SELECT flag_cash FROM coupoun_bill WHERE KID = KID_var) = 1 THEN
							(SELECT cash_value FROM coupoun_bill WHERE KID = KID_var)
						ELSE
							CASE
								WHEN (SELECT flag_percent FROM coupoun_bill WHERE KID = KID_var) = 1 AND
									 (SELECT percent_value * total_price_sum_var FROM coupoun_bill WHERE KID = KID_var) >=
									 (SELECT coupoun_bill_max_discount FROM coupoun_bill WHERE KID = KID_var) THEN
									(SELECT coupoun_bill_max_discount FROM coupoun_bill WHERE KID = KID_var)
								ELSE
									(SELECT percent_value * total_price_sum_var FROM coupoun_bill WHERE KID = KID_var)
							END
					END
				);
                UPDATE
					coupoun
                SET coupoun_used_quantity = coupoun_used_quantity + 1
                WHERE KID = KID_var;
			ELSE
				UPDATE bill
				SET state = 1
				WHERE BID = p_BID;
			END IF;
		ELSE
			CREATE TEMPORARY TABLE temp_result_table (
				product_bill_info_PID INT,
				product_bill_info_BID INT,
				calculated_value INT
			);
			INSERT INTO temp_result_table (product_bill_info_PID, product_bill_info_BID, calculated_value)
				SELECT
					product_bill_info_PID,
					product_bill_info_BID,
					1 * (product_bill_info_quantity DIV conditions_VAR) AS calculated_value
				FROM
					product_bill_info
					JOIN (
						product_coupoun_product AS p1
						JOIN coupoun_product ON p1.coupoun_KID = coupoun_product.KID
					) ON product_bill_info.product_bill_info_PID = p1.product_PID
					AND product_bill_info.product_bill_info_BID = p_BID
					AND p1.coupoun_KID = KID_var
					JOIN coupoun ON coupoun.KID = KID_var
				WHERE
					product_bill_info_quantity >= conditions_var;
			IF (SELECT COUNT(*) FROM temp_result_table) > 0 THEN
				INSERT INTO product_bill_info (product_bill_info_PID, product_bill_info_BID, product_bill_info_quantity, product_bill_info_price)
				SELECT
					product_bill_info_PID,
					product_bill_info_BID,
					calculated_value,
					0
				FROM temp_result_table;
				UPDATE coupoun
				SET coupoun_used_quantity = coupoun_used_quantity + 1
				WHERE KID = KID_var;
			END IF;
			DROP TEMPORARY TABLE IF EXISTS temp_result_table;
            UPDATE bill
			SET state = 1
			WHERE BID = p_BID;
        END IF;
	ELSE
		UPDATE bill
        SET state = 1
        WHERE BID = p_BID;
    END IF;
END;//
DELIMITER ;
DELIMITER //
CREATE PROCEDURE Login(IN p_id VARCHAR(30), IN p_pass VARCHAR(30))
BEGIN
    SELECT `AID`
    FROM `account`
    WHERE `username` = p_id AND `password` = p_pass;
END //
DELIMITER ;
DELIMITER //
DROP PROCEDURE IF EXISTS getCoupounHavingRevenueGreaterThanInputInThisYear //
CREATE PROCEDURE getCoupounHavingRevenueGreaterThanInputInThisYear (
    IN revenue INT,
    IN p_year INT
)
BEGIN
    SELECT
		KID AS `Mã CTKM`,
		coupoun_name AS `Tên CTKM`,
		COALESCE(SUM(bill_sum), 0) AS `Tổng doanh thu (VNĐ)`,
		coupoun_start_date AS `Ngày bắt đầu (ngày/tháng/năm)`,
		coupoun_end_date AS `Ngày kết thúc (ngày/tháng/năm)`,
		coupoun_quantity_limit AS `Giới hạn số lần áp dụng`,
		coupoun_used_quantity AS `Số lần đã áp dụng`,
		conditions `Điều kiện để áp dụng KM`
	FROM coupoun LEFT OUTER JOIN 
		(SELECT BID, bill_sum, coupoun_KID, product_bill_info_BID, bill_date
		FROM 
			(csdl_database.bill LEFT OUTER JOIN csdl_database.bill_coupoun_bill ON csdl_database.bill.BID = csdl_database.bill_coupoun_bill.bill_BID)
			LEFT OUTER JOIN (SELECT product_bill_info_BID FROM product_bill_info WHERE product_bill_info_price = 0) AS t2 
			ON
				csdl_database.bill.BID = t2.product_bill_info_BID 
			WHERE
				coupoun_KID IS NOT NULL OR product_bill_info_BID IS NOT NULL) AS s
		ON bill_date BETWEEN coupoun_start_date AND coupoun_end_date
	WHERE
		(p_year = 0)
        OR YEAR(coupoun_start_date) = p_year
        OR YEAR(coupoun_end_date) = p_year
	GROUP BY KID,
		coupoun_start_date,
		coupoun_end_date,
		coupoun_quantity_limit,
		coupoun_used_quantity,
		conditions
	HAVING COALESCE(SUM(bill_sum), 0) >= revenue;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER insert_product_bill_info_trigger -- cộng bill_sum khi có một sản phẩm mới được thêm vào hóa đơn
AFTER INSERT ON product_bill_info
FOR EACH ROW
BEGIN
    UPDATE bill
    SET bill_sum = bill_sum + (NEW.product_bill_info_quantity * NEW.product_bill_info_price)
    WHERE BID = NEW.product_bill_info_BID;
END; //
DELIMITER ;
DELIMITER //
CREATE TRIGGER insert_bill_coupoun_bill_trigger -- trừ bill_sum khi có một CTKM được apply lên bill đó
AFTER INSERT ON bill_coupoun_bill
FOR EACH ROW
BEGIN
	UPDATE bill
    SET bill_sum = bill_sum - NEW.discount_value, state = 1 
    WHERE BID = NEW.bill_BID;
END //	
DELIMITER ;