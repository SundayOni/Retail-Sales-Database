# Retail Sales Database

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-0078D4?style=flat&logo=microsoft&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green?style=flat)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat)
![Schema](https://img.shields.io/badge/Schema-3NF_Normalised-blue?style=flat)

A production-style retail transactional database built in **Microsoft SQL Server (T-SQL)**, designed to model real-world business operations across sales, inventory, customer management, and supply chain.

---

## Overview

Retail organisations need reliable, well-structured data to track purchases, monitor product performance, identify high-value customers, and manage stock levels. This project models a normalised retail system that enables analysts and decision-makers to answer these questions efficiently using SQL.

The project demonstrates end-to-end database engineering — from schema design and data insertion through to business-focused analytical queries using advanced SQL techniques.

---

## Entity Relationship Diagram

![ERD](diagrams/er_diagram.svg)

> 8 tables · 3NF normalised · 12 foreign key relationships

---

## Database Schema

The schema is designed in **Third Normal Form (3NF)** to eliminate redundancy, maintain data integrity, and support scalable analytical querying.

### Core Tables

| Table | Description |
|-------|-------------|
| `customers` | Customer demographic and contact information |
| `products` | Product catalogue with pricing and categories |
| `orders` | Customer purchase transactions with status tracking |
| `order_items` | Line-item junction table linking orders to products |
| `payments` | Payment records per order with method and status |

### Supporting Tables

| Table | Description |
|-------|-------------|
| `suppliers` | Supplier contact and location information |
| `inventory` | Current stock levels and reorder thresholds per product |
| `inventory_log` | Historical log of all stock changes (sales, restocks, returns) |

---

## Key Relationships

- A **Customer** places many **Orders** (1:M)
- An **Order** contains many **Order Items** (1:M)
- A **Product** appears in many **Order Items** (1:M)
- An **Order** has one **Payment** (1:1)
- A **Product** has one **Inventory** record (1:1)
- A **Supplier** supplies many **Inventory** entries (1:M)
- A **Product** has many **Inventory Log** entries (1:M)

---

## SQL Skills Demonstrated

| Skill | Where Used |
|-------|-----------|
| Schema design & 3NF normalisation | `01_create_tables.sql` |
| Primary keys, foreign keys, constraints | `01_create_tables.sql` |
| Realistic multi-table data insertion | `02_insert_sample_data.sql` |
| `JOIN` (INNER, LEFT) across multiple tables | `03_analysis_queries.sql` |
| Common Table Expressions (CTEs) | Q5, Q11, Q12, Q13 |
| Window functions (`RANK`, `LAG`, `SUM OVER`) | Q2, Q3, Q4, Q11, Q12, Q13 |
| `CASE` statements for business logic | Q7 |
| Date functions (`FORMAT`, `CAST`, `LAG`) | Q1, Q11, Q13 |
| Aggregations with `GROUP BY` | Q1–Q10 |
| Month-over-month growth calculation | Q13 |
| Cumulative running totals | Q11 |
| Subqueries and derived tables | Q7, Q12 |

---

## Analytical Questions Answered

The `03_analysis_queries.sql` file contains **13 business-focused queries** across 5 analytical themes:

**Revenue Analysis**
- Monthly revenue trend over time
- Top-selling products by revenue
- Revenue breakdown by product category

**Customer Insights**
- Customer lifetime value (LTV) ranking
- Repeat customer identification
- Revenue by city / geography

**Inventory & Supply Chain**
- Products at risk of low stock with status flags
- Most restocked products and supplier activity

**Order & Payment Analysis**
- Orders with outstanding or failed payments
- Revenue breakdown by payment method

**Advanced SQL**
- Running cumulative revenue total
- Product performance vs category average
- Month-over-month revenue growth rate

---

## Key Findings

See [`insights/insights_summary.md`](insights/insights_summary.md) for a full business narrative of the results.

**Highlights:**
- Furniture drives the highest revenue per order (Standing Desk: £399.99)
- Healthcare products drive the highest order frequency
- Office Chair and Standing Desk are approaching reorder thresholds — OfficeMart UK should be contacted
- Card payments account for ~65% of total revenue collected
- One pending order (Liam Taylor) represents an unresolved payment gap

---

## How to Run

### Prerequisites
- Microsoft SQL Server (Express or full edition)
- SQL Server Management Studio (SSMS)

### Steps

1. Open **SSMS** and connect to your local SQL Server instance.

2. Run the scripts in order:

```sql
-- Step 1: Create the database and all tables
-- Run: sql/01_create_tables.sql

-- Step 2: Insert sample data
-- Run: sql/02_insert_sample_data.sql

-- Step 3: Run analytical queries
-- Run: sql/03_analysis_queries.sql
```

3. Explore the query results directly in SSMS. Each query is labelled and grouped by analytical theme.

---

## Project Structure

```
Retail-Sales-Database/
│
├── sql/
│   ├── 01_create_tables.sql        # Schema: tables, PKs, FKs, constraints
│   ├── 02_insert_sample_data.sql   # Sample data (8 customers, 8 products, 10 orders)
│   └── 03_analysis_queries.sql     # 13 business-focused analytical queries
│
├── diagrams/
│   └── er_diagram.svg              # Entity Relationship Diagram
│
├── insights/
│   └── insights_summary.md         # Business narrative of query findings
│
└── README.md
```

---

## Sample Data

The database is pre-loaded with realistic UK retail data:

- **8 customers** across London, Birmingham, Manchester, Leeds, Bristol, Glasgow, and Leicester
- **8 products** across Electronics, Furniture, Healthcare, and Accessories categories
- **3 suppliers** with contact details
- **10 orders** spanning March–June 2024 (including completed, pending, and cancelled states)
- **13 order line items** with realistic quantities and prices
- **8 payments** across Card, PayPal, and Bank Transfer methods
- **16 inventory log entries** covering sales and restocks

---

## About

Built to demonstrate SQL database engineering and analytical query skills.

**Tech Stack:** Microsoft SQL Server · T-SQL · SSMS  
**Author:** [SundayOni](https://github.com/SundayOni)  
**License:** MIT
