USE CSDL_database;
DELIMITER //
CREATE PROCEDURE show_notification(IN custom_message VARCHAR(255))
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = custom_message;
END;//

CREATE PROCEDURE checkIfDiscount(
	IN p_BID INT
)
-- Check hóa đơn có được apply CTKM nào hay không? khi đã nhập xong các sản phẩm của hóa đơn đó và set bill.state = 1 (state = 1 là nhập đơn xong):
	-- Đầu tiên check ngày tạo hóa đơn có nằm trong ngày diễn ra CTKM nào không?
		-- Nếu có thì tiếp tục check số lần áp dụng của CTKM đó để xem CTKM đó còn được apply hay không?
			-- Nếu hóa đơn đó có thể apply CTKM theo hóa đơn thì: 
				-- 1. insert vào bill_coupoun_bill (BID,KID,discount_value)
												-- Nếu KM theo % thì: discount_value = giá trị phần trăm * tổng bill (tính xong còn check với giá trị tối đa được giảm)
												-- Nếu KM theo tiền mặt thì: discount_value = giá trị tiền mặt
				-- 2. update coupoun_used_quantity = coupoun_used_quantity + 1 của coupoun tương ứng
			-- Nếu hóa đơn đó có thể apply CTKM theo sản phẩm thì:
				-- 1. insert vào product_bill_info (PID,BID,quantity,price)
												-- quantity là số lượng được tặng = 1 * số lượng mua DIV(chia nguyên) điều kiện áp dụng
												-- rice = 0 (do tặng nên không tính tiền)
				-- 2. update coupoun_used_quantity = coupoun_used_quantity + 1 của coupoun tương ứng
BEGIN
	DECLARE total_price_sum_var INT;
    DECLARE conditions_var INT;
    DECLARE KID_var INT;
    DECLARE discount_value_var INT;
    DECLARE used INT;
    DECLARE limit_ INT;
    DECLARE bill_date_var DATE;
    
    SELECT
		bill_sum, bill_date INTO total_price_sum_var, bill_date_var
	FROM bill
    WHERE BID = p_BID
    LIMIT 1;
    
    SELECT
		conditions,KID,coupoun_used_quantity,coupoun_quantity_limit INTO conditions_var,KID_var,used,limit_
	FROM
		coupoun
	WHERE
		bill_date_var >= coupoun_start_date AND bill_date_var <= coupoun_end_date;
        
    IF used IS NOT NULL THEN 
		IF used < limit_ THEN
			IF conditions_var >= 1000 THEN
				IF total_price_sum_var >= conditions_var THEN
					INSERT INTO
						bill_coupoun_bill (bill_BID, coupoun_KID, discount_value)
					VALUES
					(
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
					UPDATE bill
					SET state = 1
					WHERE BID = p_BID;
				ELSE
					UPDATE bill
					SET state = 1
					WHERE BID = p_BID;
				END IF;
			ELSE
				CREATE TEMPORARY TABLE temp_result_table ( -- lấy thông tin sản phẩm nào trong bill nào được tặng bao nhiêu
					product_bill_info_PID INT, -- sản phẩm
					product_bill_info_BID INT, -- bill
					calculated_value INT -- số lượng được tặng
				);
				INSERT INTO temp_result_table (product_bill_info_PID, product_bill_info_BID, calculated_value)
					SELECT
						product_bill_info_PID,
						product_bill_info_BID,
						1 * (product_bill_info_quantity DIV conditions_VAR) AS calculated_value
					FROM
						product_bill_info
						JOIN (
							product_coupoun_product AS p1 -- biết được mỗi CTKM sẽ tặng mấy và apply cho những sản phẩm nào
							JOIN coupoun_product ON p1.coupoun_KID = coupoun_product.KID
						) ON
							product_bill_info.product_bill_info_PID = p1.product_PID
							AND product_bill_info.product_bill_info_BID = p_BID
							AND p1.coupoun_KID = KID_var
						JOIN coupoun ON coupoun.KID = KID_var -- lấy 
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
	ELSE
		UPDATE bill
        SET state = 1
        WHERE BID = p_BID;
    END IF;
END;//

CREATE PROCEDURE Login(IN p_id VARCHAR(30), IN p_pass VARCHAR(30))
BEGIN
    DECLARE hashed_password VARCHAR(255);

    SELECT `password` INTO hashed_password
    FROM `account`
    WHERE `username` = p_id;

    IF hashed_password IS NOT NULL AND hashed_password = SHA2(CONCAT(p_pass, 'fc45c92ac5ad37b42824ea724d2f8f32'), 256) THEN
        SELECT `AID`
        FROM `account`
        WHERE `username` = p_id;
    ELSE
        SELECT `AID`
        FROM account
        LIMIT 0;
    END IF;
END; //

CREATE PROCEDURE GetAdminInfo(IN p_id VARCHAR(255))
BEGIN
    -- Declare variables to store employee information
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(45);
    DECLARE emp_gender VARCHAR(10);
    DECLARE emp_email VARCHAR(30);
    DECLARE emp_sid VARCHAR(30);
    DECLARE emp_mid INT;

    -- Retrieve employee information based on the account ID
    SELECT
        E.`ID`,
        E.`employee_name`,
        E.`employee_gender`,
        E.`employee_email`,
        S.`store_name`,
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
	JOIN `store` S ON E.`employee_SID` = S.SID
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
	SELECT * FROM CSDL_database.customer;
END //

CREATE PROCEDURE INSERTCUSTOMER(
	IN p_phone varchar(12),
    IN p_name varchar(30)
)
BEGIN
	 -- Insert customer information
     insert into customer(phone,`name`)
     values( p_phone, convert( p_name using utf8mb4));
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETECUSTOMER`(
    IN p_phone VARCHAR(10)
)
BEGIN
     IF EXISTS (SELECT 1 FROM bill WHERE bill_phone_cus = p_phone) THEN
        -- If yes, set deleted to true in the bill table as well
        UPDATE customer
        SET deleted = true
        WHERE phone= p_phone;
    ELSE
        -- If no, delete the customer from the customer table
        DELETE FROM customer
        WHERE phone = p_phone;
    END IF;
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
        jr.`job_type` = job_type
		AND e.`deleted` = 0
    ORDER BY
        e.`employee_name`;
END//


CREATE PROCEDURE insertEmployee(
    IN emp_name VARCHAR(255),
    IN emp_gender CHAR(10),
    IN emp_email VARCHAR(255),
    IN job_id INT
)
BEGIN
	DECLARE next_id INT;
	DECLARE emp_SID INT;
    DECLARE emp_MID INT;
	DECLARE deleted INT;
    SELECT MAX(`ID`) + 1 INTO next_id FROM `CSDL_database`.`employee`;
    SET emp_SID = 1;
    SET emp_MID = 1;
    SET deleted=0;
    -- Insert the new employee with the next available ID
    INSERT INTO `CSDL_database`.`employee` (
        `ID`,
        `employee_name`,
        `employee_gender`,
        `employee_email`,
        `employee_SID`,
        `employee_MID`,
        `deleted`
    ) VALUES (
        next_id,
        emp_name,
        emp_gender,
        emp_email,
        emp_SID,
        emp_MID,
        deleted
    );
    -- Insert the new employee's ID and JID into the employee_job table
    INSERT INTO `CSDL_database`.`employee_job` (
        `employee_job_ID`,
        `employee_job_JID`
    ) VALUES (
        next_id,
        job_id
    );
END//


CREATE PROCEDURE deleteEmployee(IN emp_id INT)
BEGIN
   UPDATE `CSDL_database`.`employee` SET `deleted` = 1 WHERE `ID` = emp_id;
END//

CREATE PROCEDURE updateEmployee(
    IN emp_id INT,
    IN new_name VARCHAR(255),
    IN new_gender CHAR(10),
    IN new_email VARCHAR(255)
)
BEGIN
    UPDATE `CSDL_database`.`employee`
    SET
        `employee_name` = new_name,
        `employee_gender` = new_gender,
        `employee_email` = new_email
    WHERE
        `ID` = emp_id;
END//

CREATE PROCEDURE getCoupounHavingRevenueGreaterThanInputInThisYear (
    IN revenue INT,
    IN p_year INT
)
BEGIN
    SELECT
		KID AS `Mã CTKM`,
		coupoun_name AS `Tên CTKM`,
		sum_of_all_bill AS `Tổng doanh thu của CTKM (VNĐ)`,
		coupoun_start_date AS `Ngày bắt đầu (ngày/tháng/năm)`,
		coupoun_end_date AS `Ngày kết thúc (ngày/tháng/năm)`,
		coupoun_quantity_limit AS `Giới hạn số lần áp dụng`,
		coupoun_used_quantity AS `Số lần đã áp dụng`,
		conditions AS `Điều kiện để áp dụng KM`,
        COALESCE(name_, 'Không có') AS `KH chi nhiều tiền nhất cho CTKM này`,
        COALESCE(bill_phone_cus, 'Không có') AS `SĐT của KH chi nhiều tiền nhất cho CTKM này`,
		max_bill AS `Tổng tiền thu được từ KH chi nhiều tiền nhất (VNĐ)`
	FROM
	(
		SELECT
			KID,
			coupoun_name,
			COALESCE(SUM(sum_),0) AS sum_of_all_bill, -- tổng bill trong CTKM đó
			COALESCE(MAX(sum_),0) AS max_bill, -- tổng bill của người lớn nhất trong CTKM đó
			coupoun_start_date,
			coupoun_end_date,
			coupoun_quantity_limit,
			coupoun_used_quantity,
			conditions
		FROM
			(
				SELECT 
					KID,
					coupoun_name,
					coupoun_start_date,
					coupoun_end_date,
					coupoun_quantity_limit,
					coupoun_used_quantity,
					conditions,
					bill_phone_cus,
					SUM(bill_sum) AS sum_ -- tính tổng tiền của mỗi KH tham gia CTKM đó
				FROM ( -- lấy thông tin bill + km (nếu có) + KH ứng mỗi bill
					coupoun LEFT OUTER JOIN 
						(SELECT bill_sum, bill_phone_cus, bill_date -- lấy thông tin những bill có khuyến mãi
						FROM  
							-- join bill + bill_coupoun_bill để biết được bill nào có KM theo hóa đơn
							(csdl_database.bill LEFT OUTER JOIN csdl_database.bill_coupoun_bill ON csdl_database.bill.BID = csdl_database.bill_coupoun_bill.bill_BID)
							-- join tiếp với product_bill_info (price = 0 -> những bill đã apply KM tặng thêm) để biết được bill nào có KM theo Sản phẩm
							LEFT OUTER JOIN (SELECT * FROM product_bill_info WHERE product_bill_info_price = 0) AS pbi 
							ON csdl_database.bill.BID = pbi.product_bill_info_BID 
							WHERE
								coupoun_KID IS NOT NULL OR product_bill_info_BID IS NOT NULL
						) AS coupoun_all_bill ON bill_date >= coupoun_start_date AND bill_date <= coupoun_end_date
					)
					LEFT OUTER JOIN customer ON coupoun_all_bill.bill_phone_cus = customer.phone
				GROUP BY -- để xem mỗi CTKM có những ai tham gia
					KID,
					bill_phone_cus
			) AS coupoun_customer
		GROUP BY
			KID
		) AS ttt
		LEFT OUTER JOIN
		(
		SELECT
			bill_phone_cus,
			customer.`name` AS name_,
			SUM(bill_sum) AS sum_
		FROM (
				coupoun
				LEFT OUTER JOIN
				(
					SELECT bill_sum, bill_phone_cus, bill_date
					FROM 
						(bill LEFT OUTER JOIN bill_coupoun_bill ON BID = bill_BID)
						LEFT OUTER JOIN 
						(SELECT product_bill_info_BID FROM product_bill_info WHERE product_bill_info_price = 0) AS pbi 
						ON
							BID = product_bill_info_BID 
					WHERE
						coupoun_KID IS NOT NULL OR product_bill_info_BID IS NOT NULL
				) AS s
				ON bill_date >= coupoun_start_date AND bill_date <= coupoun_end_date
			)
			LEFT OUTER JOIN customer
			ON s.bill_phone_cus = customer.phone
		GROUP BY
			KID,
			bill_phone_cus
		) AS tss
		ON ttt.max_bill = tss.sum_
	WHERE
		(p_year = 0)
		OR YEAR(coupoun_start_date) = p_year
		OR YEAR(coupoun_end_date) = p_year
	HAVING
		sum_of_all_bill >= revenue
	ORDER BY
		KID ASC;
END //
DELIMITER ;

DELIMITER //


CREATE PROCEDURE display_detail_bill(IN billID INT)
BEGIN
	SELECT product_name, product_size, product_bill_info_quantity as quantity, product_bill_info_price as price, product_bill_info_quantity*product_bill_info_price AS total
	FROM bill b
	JOIN product_bill pb ON pb.bill_BID = b.BID
	JOIN product_bill_info pbi ON  pbi.product_bill_info_PID = pb.product_PID AND pbi.product_bill_info_BID = pb.bill_BID
    JOIN product ON pb.product_PID = PID
	LEFT JOIN bill_coupoun_bill bcb ON bcb.bill_BID  = pb.bill_BID
    WHERE BID = billID;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetCustomerData()
BEGIN
	SELECT BID, bill_sum,state, bill_store, bill_date,`name`, phone,bill_AID,coupoun_KID, discount_value
    FROM CSDL_database.bill
    JOIN customer ON bill_phone_cus = phone
    LEFT JOIN bill_coupoun_bill bcb ON bcb.bill_BID  = BID;
END//
DELIMITER ;