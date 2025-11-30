CREATE TABLE `attribute_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) UNIQUE NOT NULL
);

CREATE TABLE `product_attribute_value` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attribute_type_id` int NOT NULL,
  `value` text NOT NULL,
  CONSTRAINT `fk_pav_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pav_attribute_type` FOREIGN KEY (`attribute_type_id`) REFERENCES `attribute_type` (`id`)
);

DROP PROCEDURE IF EXISTS `sp_seed_product_attributes`;
DROP PROCEDURE IF EXISTS `sp_seed_all_attributes`;
DROP PROCEDURE IF EXISTS `sp_seed_products_bulk`;

SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE `product_attribute_value`;
TRUNCATE TABLE `attribute_type`;
TRUNCATE TABLE `product`;

INSERT INTO `attribute_type` (`id`, `name`) VALUES
(1, 'Screen Size'), (2, 'RAM'), (3, 'CPU'), (4, 'Storage'),
(5, 'Material'), (6, 'Color'), (7, 'Size'), (8, 'Author'), (9, 'Genre');

DELIMITER $$
CREATE PROCEDURE `sp_seed_products_bulk`()
BEGIN
    DECLARE i INT DEFAULT 1;
    SET unique_checks=0;

    WHILE i <= 10000 DO
        INSERT INTO `product` (`id`, `name`, `sku`, `description`, `price`, `category_id`, `brand_id`, `updated_by`)
        VALUES
        (i, CONCAT('Product Name ', i), CONCAT('SKU-', LPAD(i, 6, '0')), 'Auto-generated product description.', 19.99, 17, 20, 1);
        SET i = i + 1;
    END WHILE;

    SET unique_checks=1;
END$$
DELIMITER ;

CALL `sp_seed_products_bulk`();
DROP PROCEDURE `sp_seed_products_bulk`;
COMMIT;

DELIMITER $$
CREATE PROCEDURE `sp_seed_product_attributes`(IN productId INT)
BEGIN
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId, 1, '15.6 inches');
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId, 2, '16GB DDR4');
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId, 3, 'Quad-Core i9');
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId, 4, '1TB NVMe SSD');

    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId + 1, 5, '100% Cotton');
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId + 1, 6, 'Blue');
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId + 1, 7, 'Large');

    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId + 2, 8, 'Frank Herbert');
    INSERT INTO `product_attribute_value` (product_id, attribute_type_id, `value`) VALUES (productId + 2, 9, 'Science Fiction');
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `sp_seed_all_attributes`()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i < 9998 DO
        CALL `sp_seed_product_attributes`(i);
        SET i = i + 3;
    END WHILE;
END$$
DELIMITER ;

CALL `sp_seed_all_attributes`();

DROP PROCEDURE `sp_seed_product_attributes`;
DROP PROCEDURE `sp_seed_all_attributes`;

SET FOREIGN_KEY_CHECKS=1;
