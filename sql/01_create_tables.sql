-- =========================================
-- Database Schema (3NF Normalised)
-- =========================================

/* =========================================
   Core Tables
   ========================================= */

-- Customers: Stores customer info
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    join_date DATE NOT NULL DEFAULT GETDATE()
);

-- Products: Catalog of products available for sale
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),    
    price DECIMAL(10,2) NOT NULL CHECK (price > 0)
);

-- Orders: Tracks all customer orders
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,                  -- links to customers
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    order_status VARCHAR(30) NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Order Items: Junction table linking products to orders
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,                     -- links to orders
    product_id INT NOT NULL,                   -- links to products
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Payments: Tracks payments for each order
CREATE TABLE payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,                     -- links to orders
    payment_date DATETIME NOT NULL DEFAULT GETDATE(),
    payment_method VARCHAR(50),                
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_status VARCHAR(30) NOT NULL,
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

/* =========================================
   Supporting Tables
   ========================================= */

-- Suppliers: Tracks product suppliers for supply chain management
CREATE TABLE suppliers (
    supplier_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(100),
    phone VARCHAR(20),
    location VARCHAR(100)
);

-- Inventory: Current stock of products, linked to suppliers
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,                -- links to products
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    reorder_level INT NOT NULL CHECK (reorder_level >= 0), -- trigger restock
    supplier_id INT NULL,
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_inventory_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
);

-- Inventory Log: Tracks historical stock changes for analytics
CREATE TABLE inventory_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,                   -- links to products
    change_quantity INT NOT NULL,              -- +ve for restock, -ve for sale
    log_date DATETIME NOT NULL DEFAULT GETDATE(),
    reason VARCHAR(100),                       -- e.g., Sale, Restock, Return
    CONSTRAINT fk_inventorylog_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
