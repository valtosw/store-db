CREATE TABLE `department` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) UNIQUE NOT NULL,
  `description` text,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `role` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) UNIQUE NOT NULL,
  `description` text,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `employee` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `phone_number` varchar(20),
  `hire_date` date NOT NULL,
  `salary` decimal(10,2),
  `department_id` int NOT NULL,
  `manager_id` int,
  `is_deleted` boolean NOT NULL DEFAULT false,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `employee_role` (
  `employee_id` int NOT NULL,
  `role_id` int NOT NULL,
  `assigned_at` datetime NOT NULL DEFAULT (now()),
  PRIMARY KEY (`employee_id`, `role_id`)
);

CREATE TABLE `customer` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `phone_number` varchar(20),
  `address` text,
  `is_deleted` boolean NOT NULL DEFAULT false,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `supplier` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) UNIQUE NOT NULL,
  `contact_person` varchar(255),
  `email` varchar(255) UNIQUE NOT NULL,
  `phone_number` varchar(20),
  `address` text,
  `is_deleted` boolean NOT NULL DEFAULT false,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `category` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) UNIQUE NOT NULL,
  `description` text,
  `parent_category_id` int,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `brand` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) UNIQUE NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `product` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sku` varchar(100) UNIQUE NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `is_deleted` boolean NOT NULL DEFAULT false,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `product_supplier` (
  `product_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `cost_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`product_id`, `supplier_id`)
);

CREATE TABLE `warehouse` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `inventory` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT 0,
  `reorder_level` int NOT NULL DEFAULT 10,
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `customer_order` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `order_date` datetime NOT NULL DEFAULT (now()),
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `total_amount` decimal(10,2) NOT NULL,
  `is_deleted` boolean NOT NULL DEFAULT false,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `order_item` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `discount` decimal(5,2) DEFAULT 0
);

CREATE TABLE `payment` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `order_id` int UNIQUE NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT (now()),
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `transaction_id` varchar(255) UNIQUE,
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `shipment` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `shipment_date` datetime,
  `tracking_number` varchar(255),
  `address` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Processing',
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `promotion` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `discount_percentage` decimal(5,2) NOT NULL,
  `is_deleted` boolean NOT NULL DEFAULT false,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT (now()),
  `updated_by` int
);

CREATE TABLE `product_promotion` (
  `product_id` int NOT NULL,
  `promotion_id` int NOT NULL,
  PRIMARY KEY (`product_id`, `promotion_id`)
);

CREATE INDEX `idx_employee_full_name` ON `employee` (`first_name`, `last_name`);
CREATE INDEX `idx_employee_email` ON `employee` (`email`);
CREATE INDEX `idx_customer_email` ON `customer` (`email`);
CREATE INDEX `idx_product_sku` ON `product` (`sku`);
CREATE FULLTEXT INDEX `ft_product_name` ON `product` (`name`);
CREATE UNIQUE INDEX `uk_inventory_product_warehouse` ON `inventory` (`product_id`, `warehouse_id`);
CREATE INDEX `idx_order_order_date` ON `customer_order` (`order_date`);
CREATE UNIQUE INDEX `uk_order_item_order_product` ON `order_item` (`order_id`, `product_id`);

ALTER TABLE `department` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `role` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `customer` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `supplier` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `category` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `brand` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `product` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `warehouse` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `inventory` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `customer_order` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `payment` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `shipment` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `promotion` ADD FOREIGN KEY (`updated_by`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
ALTER TABLE `employee` ADD CONSTRAINT `fk_employee_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`);
ALTER TABLE `employee` ADD CONSTRAINT `fk_employee_manager` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`id`);
ALTER TABLE `employee_role` ADD CONSTRAINT `fk_employee_role_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`);
ALTER TABLE `employee_role` ADD CONSTRAINT `fk_employee_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
ALTER TABLE `product` ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
ALTER TABLE `category` ADD CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`id`);
ALTER TABLE `product` ADD CONSTRAINT `fk_product_brand` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`);
ALTER TABLE `product_supplier` ADD CONSTRAINT `fk_product_supplier_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
ALTER TABLE `product_supplier` ADD CONSTRAINT `fk_product_supplier_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`);
ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`);
ALTER TABLE `customer_order` ADD CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);
ALTER TABLE `customer_order` ADD CONSTRAINT `fk_order_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`);
ALTER TABLE `order_item` ADD CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`id`);
ALTER TABLE `order_item` ADD CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
ALTER TABLE `payment` ADD CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`id`);
ALTER TABLE `shipment` ADD CONSTRAINT `fk_shipment_order` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`id`);
ALTER TABLE `product_promotion` ADD CONSTRAINT `fk_product_promotion_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
ALTER TABLE `product_promotion` ADD CONSTRAINT `fk_product_promotion_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotion` (`id`);

