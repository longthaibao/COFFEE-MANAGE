USE csdl_database;
DELIMITER //
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

CREATE PROCEDURE GetCustomerData()
BEGIN
	SELECT * FROM csdl_database.bill;
END //

CREATE PROCEDURE INSERTCUSTOMER(
	IN p_phone varchar(12),
    IN p_name varchar(30),
    IN p_score int,
    IN p_deleted bool
)
BEGIN
	 -- Insert customer information
     insert into customer(phone,`name`,score,deleted)
     values( p_phone, convert( p_name using utf8mb4) , p_score, p_deleted);
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
    UPDATE customer
    SET 
		deleted = true
    WHERE phone = p_phone;
END //

CREATE PROCEDURE showNV(IN job_type VARCHAR(45))
BEGIN
SELECT 
        e.`ID`,
        e.`employee_name`,
        e.`employee_gender`,
        e.`employee_email`,
        e.`employee_SID`,
        e.`employee_MID`
    FROM 
        CSDL_database.`employee` e
    JOIN 
        CSDL_database.`employee_job` ej ON e.`ID` = ej.`employee_job_ID`
    JOIN 
        CSDL_database.`job_role` jr ON ej.`employee_job_JID` = jr.`JID`
    WHERE 
        jr.`job_type` = job_type;
END//

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