DELIMITER $$
CREATE PROCEDURE `sp_employee_insert`(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone_number VARCHAR(20),
    IN p_hire_date DATE,
    IN p_salary DECIMAL(10,2),
    IN p_department_id INT,
    IN p_manager_id INT,
    IN p_updated_by INT
)
BEGIN
    INSERT INTO `employee` (
        `first_name`,
        `last_name`,
        `email`,
        `phone_number`,
        `hire_date`,
        `salary`,
        `department_id`,
        `manager_id`,
        `created_at`,
        `updated_at`,
        `updated_by`
    ) VALUES (
        p_first_name,
        p_last_name,
        p_email,
        p_phone_number,
        p_hire_date,
        p_salary,
        p_department_id,
        p_manager_id,
        NOW(),
        NOW(),
        p_updated_by
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_employee_get_by_id`(
    IN p_id INT
)
BEGIN
    SELECT
        `id`,
        `first_name`,
        `last_name`,
        `email`,
        `phone_number`,
        `hire_date`,
        `salary`,
        `department_id`,
        `manager_id`
    FROM
        `employee`
    WHERE
        `id` = p_id AND `is_deleted` = FALSE;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_employee_update`(
    IN p_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone_number VARCHAR(20),
    IN p_salary DECIMAL(10,2),
    IN p_department_id INT,
    IN p_manager_id INT,
    IN p_updated_by INT
)
BEGIN
    UPDATE `employee`
    SET
        `first_name` = p_first_name,
        `last_name` = p_last_name,
        `email` = p_email,
        `phone_number` = p_phone_number,
        `salary` = p_salary,
        `department_id` = p_department_id,
        `manager_id` = p_manager_id,
        `updated_by` = p_updated_by
    WHERE
        `id` = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_employee_soft_delete`(
    IN p_id INT,
    IN p_updated_by INT
)
BEGIN
    UPDATE `employee`
    SET
        `is_deleted` = TRUE,
        `updated_by` = p_updated_by
    WHERE
        `id` = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_report_product_sales`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT
        p.`sku`,
        p.`name` AS `product_name`,
        SUM(oi.`quantity`) AS `total_units_sold`,
        SUM(oi.`unit_price` * oi.`quantity` * (1 - oi.`discount`)) AS `total_revenue`
    FROM
        `order_item` oi
    JOIN
        `product` p ON oi.`product_id` = p.`id`
    JOIN
        `customer_order` co ON oi.`order_id` = co.`id`
    WHERE
        co.`status` = 'Completed' AND
        DATE(co.`order_date`) BETWEEN p_start_date AND p_end_date
    GROUP BY
        p.`id`, p.`name`, p.`sku`
    ORDER BY
        `total_revenue` DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_customer_insert`(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone_number VARCHAR(20),
    IN p_address TEXT,
    IN p_updated_by INT
)
BEGIN
    INSERT INTO `customer` (
        `first_name`,
        `last_name`,
        `email`,
        `phone_number`,
        `address`,
        `created_at`,
        `updated_at`,
        `updated_by`
    ) VALUES (
        p_first_name,
        p_last_name,
            p_email,
    p_phone_number,
         p_address,
        NOW(),
       NOW(),
       p_updated_by
    );

    SELECT LAST_INSERT_ID();
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_customer_update`(
    IN p_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone_number VARCHAR(20),
    IN p_address TEXT,
    IN p_updated_by INT
)
BEGIN
    UPDATE `customer`
    SET
        `first_name` = p_first_name,
        `last_name` = p_last_name,
        `email` = p_email,
        `phone_number` = p_phone_number,
        `address` = p_address,
        `updated_at` = NOW(),
        `updated_by` = p_updated_by
    WHERE `id` = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_customer_soft_delete`(
    IN p_id INT,
    IN p_updated_by INT
)
BEGIN
    UPDATE `customer`
    SET `is_deleted` = TRUE, `updated_at` = NOW(), `updated_by` = p_updated_by
    WHERE `id` = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_product_insert`(
    IN p_name VARCHAR(255),
    IN p_sku VARCHAR(100),
    IN p_description TEXT,
    IN p_price DECIMAL(10,2),
    IN p_category_id INT,
    IN p_brand_id INT,
    IN p_updated_by INT
)
BEGIN
    INSERT INTO `product` (
        `name`,
        `sku`,
        `description`,
        `price`,
        `category_id`,
        `brand_id`,
        `created_at`,
        `updated_at`,
        `updated_by`
    ) VALUES (
        p_name,
          p_sku,
    p_description,
         p_price,
    p_category_id,
      p_brand_id,
    NOW(),
    NOW(),
    p_updated_by
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_product_update_price`(
    IN p_id INT,
    IN p_new_price DECIMAL(10,2),
    IN p_updated_by INT
)
BEGIN
    UPDATE `product`
    SET `price` = p_new_price, `updated_at` = NOW(), `updated_by` = p_updated_by
    WHERE `id` = p_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_order_create`(
    IN p_customer_id INT,
    IN p_employee_id INT,
    IN p_updated_by INT
)
BEGIN
    INSERT INTO `customer_order` (
        `customer_id`,
        `employee_id`,
        `order_date`,
        `status`,
        `total_amount`,
        `created_at`,
        `updated_at`,
        `updated_by`
    ) VALUES (
        p_customer_id,
        p_employee_id,
         NOW(),
           'Pending',
       0.00,
        NOW(),
        NOW(),
        p_updated_by
    );

    SELECT LAST_INSERT_ID() AS 'new_order_id';
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_order_add_item`(
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_unit_price DECIMAL(10,2),
    IN p_discount DECIMAL(5,2)
)
BEGIN
    INSERT INTO `order_item` (
        `order_id`,
        `product_id`,
        `quantity`,
        `unit_price`,
        `discount`
    ) VALUES (
        p_order_id,
      p_product_id,
        p_quantity,
       p_unit_price,
        p_discount
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_order_update_status`(
    IN p_order_id INT,
    IN p_new_status VARCHAR(50),
    IN p_updated_by INT
)
BEGIN
    UPDATE `customer_order`
    SET `status` = p_new_status, `updated_at` = NOW(), `updated_by` = p_updated_by
    WHERE `id` = p_order_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_order_update_total`(
    IN p_order_id INT,
    IN p_updated_by INT
)
BEGIN
    DECLARE v_new_total DECIMAL(10,2);

    SET v_new_total = `fn_calculate_order_total`(p_order_id);

    UPDATE `customer_order`
    SET
        `total_amount` = v_new_total,
        `updated_at` = NOW(),
        `updated_by` = p_updated_by
    WHERE
        `id` = p_order_id;
END$$
DELIMITER ;
