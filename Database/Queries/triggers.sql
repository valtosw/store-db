DELIMITER $$
CREATE TRIGGER `trg_employee_before_update`
BEFORE UPDATE ON `employee`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = NOW();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `trg_product_before_update`
BEFORE UPDATE ON `product`
FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = NOW();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `trg_order_item_after_insert`
AFTER INSERT ON `order_item`
FOR EACH ROW
BEGIN
    UPDATE `inventory`
    SET `quantity` = `quantity` - NEW.`quantity`
    WHERE `product_id` = NEW.`product_id` AND `warehouse_id` = 1; -- Assuming a default warehouse for sales
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `trg_payment_after_insert`
AFTER INSERT ON `payment`
FOR EACH ROW
BEGIN
    UPDATE `customer_order`
    SET
        `status` = 'Completed',
        `updated_at` = NOW(),
        `updated_by` = NEW.`updated_by`
    WHERE
        `id` = NEW.`order_id`;
END$$
DELIMITER ;
