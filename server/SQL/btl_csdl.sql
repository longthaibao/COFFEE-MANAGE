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
	`store_phone` varchar(10) NOT NULL,
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
    `employee_MID` int, -- có thể null vì quản lý không cần ai quản lý
	`deleted` int NOT NULL DEFAULT 0,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`employee_SID`) REFERENCES `store`(`SID`),
    FOREIGN KEY (`employee_MID`) REFERENCES `employee`(`ID`)
);

CREATE TABLE IF NOT EXISTS `employee_phone`
(
	`employee_phone_ID` int NOT NULL,
    `employee_phone_phone` varchar(10),
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
    `password` varchar(256) NOT NULL,
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
    -- `product_image` varchar(100),
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
    `sup_phone` varchar(10) NOT NULL,
    `sup_email` varchar(30) NOT NULL,
    PRIMARY KEY(`supID`)
 );
 
 CREATE TABLE IF NOT EXISTS `customer`
 (
	`phone` varchar(10) NOT NULL,
    `name` varchar(30) NOT NULL,
    `score` int DEFAULT 0,
    `deleted` bool DEFAULT FALSE NOT NULL,
    PRIMARY KEY(`phone`)
 );
 
 CREATE TABLE IF NOT EXISTS `bill`
 (
	`BID` int NOT NULL,
    `state` int NOT NULL DEFAULT 0, -- 0: đang nhập, 1: hoàn tất hóa đơn (đã check CTKM và giảm giá nếu có), 2: đã thanh toán
    `bill_sum` int NOT NULL DEFAULT 0,
    `bill_store` int NOT NULL DEFAULT 1, -- set default = 1 vì An làm tại CH có store id = 1
    `bill_phone_cus` varchar(10) NOT NULL, 
    `bill_date` DATE NOT NULL, -- ngày nhập
    `bill_AID` int NOT NULL DEFAULT 1, -- default account có ID = 1 -> An
    PRIMARY KEY (`BID`),
    FOREIGN KEY (`bill_store`) REFERENCES `store` (`SID`),
    FOREIGN KEY (`bill_AID`) REFERENCES `account` (`AID`),
    FOREIGN KEY (`bill_phone_cus`) REFERENCES `customer`  (`phone`) ON UPDATE CASCADE
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
	`customer_phone` varchar(10) NOT NULL,
    `gift_GID` int NOT NULL,
    `quantity` int NOT NULL,
    `date` DATE NOT NULL,
    PRIMARY KEY (`customer_phone`,`gift_GID`),
    FOREIGN KEY (`customer_phone`) REFERENCES `customer` (`phone`) ON UPDATE CASCADE,
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
    FOREIGN KEY (`product_PID`,`recipe_RID`) REFERENCES `recipe` (`product_PID`,`RID`),
    FOREIGN KEY (`material_MID`) REFERENCES `material` (`MID`) -- moi them
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
    `coupoun_used_quantity`  int NOT NULL DEFAULT 0,
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

-- TRIGGER
DELIMITER //
CREATE TRIGGER insert_product_bill_info_trigger -- cộng bill_sum khi có một sản phẩm mới được thêm vào hóa đơn
AFTER INSERT ON product_bill_info
FOR EACH ROW
BEGIN
    UPDATE bill
    SET bill_sum = bill_sum + (NEW.product_bill_info_quantity * NEW.product_bill_info_price)
    WHERE BID = NEW.product_bill_info_BID;
END //

CREATE TRIGGER insert_bill_coupoun_bill_trigger -- trừ bill_sum khi có một CTKM được apply lên bill đó
AFTER INSERT ON bill_coupoun_bill
FOR EACH ROW
BEGIN
	UPDATE bill
    SET bill_sum = bill_sum - NEW.discount_value
    WHERE BID = NEW.bill_BID;
END //	

CREATE TRIGGER update_customer_score  -- tính điểm khi hóa đơn thanh toán
BEFORE UPDATE ON bill
FOR EACH ROW
BEGIN
    IF NEW.state = 2 THEN
        UPDATE customer
        SET score = score + NEW.bill_sum / 1000
        WHERE phone = NEW.bill_phone_cus;
    END IF;
END //

CREATE TRIGGER deduct_gift_score
AFTER INSERT ON customer_gift
FOR EACH ROW
BEGIN
    DECLARE gift_score_value INT;

    SELECT gift_score INTO gift_score_value
    FROM gift
    WHERE GID = NEW.gift_GID;

    UPDATE customer
    SET score = score - gift_score_value * NEW.quantity
    WHERE phone = NEW.customer_phone;
END //

-- trigger để kiểm tra ràng buộc ngữ nghĩa
CREATE TRIGGER check_cashier_account -- check Chỉ có nhân viên có vị trí thu ngân mới có tài khoản
BEFORE INSERT
ON account
FOR EACH ROW
BEGIN
	IF NOT EXISTS (SELECT 1 FROM employee_job WHERE employee_job_ID = NEW.employee_ID AND employee_job_JID = 2) THEN
		CALL show_notification('Only cashiers are allowed to have account');
    END IF;
END //

CREATE TRIGGER check_account_bill -- check ai có tài khoản mới được xuất hóa đơn
BEFORE INSERT
ON bill
FOR EACH ROW
BEGIN
	IF NOT EXISTS (SELECT 1 FROM account WHERE AID = NEW.bill_AID) THEN
		CALL show_notification('Only those with accounts are allowed to input bills.');
    END IF;
END //

CREATE TRIGGER check_sl_dk -- check Số lượng sản phẩm khuyến mãi cần mua phải lớn hơn số lượng sản phẩm khuyến mãi đc tặng
BEFORE INSERT
ON coupoun_product
FOR EACH ROW
BEGIN
    DECLARE K_condition INT;
    SELECT conditions INTO K_condition FROM coupoun WHERE KID = NEW.KID;
    IF K_condition < NEW.coupoun_product_quantity THEN
        CALL show_notification('Inserted value must be smaller than the value in the coupoun table');
    END IF;
END //

CREATE TRIGGER check_end -- check Ngày kết thúc khuyến mãi không quá 1 tháng kể từ ngày bắt đầu khuyến mãi.
BEFORE INSERT
ON coupoun
FOR EACH ROW
BEGIN
    DECLARE diff INT;
    SET diff = DATEDIFF(NEW.coupoun_end_date, NEW.coupoun_start_date);
    IF diff > 30 THEN
        CALL show_notification('The coupon end date must not exceed one month from the coupon start date');
    END IF;
END //

CREATE TRIGGER check_time -- check Giờ đóng cửa phải sau giờ mở cửa ít nhất 4 tiếng.
BEFORE INSERT
ON time_store
FOR EACH ROW
BEGIN
    DECLARE diff_minutes INT;
    SET diff_minutes = TIMESTAMPDIFF(HOUR, NEW.open_time, NEW.close_time);
    IF diff_minutes <= 4 THEN
        CALL show_notification('Closing time must be at least 4 hours after opening time.');
    END IF;
END //
DELIMITER ;
-- END TRIGGER

-- FUNCTION
-- Function (1)
-- input: storeID, startDate, endDate
-- output: tổng doanh thu
DELIMITER //

CREATE FUNCTION CalculateTotalRevenueAtStore(storeID INT, startDate DATE, endDate DATE) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE totalRevenue DECIMAL(10, 2);

    -- Check if the store exists
    IF NOT EXISTS (SELECT 1 FROM store WHERE SID = storeID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Store does not exist in the database.';
    END IF;

    -- Check if the end date is later than the start date
    IF endDate < startDate THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'End date must be later than start date.';
    END IF;

    SELECT SUM(bill_sum)
    INTO totalRevenue
    FROM bill
    WHERE bill_date BETWEEN startDate AND endDate AND bill_store = storeID;

    IF totalRevenue IS NULL THEN
        SET totalRevenue = 0.00;
    END IF;

    RETURN totalRevenue;
END //

DELIMITER ;


-- Function (2)
-- input: storeID, startDate, endDate
-- output: tổng số lượng sản phẩm được bán
DELIMITER //

CREATE FUNCTION CalculateSumProductSales(
    storeID INT,
    startDate DATE,
    endDate DATE
) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE totalSales DECIMAL(10, 2);

    -- Check if the store exists
    IF NOT EXISTS (SELECT 1 FROM store WHERE SID = storeID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Store does not exist in the database.';
    END IF;

    -- Check if the end date is greater than or equal to the start date
    IF endDate < startDate THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'End date must be greater than or equal to the start date.';
    END IF;

    -- Calculate the sum of product sales for the specified store and date range
    SELECT COALESCE(SUM(pbi.product_bill_info_quantity), 0) AS totalSales
    INTO totalSales
    FROM product_bill_info pbi
    JOIN product_bill pb ON pbi.product_bill_info_PID = pb.product_PID AND pbi.product_bill_info_BID = pb.bill_BID
    JOIN bill b ON pb.bill_BID = b.BID
    WHERE b.bill_store = storeID AND b.bill_date BETWEEN startDate AND endDate;
    RETURN totalSales;
END //

DELIMITER ;

-- Function (3)
-- input: storeID, startDate, endDate
-- output: productID
DELIMITER //

CREATE FUNCTION GetBestSellingProduct(
    store_ID INT,
    start_date DATE,
    end_date DATE
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE best_selling_product_ID INT;
  -- Check if the store exists
    IF NOT EXISTS (SELECT 1 FROM store WHERE SID = store_ID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Store does not exist in the database.';
    END IF;

    -- Check if the end date is greater than or equal to the start date
    IF end_date < start_date THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'End date must be greater than or equal to the start date.';
    END IF;

    -- Create a temporary table to store the result
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_product_report (
        product_ID INT,
        total_quantity_sold INT
    );

    -- Insert the result into the temporary table
    INSERT INTO temp_product_report (`product_ID`, `total_quantity_sold`)
    SELECT
        pb.product_PID,
        COALESCE(SUM(pbi.product_bill_info_quantity), 0) AS total_quantity_sold
    FROM
        bill b
    JOIN
        product_bill pb ON b.BID = pb.bill_BID
    JOIN
        product_bill_info pbi ON pb.bill_BID = pbi.product_bill_info_BID AND pb.product_PID = pbi.product_bill_info_PID
    JOIN
        product p ON pb.product_PID = p.PID
    WHERE
        b.bill_store = store_ID
        AND b.bill_date BETWEEN start_date AND end_date
    GROUP BY
        pb.product_PID;

    -- Select the product with the highest total_quantity_sold
    SELECT 
        product_ID
    INTO
        best_selling_product_ID
    FROM
        temp_product_report
    ORDER BY
        total_quantity_sold DESC
    LIMIT 1;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_product_report;

    RETURN best_selling_product_ID;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION IsCouponValid(input_date DATE, coupon_KID INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE is_valid BOOLEAN;

    SELECT 
        IF(coupoun_used_quantity >= coupoun_quantity_limit OR coupoun_end_date < input_date OR coupoun_start_date > input_date, FALSE, TRUE)
    INTO is_valid
    FROM coupoun
    WHERE KID = coupon_KID;
    RETURN is_valid;
END //

DELIMITER ;

-- Procedure (1)
-- input: storeID, startDate, endDate
-- output: table có product ID, tên, size, số lượng

DELIMITER //

CREATE PROCEDURE GetProduct(
    IN store_ID INT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    -- Declare variables
    DECLARE product_PID INT;
    DECLARE product_name VARCHAR(40);
    DECLARE product_size VARCHAR(1);
    DECLARE total_quantity_sold INT;
  -- Check if the store exists
    IF NOT EXISTS (SELECT 1 FROM store WHERE SID = storeID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Store does not exist in the database.';
    END IF;

    -- Check if the end date is greater than or equal to the start date
    IF endDate < startDate THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'End date must be greater than or equal to the start date.';
    END IF;

    -- Create a temporary table to store the result
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_product_report (
        product_ID INT,
        product_name VARCHAR(40),
        product_size VARCHAR(1),
        total_quantity_sold INT
    );

    -- Insert the result into the temporary table
    INSERT INTO temp_product_report (`product_ID`, `product_name`, `product_size`, `total_quantity_sold`)
      SELECT
         pb.product_PID,
         p.product_name,
         p.product_size,
         COALESCE(SUM(pbi.product_bill_info_quantity), 0) AS total_quantity_sold
     FROM
         bill b
     JOIN
         product_bill pb ON b.BID = pb.bill_BID
     JOIN
         product_bill_info pbi ON pb.bill_BID = pbi.product_bill_info_BID AND pb.product_PID = pbi.product_bill_info_PID
     JOIN
         product p ON pb.product_PID = p.PID
     WHERE
         b.bill_store = store_ID
         AND b.bill_date BETWEEN start_date AND end_date
     GROUP BY
        pb.product_PID, p.product_name, p.product_size;

    -- Select the result from the temporary table
SELECT 
    *
FROM
    temp_product_report;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_product_report;
END //

DELIMITER ;

-- PROCEDURE (2): Lịch sử mua hàng (tất cả), hoặc có input là số điện thoại khách hàng: 
DELIMITER //

CREATE PROCEDURE display_bill_info()
BEGIN
    SELECT
        b.BID AS bill_ID,
        c.name AS customer_name,
        e.employee_name AS employ_name,
        b.bill_date,
        b.bill_sum,
        b.state
    FROM
        bill b
        JOIN customer c ON b.bill_phone_cus = c.phone
        JOIN employee e ON b.bill_AID = e.ID;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE display_customer_bills(IN customerPhone VARCHAR(10))
BEGIN
    SELECT
        b.BID AS bill_ID,
        c.name AS customer_name,
        e.employee_name AS employ_name,
        b.bill_date,
        b.bill_sum,
        b.state
    FROM
        bill b
        JOIN customer c ON b.bill_phone_cus = c.phone
        JOIN employee e ON b.bill_AID = e.ID
    WHERE
        c.phone = customerPhone;
END //

DELIMITER ;


