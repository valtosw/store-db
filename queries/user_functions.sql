DELIMITER $$
CREATE FUNCTION `fn_get_employee_fullname`(
    p_employee_id INT
)
RETURNS VARCHAR(201)
DETERMINISTIC
BEGIN
    DECLARE v_fullname VARCHAR(201);
    SELECT CONCAT(`first_name`, ' ', `last_name`)
    INTO v_fullname
    FROM `employee`
    WHERE `id` = p_employee_id;
    RETURN v_fullname;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `fn_calculate_order_total`(
    p_order_id INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT SUM(`unit_price` * `quantity` * (1 - `discount`))
    INTO v_total
    FROM `order_item`
    WHERE `order_id` = p_order_id;
    RETURN IFNULL(v_total, 0.00);
END$$
DELIMITER ;
