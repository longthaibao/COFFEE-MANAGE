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
