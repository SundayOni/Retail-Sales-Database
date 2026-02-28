-- =========================================
-- Retail Sales Database — Schema (3NF)
-- Microsoft SQL Server (T-SQL)
-- =========================================

CREATE DATABASE RetailSalesDB;
GO

USE RetailSalesDB;
GO

/* =========================================
   CORE TABLES
   ========================================= */

-- Customers: Stores customer demographic and contact information
CREATE TABLE customers (
    customer_id    INT IDENTITY(1,1) PRIMARY KEY,
    first_name     VARCHAR(50)  NOT NULL,
    last_name      VARCHAR(50)  NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    city           VARCHAR(100),
    created_date   DATE         NOT NULL DEFAULT GETDATE()
);

-- Products: Catalogue of products available for sale
CREATE TABLE products (
    product_id     INT IDENTITY(1,1) PRIMARY KEY,
    product_name   VARCHAR(100) NOT NULL,
    category       VARCHAR(50),
    unit_price     DECIMAL(10,2) NOT NULL CHECK (unit_price > 0)
);

-- Orders: Tracks all customer purchase transactions
CREATE TABLE orders (
    order_id       INT IDENTITY(1,1) PRIMARY KEY,
    customer_id    INT          NOT NULL,   -- FK → customers
    order_date     DATETIME     NOT NULL DEFAULT GETDATE(),
    order_status   VARCHAR(30)  NOT NULL,   -- e.g. Pending, Completed, Cancelled
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order_Items: Junction table linking orders to products (line items)
CREATE TABLE order_items (
    order_item_id  INT IDENTITY(1,1) PRIMARY KEY,
    order_id       INT           NOT NULL,  -- FK → orders
    product_id     INT           NOT NULL,  -- FK → products
    quantity       INT           NOT NULL CHECK (quantity > 0),
    unit_price     DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments: Records payment details for each order
CREATE TABLE payments (
    payment_id     INT IDENTITY(1,1) PRIMARY KEY,
    order_id       INT           NOT NULL,  -- FK → orders
    payment_date   DATETIME      NOT NULL DEFAULT GETDATE(),
    payment_method VARCHAR(50),             -- e.g. Card, PayPal, Bank Transfer
    amount         DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_status VARCHAR(30)   NOT NULL,  -- e.g. Paid, Pending, Failed
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

/* =========================================
   SUPPORTING TABLES
   ========================================= */

-- Suppliers: Tracks product suppliers for supply chain management
CREATE TABLE suppliers (
    supplier_id    INT IDENTITY(1,1) PRIMARY KEY,
    supplier_name  VARCHAR(100) NOT NULL,
    contact_name   VARCHAR(100),
    contact_email  VARCHAR(100),
    phone          VARCHAR(20),
    location       VARCHAR(100)
);

-- Inventory: Current stock levels per product, linked to supplier
CREATE TABLE inventory (
    product_id      INT  PRIMARY KEY,       -- FK + PK → products
    stock_quantity  INT  NOT NULL CHECK (stock_quantity >= 0),
    reorder_level   INT  NOT NULL CHECK (reorder_level >= 0),
    supplier_id     INT  NULL,              -- FK → suppliers
    last_updated    DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_inventory_supplier
        FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Inventory_Log: Historical record of all stock changes
CREATE TABLE inventory_log (
    log_id           INT IDENTITY(1,1) PRIMARY KEY,
    product_id       INT          NOT NULL,  -- FK → products
    change_quantity  INT          NOT NULL,  -- +ve = restock, -ve = sale/adjustment
    log_date         DATETIME     NOT NULL DEFAULT GETDATE(),
    reason           VARCHAR(100),           -- e.g. Sale, Restock, Return, Damage
    CONSTRAINT fk_inventorylog_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);
