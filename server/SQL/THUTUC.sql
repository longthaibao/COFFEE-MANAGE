
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
DELIMITER ;
