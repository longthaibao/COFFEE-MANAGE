USE CSDL_database;

DELIMITER //
CREATE PROCEDURE show_notification(IN custom_message VARCHAR(255))
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = custom_message;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_sl_dk
BEFORE INSERT
ON coupoun_product
FOR EACH ROW
BEGIN
    DECLARE K_condition INT;
    SELECT conditions INTO K_condition FROM coupoun WHERE KID = NEW.KID;
    IF K_condition < NEW.coupoun_product_quantity THEN
        CALL show_notification('Inserted value must be smaller than the value in the coupoun table');
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_end
BEFORE INSERT
ON coupoun
FOR EACH ROW
BEGIN
    DECLARE diff INT;
    SET diff = DATEDIFF(NEW.coupoun_end_date, NEW.coupoun_start_date);
    IF diff > 30 THEN
        CALL show_notification('The coupon end date must not exceed one month from the coupon start date');
    END IF;
END;
//
DELIMITER ;


-- syntax oke, chua check work hay kh

DELIMITER //
CREATE TRIGGER check_product_coupoun
AFTER INSERT 
ON product_bill_info
FOR EACH ROW
BEGIN
    DECLARE _KID INT;
    DECLARE dk INT;
    SELECT coupoun_KID INTO _KID FROM product_coupoun_product WHERE product_PID = NEW.product_bill_info_PID;

    IF _KID IS NULL THEN
        CALL show_notification('There is no coupon for this product');
    ELSE 
        SELECT conditions INTO dk FROM coupoun WHERE KID = _KID;
        
        IF NEW.product_bill_info_quantity > dk THEN
            CALL show_notification('You meet the condition for this product');
        ELSE 
            CALL show_notification('You did not meet the condition for this product, buy more?');
        END IF;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_time
BEFORE INSERT
ON time_store
FOR EACH ROW
BEGIN
    DECLARE diff_minutes INT;
    SET diff_minutes = TIMESTAMPDIFF(HOUR, NEW.close_time, NEW.open_time);
    IF diff_minutes <= 4 THEN
        CALL show_notification('Closing time must be at least 4 hours after opening time.');
    END IF;
END;
//
DELIMITER ;
