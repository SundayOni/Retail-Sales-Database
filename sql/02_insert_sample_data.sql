-- Parent tables (Customers and Suppliers) have no foreign key dependencies
-- Inserted first to satisfy referential integrity


-- Customers
INSERT INTO Customers (FirstName, LastName, Email, City, CreatedDate)
VALUES
('John', 'Smith', 'john.smith@email.com', 'London', '2024-01-10'),
('Aisha', 'Khan', 'aisha.khan@email.com', 'Birmingham', '2024-01-15'),
('Michael', 'Brown', 'michael.brown@email.com', 'Manchester', '2024-02-01'),
('Emily', 'Johnson', 'emily.johnson@email.com', 'Leeds', '2024-02-12'),
('David', 'Wilson', 'david.wilson@email.com', 'Bristol', '2024-03-05');

-- Suppliers
INSERT INTO Suppliers (SupplierName, ContactEmail, Phone)
VALUES
('Global Tech Supplies', 'contact@globaltech.com', '02079460001'),
('HealthPlus Distributors', 'sales@healthplus.co.uk', '02079460002'),
('OfficeMart UK', 'support@officemart.co.uk', '02079460003');


-- Products
INSERT INTO Products (ProductName, Category, UnitPrice, SupplierID)
VALUES
('Wireless Keyboard', 'Electronics', 29.99, 1),
('Wireless Mouse', 'Electronics', 19.99, 1),
('Office Chair', 'Furniture', 149.99, 3),
('Standing Desk', 'Furniture', 399.99, 3),
('Blood Pressure Monitor', 'Healthcare', 59.99, 2),
('Digital Thermometer', 'Healthcare', 14.99, 2);

-- Inventory
INSERT INTO Inventory (ProductID, QuantityInStock, LastUpdated)
VALUES
(1, 120, GETDATE()),
(2, 200, GETDATE()),
(3, 45, GETDATE()),
(4, 20, GETDATE()),
(5, 80, GETDATE()),
(6, 150, GETDATE());

-- Orders
INSERT INTO Orders (CustomerID, OrderDate, OrderStatus)
VALUES
(1, '2024-03-10', 'Completed'),
(2, '2024-03-15', 'Completed'),
(3, '2024-04-01', 'Completed'),
(4, '2024-04-05', 'Completed'),
(5, '2024-04-18', 'Completed');

-- Order Items
INSERT INTO Order_Items (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 2, 29.99),
(1, 2, 1, 19.99),
(2, 3, 1, 149.99),
(3, 5, 2, 59.99),
(4, 4, 1, 399.99),
(5, 6, 3, 14.99);

-- Payments
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod)
VALUES
(1, '2024-03-10', 79.97, 'Card'),
(2, '2024-03-15', 149.99, 'Card'),
(3, '2024-04-01', 119.98, 'PayPal'),
(4, '2024-04-05', 399.99, 'Card'),
(5, '2024-04-18', 44.97, 'Card');

-- Inventory Log
INSERT INTO InventoryLog (ProductID, ChangeQuantity, ChangeDate, Reason)
VALUES
(1, -2, '2024-03-10', 'Customer Order'),
(2, -1, '2024-03-10', 'Customer Order'),
(3, -1, '2024-03-15', 'Customer Order'),
(5, -2, '2024-04-01', 'Customer Order'),
(4, -1, '2024-04-05', 'Customer Order'),
(6, -3, '2024-04-18', 'Customer Order');
