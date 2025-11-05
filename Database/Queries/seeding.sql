SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE `product_promotion`;
TRUNCATE TABLE `promotion`;
TRUNCATE TABLE `shipment`;
TRUNCATE TABLE `payment`;
TRUNCATE TABLE `order_item`;
TRUNCATE TABLE `customer_order`;
TRUNCATE TABLE `inventory`;
TRUNCATE TABLE `warehouse`;
TRUNCATE TABLE `product_supplier`;
TRUNCATE TABLE `product`;
TRUNCATE TABLE `brand`;
TRUNCATE TABLE `category`;
TRUNCATE TABLE `supplier`;
TRUNCATE TABLE `customer`;
TRUNCATE TABLE `employee_role`;
TRUNCATE TABLE `employee`;
TRUNCATE TABLE `role`;
TRUNCATE TABLE `department`;

INSERT INTO `department` (`id`, `name`, `description`) VALUES
(1, 'General Management', 'Overall store administration and leadership.'),
(2, 'Sales', 'Customer-facing sales floor staff.'),
(3, 'IT & Technical Support', 'Manages store systems, networks, and technical issues.'),
(4, 'Human Resources', 'Manages employee relations, payroll, and hiring.'),
(5, 'Marketing', 'Handles promotions, advertising, and public relations.'),
(6, 'Warehouse & Logistics', 'Manages inventory, stock, and shipments.'),
(7, 'Customer Service', 'Handles returns, inquiries, and customer support.');

INSERT INTO `role` (`id`, `name`, `description`) VALUES
(1, 'Store Manager', 'Manages all store operations and staff.'),
(2, 'Department Manager', 'Manages a specific department.'),
(3, 'Sales Associate', 'Assists customers and sells products.'),
(4, 'Cashier', 'Handles customer payments at checkout.'),
(5, 'Stock Clerk', 'Manages inventory on the sales floor and in the warehouse.'),
(6, 'IT Specialist', 'Provides technical support.'),
(7, 'HR Coordinator', 'Handles HR-related tasks.');

INSERT INTO `employee` (`id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `salary`, `department_id`, `manager_id`, `updated_by`) VALUES
(1, 'Admin', 'User', 'admin@store.com', '000-000-0000', '2020-01-01', 150000.00, 1, NULL, 1),
(2, 'Alice', 'Wonderland', 'alice.w@store.com', '111-222-3333', '2021-02-15', 95000.00, 1, 1, 1),
(3, 'Bob', 'Marley', 'bob.m@store.com', '222-333-4444', '2021-03-20', 72000.00, 2, 2, 1),
(4, 'Charlie', 'Chaplin', 'charlie.c@store.com', '333-444-5555', '2022-04-10', 52000.00, 2, 3, 1),
(5, 'Diana', 'Ross', 'diana.r@store.com', '444-555-6666', '2022-05-12', 48000.00, 2, 3, 1),
(6, 'Ethan', 'Hunt', 'ethan.h@store.com', '555-666-7777', '2021-06-18', 46000.00, 2, 3, 1),
(7, 'Fiona', 'Apple', 'fiona.a@store.com', '666-777-8888', '2023-01-25', 45000.00, 2, 3, 1),
(8, 'George', 'Lucas', 'george.l@store.com', '777-888-9999', '2021-07-30', 85000.00, 3, 2, 1),
(9, 'Hellen', 'Keller', 'hellen.k@store.com', '888-999-0000', '2022-08-14', 68000.00, 3, 8, 1),
(10, 'Indiana', 'Jones', 'indiana.j@store.com', '999-000-1111', '2021-09-05', 78000.00, 4, 2, 1),
(11, 'Jack', 'Sparrow', 'jack.s@store.com', '000-111-2222', '2023-02-20', 65000.00, 4, 10, 1),
(12, 'Karen', 'Carpenter', 'karen.c@store.com', '111-222-3334', '2021-10-15', 76000.00, 5, 2, 1),
(13, 'Luke', 'Skywalker', 'luke.s@store.com', '222-333-4445', '2022-11-22', 42000.00, 6, 15, 1),
(14, 'Mary', 'Poppins', 'mary.p@store.com', '333-444-5556', '2023-03-30', 41000.00, 6, 15, 1),
(15, 'Neo', 'Anderson', 'neo.a@store.com', '444-555-6667', '2021-12-01', 82000.00, 6, 2, 1),
(16, 'Olivia', 'Newton-John', 'olivia.nj@store.com', '555-666-7778', '2022-01-19', 43000.00, 6, 15, 1),
(17, 'Peter', 'Pan', 'peter.p@store.com', '666-777-8889', '2023-04-05', 40000.00, 6, 15, 1),
(18, 'Quentin', 'Tarantino', 'quentin.t@store.com', '777-888-9990', '2022-02-28', 73000.00, 7, 2, 1),
(19, 'Rocky', 'Balboa', 'rocky.b@store.com', '888-999-0001', '2023-05-16', 51000.00, 7, 18, 1),
(20, 'Sarah', 'Connor', 'sarah.c@store.com', '999-000-1112', '2023-06-21', 49000.00, 7, 18, 1),
(21, 'Tony', 'Stark', 'tony.stark@store.com', '012-345-6789', '2023-07-01', 55000.00, 2, 3, 1);


INSERT INTO `employee_role` (`employee_id`, `role_id`) VALUES
(1, 1), (2, 1), (3, 2), (4, 3), (5, 3), (6, 4), (7, 4), (8, 2), (9, 6), (10, 2), (11, 7),
(12, 2), (13, 5), (14, 5), (15, 2), (16, 5), (17, 5), (18, 2), (19, 3), (20, 3), (21, 3);

INSERT INTO `customer` (`first_name`, `last_name`, `email`, `phone_number`, `address`, `updated_by`) VALUES
('Walter', 'White', 'heisenberg@example.com', '505-111-2222', '308 Negra Arroyo Lane, Albuquerque, NM', 1),
('Jesse', 'Pinkman', 'capncook@example.com', '505-222-3333', '9809 Margo St, Albuquerque, NM', 1),
('Skyler', 'White', 'skyler.w@example.com', '505-333-4444', '308 Negra Arroyo Lane, Albuquerque, NM', 1),
('Hank', 'Schrader', 'hank.s@example.com', '505-444-5555', '4901 Cumbre Del Sur Ct NE, Albuquerque, NM', 1),
('Saul', 'Goodman', 'saul.g@example.com', '505-555-6666', '9800 Montgomery Blvd NE, Albuquerque, NM', 1),
('Michael', 'Scott', 'michael.s@example.com', '570-111-2222', '1725 Slough Avenue, Scranton, PA', 1),
('Dwight', 'Schrute', 'dwight.s@example.com', '570-222-3333', 'Schrute Farms, Honesdale, PA', 1),
('Jim', 'Halpert', 'jim.h@example.com', '570-333-4444', '123 Main Street, Scranton, PA', 1),
('Pam', 'Beesly', 'pam.b@example.com', '570-444-5555', '123 Main Street, Scranton, PA', 1),
('Tony', 'Soprano', 'tony.s@example.com', '201-111-2222', '633 Stag Trail Road, North Caldwell, NJ', 1),
('Don', 'Draper', 'don.d@example.com', '212-111-2222', '100 Park Avenue, New York, NY', 1),
('Peggy', 'Olson', 'peggy.o@example.com', '212-222-3333', '300 W 23rd Street, New York, NY', 1),
('Rick', 'Grimes', 'rick.g@example.com', '404-111-2222', '1 Main Street, Alexandria, VA', 1),
('Daryl', 'Dixon', 'daryl.d@example.com', '404-222-3333', 'The Sanctuary, Washington, D.C.', 1),
('Walter', 'Sobchak', 'walter.s@example.com', '310-111-2222', '123 Venice Blvd, Los Angeles, CA', 1),
('Jeff', 'Lebowski', 'the.dude@example.com', '310-222-3333', '609 Venezia Ave, Venice, CA', 1),
('Homer', 'Simpson', 'homer.s@example.com', '939-111-2222', '742 Evergreen Terrace, Springfield', 1),
('Marge', 'Simpson', 'marge.s@example.com', '939-222-3333', '742 Evergreen Terrace, Springfield', 1),
('Bart', 'Simpson', 'bart.s@example.com', '939-333-4444', '742 Evergreen Terrace, Springfield', 1),
('Lisa', 'Simpson', 'lisa.s@example.com', '939-444-5555', '742 Evergreen Terrace, Springfield', 1);

INSERT INTO `supplier` (`name`, `contact_person`, `email`, `phone_number`, `address`, `updated_by`) VALUES
('ElectroSource Inc.', 'Eleanor Vance', 'contact@electrosource.com', '800-555-0100', '100 Tech Park, Silicon Valley, CA', 1),
('Global Gadgets Ltd.', 'Gary Norton', 'sales@globalgadgets.com', '800-555-0101', '200 Innovation Dr, Austin, TX', 1),
('Component Kings', 'Connie Riel', 'support@componentkings.com', '800-555-0102', '300 Circuit Ave, Boston, MA', 1),
('Fashion Forward', 'Felicia Hardy', 'orders@fashionforward.com', '800-555-0103', '400 Style St, New York, NY', 1),
('Denim Dreams Co.', 'Derek Hale', 'info@denimdreams.com', '800-555-0104', '500 Jean Blvd, Los Angeles, CA', 1),
('Home Essentials', 'Holly Epps', 'contact@homeessentials.com', '800-555-0105', '600 Comfort Ln, Chicago, IL', 1),
('Kitchen Kraft', 'Kevin Finn', 'sales@kitchenkraft.com', '800-555-0106', '700 Gourmet Way, San Francisco, CA', 1),
('Bookworm Bargains', 'Brenda Walsh', 'books@bookworm.com', '800-555-0107', '800 Reading Rd, Portland, OR', 1),
('Office Outfitters', 'Oscar Martinez', 'supplies@officeoutfitters.com', '800-555-0108', '900 Paper St, Scranton, PA', 1),
('Toyland Treasures', 'Timmy Turner', 'fun@toyland.com', '800-555-0109', '1010 Playful Pl, Orlando, FL', 1),
('Sports Supreme', 'Serena Williams', 'gear@sportssupreme.com', '800-555-0110', '2020 Champion Ct, Miami, FL', 1),
('Garden Gear', 'Gus Green', 'plants@gardengear.com', '800-555-0111', '3030 Blossom Blvd, Denver, CO', 1),
('Auto Aces', 'Alex Armstrong', 'parts@autoaces.com', '800-555-0112', '4040 Motor Way, Detroit, MI', 1),
('Pet Paradise', 'Penny Paws', 'contact@petparadise.com', '800-555-0113', '5050 Canine Ct, San Diego, CA', 1),
('Music Mania', 'Melody Maker', 'sales@musicmania.com', '800-555-0114', '6060 Rhythm Rd, Nashville, TN', 1),
('Health Hub', 'Herb Healer', 'support@healthhub.com', '800-555-0115', '7070 Wellness Way, Boulder, CO', 1),
('Beauty Bliss', 'Bella Blanc', 'orders@beautybliss.com', '800-555-0116', '8080 Glamour Grove, Beverly Hills, CA', 1),
('Craft Corner', 'Casey Craft', 'info@craftcorner.com', '800-555-0117', '9090 Hobby Hill, Minneapolis, MN', 1),
('Movie Buffs Inc.', 'Martin Scorsese', 'films@moviebuffs.com', '800-555-0118', '111 Film Row, Hollywood, CA', 1),
('Gamer''s Guild', 'Gabe Newell', 'games@gamersguild.com', '800-555-0119', '222 Pixel Pl, Seattle, WA', 1);

INSERT INTO `category` (`id`, `name`, `description`, `parent_category_id`, `updated_by`) VALUES
(1, 'Electronics', 'Gadgets and consumer electronics.', NULL, 1),
(2, 'Computers', 'Laptops, desktops, and accessories.', 1, 1),
(3, 'Smartphones', 'Mobile phones and accessories.', 1, 1),
(4, 'Audio', 'Headphones, speakers, and audio equipment.', 1, 1),
(5, 'Laptops', 'Portable computers.', 2, 1),
(6, 'Monitors', 'Computer displays.', 2, 1),
(7, 'Keyboards', 'Input devices for computers.', 2, 1),
(8, 'Clothing', 'Apparel for men, women, and children.', NULL, 1),
(9, 'Men''s Clothing', 'Clothing for men.', 8, 1),
(10, 'Women''s Clothing', 'Clothing for women.', 8, 1),
(11, 'T-Shirts', 'Casual tops.', 9, 1),
(12, 'Jeans', 'Denim pants.', 9, 1),
(13, 'Dresses', 'One-piece garments for women.', 10, 1),
(14, 'Home & Kitchen', 'Items for home and kitchen use.', NULL, 1),
(15, 'Cookware', 'Pots, pans, and baking dishes.', 14, 1),
(16, 'Bedding', 'Sheets, pillows, and comforters.', 14, 1),
(17, 'Books', 'Fiction, non-fiction, and educational books.', NULL, 1),
(18, 'Science Fiction', 'Books with futuristic or imaginative themes.', 17, 1),
(19, 'Biographies', 'Life stories of individuals.', 17, 1),
(20, 'Sports & Outdoors', 'Sporting goods and outdoor equipment.', NULL, 1);

INSERT INTO `brand` (`id`, `name`, `updated_by`) VALUES
(1, 'TechNexa', 1), (2, 'SoundWave', 1), (3, 'PixelPerfect', 1), (4, 'StyleSphere', 1),
(5, 'UrbanThread', 1), (6, 'ComfyHome', 1), (7, 'GourmetPro', 1), (8, 'PageTurner', 1),
(9, 'ActiveLife', 1), (10, 'EcoGrowth', 1), (11, 'PowerUp', 1), (12, 'PetPal', 1),
(13, 'TuneCraft', 1), (14, 'VitaBoost', 1), (15, 'GlamourGlow', 1), (16, 'CreateIt', 1),
(17, 'CineMagic', 1), (18, 'GameOn', 1), (19, 'Generic', 1), (20, 'StoreBrand', 1);

INSERT INTO `product` (`name`, `sku`, `description`, `price`, `category_id`, `brand_id`, `updated_by`) VALUES
('ProBook X1', 'LP-TN-001', 'High-performance laptop for professionals.', 1499.99, 5, 1, 1),
('StealthBook Air', 'LP-TN-002', 'Ultra-thin and lightweight laptop.', 1199.99, 5, 1, 1),
('Gamer''s Edge Pro', 'LP-GO-001', 'Gaming laptop with top-tier graphics.', 1999.99, 5, 18, 1),
('CrystalView 27" 4K', 'MN-PP-001', '27-inch 4K UHD monitor.', 449.99, 6, 3, 1),
('MechaniKey Pro', 'KB-GO-001', 'Mechanical keyboard for gamers.', 129.99, 7, 18, 1),
('SmartPhone Z', 'SP-TN-001', 'Latest generation smartphone.', 999.99, 3, 1, 1),
('SoundWave Buds+', 'HP-SW-001', 'True wireless earbuds with noise cancellation.', 149.99, 4, 2, 1),
('SoundWave Roar', 'SPK-SW-001', 'Portable Bluetooth speaker.', 89.99, 4, 2, 1),
('Classic Crew T-Shirt', 'TS-UT-001', 'Soft and comfortable cotton t-shirt.', 24.99, 11, 5, 1),
('UrbanFlex Jeans', 'JN-UT-001', 'Stretchable and stylish jeans.', 79.99, 12, 5, 1),
('Summer Breeze Dress', 'DR-SS-001', 'Light and airy summer dress.', 59.99, 13, 4, 1),
('Pro-Grade Skillet', 'CW-GP-001', '12-inch non-stick skillet.', 49.99, 15, 7, 1),
('CloudComfort Sheet Set', 'BD-CH-001', 'Queen-size microfiber sheet set.', 69.99, 16, 6, 1),
('Dune', 'BK-PT-001', 'Classic science fiction novel by Frank Herbert.', 19.99, 18, 8, 1),
('Steve Jobs Biography', 'BK-PT-002', 'Biography by Walter Isaacson.', 29.99, 19, 8, 1),
('Pro Yoga Mat', 'SO-AL-001', 'Eco-friendly yoga mat.', 39.99, 20, 9, 1),
('HydroFlask 32oz', 'SO-AL-002', 'Insulated water bottle.', 44.99, 20, 9, 1),
('SmartPhone Z Case', 'AC-GN-001', 'Protective case for SmartPhone Z.', 19.99, 3, 19, 1),
('Wireless Mouse M3', 'AC-TN-001', 'Ergonomic wireless mouse.', 29.99, 2, 1, 1),
('StoreBrand Coffee Mug', 'HK-SB-001', '12oz ceramic coffee mug.', 9.99, 15, 20, 1),
('StoreBrand Pen Pack', 'OF-SB-001', '10-pack of black ink pens.', 4.99, 17, 20, 1);

INSERT INTO `warehouse` (`id`, `name`, `location`, `updated_by`) VALUES
(1, 'Main Warehouse', '1000 Distribution Way, Central City, USA', 1),
(2, 'North Store Backroom', '123 North Main St, North City, USA', 1),
(3, 'Online Fulfillment Center', '2000 E-commerce Drive, Cyber City, USA', 1);

INSERT INTO `inventory` (`product_id`, `warehouse_id`, `quantity`, `updated_by`) VALUES
(1, 1, 150, 1), (1, 2, 25, 1), (1, 3, 200, 1),
(2, 1, 200, 1), (2, 2, 40, 1), (2, 3, 300, 1),
(3, 1, 100, 1), (3, 3, 150, 1),
(4, 1, 250, 1), (4, 2, 50, 1), (4, 3, 400, 1),
(5, 1, 300, 1), (5, 3, 500, 1),
(6, 1, 400, 1), (6, 2, 100, 1), (6, 3, 800, 1),
(7, 1, 500, 1), (7, 2, 150, 1), (7, 3, 1000, 1),
(8, 1, 450, 1), (8, 2, 120, 1), (8, 3, 900, 1),
(9, 1, 1000, 1), (9, 2, 300, 1), (9, 3, 2000, 1),
(10, 1, 800, 1), (10, 2, 250, 1), (10, 3, 1500, 1),
(11, 1, 600, 1), (11, 2, 150, 1), (11, 3, 1000, 1),
(12, 1, 750, 1), (12, 2, 200, 1), (12, 3, 1200, 1),
(13, 1, 900, 1), (13, 2, 220, 1), (13, 3, 1800, 1),
(14, 1, 1200, 1), (14, 3, 3000, 1),
(15, 1, 1100, 1), (15, 3, 2500, 1),
(16, 1, 800, 1), (16, 2, 180, 1), (16, 3, 1400, 1),
(17, 1, 950, 1), (17, 2, 210, 1), (17, 3, 1600, 1),
(18, 1, 1500, 1), (18, 3, 4000, 1),
(19, 1, 1300, 1), (19, 3, 3500, 1),
(20, 1, 2000, 1), (20, 2, 500, 1), (20, 3, 5000, 1),
(21, 1, 2500, 1), (21, 2, 800, 1), (21, 3, 6000, 1);

INSERT INTO `customer_order` (`customer_id`, `employee_id`, `order_date`, `status`, `total_amount`, `updated_by`) VALUES
(1, 4, '2023-10-01 10:30:00', 'Completed', 1649.98, 1),
(2, 5, '2023-10-01 11:45:00', 'Completed', 149.99, 1),
(3, 4, '2023-10-02 14:00:00', 'Completed', 24.99, 1),
(4, 6, '2023-10-03 09:15:00', 'Completed', 59.99, 1),
(5, 7, '2023-10-04 16:20:00', 'Shipped', 49.99, 1),
(6, 4, '2023-10-05 13:00:00', 'Completed', 129.99, 1),
(7, 5, '2023-10-06 18:00:00', 'Pending', 79.99, 1),
(8, 4, '2023-10-07 10:50:00', 'Completed', 44.99, 1),
(9, 6, '2023-10-08 12:30:00', 'Completed', 29.99, 1),
(10, 7, '2023-10-09 11:00:00', 'Shipped', 999.99, 1),
(11, 4, '2023-10-10 15:10:00', 'Completed', 109.98, 1),
(12, 5, '2023-10-11 19:00:00', 'Pending', 19.99, 1),
(13, 4, '2023-10-12 09:45:00', 'Completed', 44.99, 1),
(14, 6, '2023-10-13 17:25:00', 'Completed', 19.99, 1),
(15, 7, '2023-10-14 14:40:00', 'Shipped', 2029.98, 1),
(16, 4, '2023-10-15 11:55:00', 'Completed', 69.99, 1),
(17, 5, '2023-10-16 10:10:00', 'Pending', 9.99, 1),
(18, 4, '2023-10-17 12:00:00', 'Completed', 4.99, 1),
(19, 6, '2023-10-18 13:30:00', 'Completed', 39.99, 1),
(20, 7, '2023-10-19 16:00:00', 'Shipped', 89.99, 1);

INSERT INTO `order_item` (`order_id`, `product_id`, `quantity`, `unit_price`, `discount`) VALUES
(1, 1, 1, 1499.99, 0.0), (1, 19, 1, 29.99, 0.0), (1, 18, 1, 19.99, 0.0), -- W. White buys a laptop and accessories
(2, 7, 1, 149.99, 0.0), -- J. Pinkman buys headphones
(3, 9, 1, 24.99, 0.0), -- S. White buys a T-Shirt
(4, 11, 1, 59.99, 0.0), -- H. Schrader buys a dress
(5, 12, 1, 49.99, 0.0), -- S. Goodman buys a skillet
(6, 5, 1, 129.99, 0.0), -- M. Scott buys a keyboard
(7, 10, 1, 79.99, 0.0), -- D. Schrute buys jeans
(8, 8, 2, 22.50, 0.0), -- J. Halpert buys two speakers (on sale)
(9, 15, 1, 29.99, 0.0), -- P. Beesly buys a biography
(10, 6, 1, 999.99, 0.0), -- T. Soprano buys a smartphone
(11, 10, 1, 79.99, 0.0), (11, 9, 1, 29.99, 0.0), -- D. Draper buys clothes
(12, 14, 1, 19.99, 0.0), -- P. Olson buys a book
(13, 17, 1, 44.99, 0.0), -- R. Grimes buys a water bottle
(14, 18, 1, 19.99, 0.0), -- D. Dixon buys a phone case
(15, 3, 1, 1999.99, 0.0), (15, 20, 1, 29.99, 0.0), -- W. Sobchak buys a gaming laptop and mouse
(16, 13, 1, 69.99, 0.0), -- J. Lebowski buys bedding
(17, 20, 1, 9.99, 0.0), -- H. Simpson buys a mug
(18, 21, 1, 4.99, 0.0), -- M. Simpson buys pens
(19, 16, 1, 39.99, 0.0), -- B. Simpson buys a yoga mat
(20, 8, 1, 89.99, 0.0); -- L. Simpson buys a speaker

INSERT INTO `payment` (`order_id`, `amount`, `payment_method`, `transaction_id`, `updated_by`) VALUES
(1, 1649.98, 'Credit Card', 'txn_1_cc', 1),
(2, 149.99, 'Debit Card', 'txn_2_dc', 1),
(3, 24.99, 'Cash', 'txn_3_cash', 1),
(4, 59.99, 'Credit Card', 'txn_4_cc', 1),
(6, 129.99, 'Credit Card', 'txn_6_cc', 1),
(8, 44.99, 'Cash', 'txn_8_cash', 1),
(9, 29.99, 'Debit Card', 'txn_9_dc', 1),
(11, 109.98, 'Credit Card', 'txn_11_cc', 1),
(13, 44.99, 'Credit Card', 'txn_13_cc', 1),
(14, 19.99, 'Cash', 'txn_14_cash', 1),
(16, 69.99, 'Debit Card', 'txn_16_dc', 1),
(18, 4.99, 'Cash', 'txn_18_cash', 1),
(19, 39.99, 'Credit Card', 'txn_19_cc', 1);

INSERT INTO `shipment` (`order_id`, `shipment_date`, `tracking_number`, `address`, `status`, `updated_by`) VALUES
(5, '2023-10-05 09:00:00', '1Z999AA10123456784', '9800 Montgomery Blvd NE, Albuquerque, NM', 'Delivered', 1),
(10, '2023-10-10 08:30:00', '1Z999AA10123456785', '633 Stag Trail Road, North Caldwell, NJ', 'Delivered', 1),
(15, '2023-10-15 10:00:00', '1Z999AA10123456786', '123 Venice Blvd, Los Angeles, CA', 'Shipped', 1),
(20, '2023-10-20 11:00:00', '1Z999AA10123456787', '742 Evergreen Terrace, Springfield', 'Processing', 1);

INSERT INTO `promotion` (`name`, `description`, `start_date`, `end_date`, `discount_percentage`, `updated_by`) VALUES
('Fall Electronics Sale', '15% off select electronics.', '2023-10-01 00:00:00', '2023-10-31 23:59:59', 15.00, 1),
('Back to School Books', '20% off all books in the biography category.', '2023-08-15 00:00:00', '2023-09-15 23:59:59', 20.00, 1),
('Summer Fashion Clearout', '30% off select summer clothing.', '2023-09-01 00:00:00', '2023-09-30 23:59:59', 30.00, 1);

INSERT INTO `product_promotion` (`product_id`, `promotion_id`) VALUES
(1, 1), (2, 1), (4, 1), (6, 1), (7, 1), (8, 1),
(15, 2),
(11, 3);

SET FOREIGN_KEY_CHECKS=1;
