# Retail Sales Database (SQL Server)

## Overview
This project is a **Retail Sales Database** designed to simulate a real-world transactional system used in retail, e-commerce, consulting, and public-sector analytics environments.

The database supports:
- Sales analysis
- Customer insights
- Inventory management
- Revenue reporting
- Supply chain monitoring

It is built using **Microsoft SQL Server (T-SQL)** and follows **relational database best practices**.

---

## Business Problem
Retail organisations need reliable, well-structured data to:
- Track customer purchases
- Monitor product performance
- Identify high-value customers
- Detect low-stock inventory risks
- Analyse revenue trends over time

This database models a normalised retail system that enables analysts and decision-makers to answer these questions efficiently using SQL.

---

## Database Schema (3NF Normalized)

The database is designed in **Third Normal Form (3NF)** to:
- Eliminate data redundancy
- Maintain data integrity
- Ensure scalability for analytical queries

Each table stores a single type of entity, and relationships are enforced using **primary and foreign keys**.

---

## Entity Relationship Diagram (ERD)

The ER diagram visually represents:
- Core business entities
- Relationships between customers, orders, products, and inventory
- How transactions flow through the system

📌 *See `/diagrams/er_diagram.png`*

---

## Table Structure

### Core Tables
These tables represent the fundamental business entities:

- **Customers** – customer demographic and contact information  
- **Products** – product catalog with pricing  
- **Orders** – customer purchase transactions  
- **Order_Items** – junction table linking orders and products  
- **Payments** – payment details per order  
- **Inventory** – current stock levels per product  

---

### Supporting Tables
These add real-world depth and analytical flexibility:

- **Suppliers** – product supplier information  
- **InventoryLog** – historical inventory changes for trend analysis  

---

## SQL Skills Demonstrated
This project showcases the following SQL competencies:

- Database schema design (3NF normalisation)
- Primary and foreign key relationships
- Data insertion using realistic sample data
- Analytical queries using:
  - JOINs
  - Common Table Expressions (CTEs)
  - Window functions
  - Aggregations and date-based analysis
- Business-focused insights derived from raw data

---

## Key Analytical Questions Answered

- What are the **top-selling products by revenue**?
- How does **monthly revenue trend over time**?
- Which products are at **risk of low stock**?
- Who are the **highest-value customers**?
- Which suppliers support the most profitable products?

---

## How to Run This Project

This project is built using **Microsoft SQL Server** and can be run locally using **SQL Server Management Studio (SSMS)**.

### Prerequisites
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)

### Steps

1. Open **SQL Server Management Studio (SSMS)** and connect to your local SQL Server instance.

2. Create a new database:
   ```sql
   CREATE DATABASE RetailSalesDB;
   GO

   USE RetailSalesDB;
   GO

3. Run the SQL Scripts

Open and run the SQL scripts in the following order:

- **01_create_tables.sql** — creates all database tables and relationships  
- **02_insert_sample_data.sql** — populates tables with realistic sample data  
- **03_analysis_queries.sql** — contains business-focused analytical queries  

Explore query results and insights directly within SSMS.

## Project Structure

```text
Retail-Sales-Database/
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_insert_sample_data.sql
│   └── 03_analysis_queries.sql
│
├── diagrams/
│   └── er_diagram.png
│
└── README.md
