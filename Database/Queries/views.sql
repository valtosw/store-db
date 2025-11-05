CREATE VIEW `view_active_employees` AS
SELECT
    e.`id`,
    e.`first_name`,
    e.`last_name`,
    e.`email`,
    e.`phone_number`,
    e.`hire_date`,
    d.`name` AS `department_name`
FROM
    `employee` e
JOIN
    `department` d ON e.`department_id` = d.`id`
WHERE
    e.`is_deleted` = FALSE;

CREATE VIEW `view_order_summary` AS
SELECT
    o.`id` AS `order_id`,
    o.`order_date`,
    c.`id` AS `customer_id`,
    CONCAT(c.`first_name`, ' ', c.`last_name`) AS `customer_name`,
    fn_get_employee_fullname(o.`employee_id`) AS `employee_name`,
    o.`status`,
    o.`total_amount`
FROM
    `customer_order` o
JOIN
    `customer` c ON o.`customer_id` = c.`id`
WHERE
    o.`is_deleted` = FALSE;

CREATE VIEW `view_low_stock_products` AS
SELECT
    p.`id` AS `product_id`,
    p.`sku`,
    p.`name` AS `product_name`,
    w.`name` AS `warehouse_name`,
    i.`quantity` AS `current_quantity`,
    i.`reorder_level`
FROM
    `inventory` i
JOIN
    `product` p ON i.`product_id` = p.`id`
JOIN
    `warehouse` w ON i.`warehouse_id` = w.`id`
WHERE
    i.`quantity` <= i.`reorder_level`
    AND p.`is_deleted` = FALSE;

CREATE VIEW `view_active_customers` AS
SELECT
    `id`,
    `first_name`,
    `last_name`,
    `email`,
    `phone_number`,
    `address`,
    `created_at`
FROM
    `customer`
WHERE
    `is_deleted` = FALSE;

CREATE VIEW `view_product_details` AS
SELECT
    p.`id`,
    p.`sku`,
    p.`name` AS `product_name`,
    p.`description`,
    p.`price`,
    c.`name` AS `category_name`,
    b.`name` AS `brand_name`
FROM
    `product` p
JOIN `category` c ON p.`category_id` = c.`id`
JOIN `brand` b ON p.`brand_id` = b.`id`
WHERE
    p.`is_deleted` = FALSE;
