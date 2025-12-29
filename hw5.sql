USE mydb_hw3;
-- Task 1
SELECT od.*, (SELECT customer_id FROM orders AS o WHERE od.order_id = o.id) AS 'customer_id'
FROM order_details AS od;

-- Task 2
SELECT od.*
FROM order_details AS od
WHERE order_id IN (SELECT id FROM orders WHERE shipper_id = 3);

-- Tsk 3
SELECT od.order_id, AVG(od.quantity) as 'avg_quantity'
FROM (SELECT * FROM order_details WHERE quantity > 10) AS od
GROUP BY od.order_id;

-- Task 4
WITH temp AS (SELECT * FROM order_details WHERE quantity > 10)
SELECT order_id, AVG(quantity) as 'avg_quantity'
FROM temp
GROUP BY order_id;

-- Task 5
DROP FUNCTION  IF EXISTS quantity_divider;
DELIMITER //
CREATE FUNCTION `quantity_divider` (quantity FLOAT, divider FLOAT)
RETURNS FLOAT
NO SQL
DETERMINISTIC
BEGIN
DECLARE result FLOAT;
SET result = quantity / divider;
RETURN result;
END
//
DELIMITER ;
SELECT *, quantity_divider(od.quantity, 100) AS 'divided_quantity' FROM order_details AS od;