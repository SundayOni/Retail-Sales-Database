-- =========================================
-- Retail Sales Database — Sample Data
-- Insert order follows FK dependency chain
-- =========================================

USE RetailSalesDB;
GO

/* =========================================
   1. CUSTOMERS (no FK dependencies)
   ========================================= */
INSERT INTO customers (first_name, last_name, email, city, created_date) VALUES
('John',    'Smith',    'john.smith@email.com',    'London',     '2024-01-10'),
('Aisha',   'Khan',     'aisha.khan@email.com',    'Birmingham', '2024-01-15'),
('Michael', 'Brown',    'michael.brown@email.com', 'Manchester', '2024-02-01'),
('Emily',   'Johnson',  'emily.johnson@email.com', 'Leeds',      '2024-02-12'),
('David',   'Wilson',   'david.wilson@email.com',  'Bristol',    '2024-03-05'),
('Fatima',  'Osei',     'fatima.osei@email.com',   'London',     '2024-03-20'),
('Liam',    'Taylor',   'liam.taylor@email.com',   'Glasgow',    '2024-04-02'),
('Priya',   'Patel',    'priya.patel@email.com',   'Leicester',  '2024-04-10');

/* =========================================
   2. SUPPLIERS (no FK dependencies)
   ========================================= */
INSERT INTO suppliers (supplier_name, contact_name, contact_email, phone, location) VALUES
('Global Tech Supplies',    'James Wright',  'contact@globaltech.com',   '02079460001', 'London'),
('HealthPlus Distributors', 'Sara Malik',    'sales@healthplus.co.uk',   '02079460002', 'Birmingham'),
('OfficeMart UK',           'Tom Reynolds',  'support@officemart.co.uk', '02079460003', 'Manchester');

/* =========================================
   3. PRODUCTS (no FK dependencies)
   ========================================= */
INSERT INTO products (product_name, category, unit_price) VALUES
('Wireless Keyboard',      'Electronics', 29.99),   -- product_id 1
('Wireless Mouse',         'Electronics', 19.99),   -- product_id 2
('Office Chair',           'Furniture',  149.99),   -- product_id 3
('Standing Desk',          'Furniture',  399.99),   -- product_id 4
('Blood Pressure Monitor', 'Healthcare',  59.99),   -- product_id 5
('Digital Thermometer',    'Healthcare',  14.99),   -- product_id 6
('USB-C Hub',              'Electronics', 44.99),   -- product_id 7
('Ergonomic Mouse Pad',    'Accessories',  9.99);   -- product_id 8

/* =========================================
   4. INVENTORY (depends on products + suppliers)
   ========================================= */
INSERT INTO inventory (product_id, stock_quantity, reorder_level, supplier_id) VALUES
(1, 120, 20, 1),
(2, 200, 30, 1),
(3,  45, 10, 3),
(4,  20,  5, 3),
(5,  80, 15, 2),
(6, 150, 25, 2),
(7,  60, 10, 1),
(8, 300, 50, 3);

/* =========================================
   5. ORDERS (depends on customers)
   ========================================= */
INSERT INTO orders (customer_id, order_date, order_status) VALUES
(1, '2024-03-10', 'Completed'),   -- order_id 1
(2, '2024-03-15', 'Completed'),   -- order_id 2
(3, '2024-04-01', 'Completed'),   -- order_id 3
(4, '2024-04-05', 'Completed'),   -- order_id 4
(5, '2024-04-18', 'Completed'),   -- order_id 5
(6, '2024-05-02', 'Completed'),   -- order_id 6
(7, '2024-05-10', 'Pending'),     -- order_id 7
(1, '2024-05-20', 'Completed'),   -- order_id 8 (repeat customer)
(3, '2024-06-01', 'Cancelled'),   -- order_id 9
(8, '2024-06-15', 'Completed');   -- order_id 10

/* =========================================
   6. ORDER_ITEMS (depends on orders + products)
   ========================================= */
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 29.99),   -- John buys 2x Wireless Keyboard
(1, 2, 1, 19.99),   -- John buys 1x Wireless Mouse
(2, 3, 1, 149.99),  -- Aisha buys 1x Office Chair
(3, 5, 2, 59.99),   -- Michael buys 2x BP Monitor
(4, 4, 1, 399.99),  -- Emily buys 1x Standing Desk
(5, 6, 3, 14.99),   -- David buys 3x Thermometer
(6, 7, 2, 44.99),   -- Fatima buys 2x USB-C Hub
(6, 8, 4,  9.99),   -- Fatima buys 4x Mouse Pad
(7, 1, 1, 29.99),   -- Liam buys 1x Wireless Keyboard (pending)
(8, 2, 2, 19.99),   -- John (repeat) buys 2x Wireless Mouse
(8, 7, 1, 44.99),   -- John (repeat) buys 1x USB-C Hub
(10,5, 1, 59.99),   -- Priya buys 1x BP Monitor
(10,6, 2, 14.99);   -- Priya buys 2x Thermometer

/* =========================================
   7. PAYMENTS (depends on orders)
   ========================================= */
INSERT INTO payments (order_id, payment_date, payment_method, amount, payment_status) VALUES
(1,  '2024-03-10', 'Card',          79.97, 'Paid'),
(2,  '2024-03-15', 'Card',         149.99, 'Paid'),
(3,  '2024-04-01', 'PayPal',       119.98, 'Paid'),
(4,  '2024-04-05', 'Card',         399.99, 'Paid'),
(5,  '2024-04-18', 'Card',          44.97, 'Paid'),
(6,  '2024-05-02', 'Bank Transfer', 129.94, 'Paid'),
(8,  '2024-05-20', 'Card',          84.97, 'Paid'),
(10, '2024-06-15', 'PayPal',        89.97, 'Paid');
-- Order 7 has no payment (Pending); Order 9 was Cancelled (no payment)

/* =========================================
   8. INVENTORY_LOG (depends on products)
   ========================================= */
INSERT INTO inventory_log (product_id, change_quantity, log_date, reason) VALUES
-- Sales deductions
(1, -2, '2024-03-10', 'Customer Order'),
(2, -1, '2024-03-10', 'Customer Order'),
(3, -1, '2024-03-15', 'Customer Order'),
(5, -2, '2024-04-01', 'Customer Order'),
(4, -1, '2024-04-05', 'Customer Order'),
(6, -3, '2024-04-18', 'Customer Order'),
(7, -2, '2024-05-02', 'Customer Order'),
(8, -4, '2024-05-02', 'Customer Order'),
(1, -1, '2024-05-10', 'Customer Order'),
(2, -2, '2024-05-20', 'Customer Order'),
(7, -1, '2024-05-20', 'Customer Order'),
(5, -1, '2024-06-15', 'Customer Order'),
(6, -2, '2024-06-15', 'Customer Order'),
-- Restocks
(3, +20, '2024-04-20', 'Supplier Restock'),
(4, +10, '2024-04-20', 'Supplier Restock'),
(8, +100,'2024-05-15', 'Supplier Restock');
