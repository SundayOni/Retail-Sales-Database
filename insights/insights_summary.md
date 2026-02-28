# Key Insights & Query Findings

> This document summarises the business insights derived from the analytical queries in `03_analysis_queries.sql`, written as a narrative for non-technical stakeholders.

---

## 1. Revenue Trends

Monthly revenue grew steadily from March through June 2024. March opened with **£229.96** across two completed orders, peaking in **May at £214.91** before a slight softening in June. The cumulative revenue across all completed orders reached approximately **£698.79**, demonstrating a healthy ramp-up period for the business.

**Furniture** is the highest-revenue category, driven by the Standing Desk (£399.99 per unit). Electronics and Healthcare show strong unit volumes despite lower per-item prices.

---

## 2. Top Products by Revenue

| Rank | Product | Units Sold | Revenue |
|------|---------|-----------|---------|
| 1 | Standing Desk | 1 | £399.99 |
| 2 | Office Chair | 1 | £149.99 |
| 3 | Blood Pressure Monitor | 3 | £179.97 |
| 4 | USB-C Hub | 3 | £134.97 |
| 5 | Wireless Keyboard | 3 | £89.97 |

The Standing Desk drives the most revenue per sale, but Healthcare products (BP Monitor, Thermometer) drive the most **order frequency**, making them reliable volume drivers.

---

## 3. Customer Insights

- **John Smith** (London) is the highest-value customer and the only repeat purchaser, placing 2 completed orders worth a combined **£164.94**.
- **London** is the top city by revenue (£164.94), followed by Leeds (£399.99 for the Standing Desk alone).
- All 8 customers completed at least one purchase during the period — a **100% conversion rate** on registered customers.

**Opportunity:** Liam Taylor (Glasgow) has a pending order with no payment recorded — this represents a potential revenue risk to follow up.

---

## 4. Inventory Health

| Status | Products |
|--------|----------|
| OK | USB-C Hub, Wireless Mouse, Digital Thermometer, Ergonomic Mouse Pad, Wireless Keyboard |
| LOW — MONITOR | Blood Pressure Monitor |
| REORDER NOW | Office Chair, Standing Desk |

The **Office Chair** and **Standing Desk** are approaching reorder levels after sales in Q1/Q2. OfficeMart UK (Supplier 3) should be contacted to initiate restocking. No products are currently out of stock.

**Restock events** in April and May brought Office Chair (+20 units) and Ergonomic Mouse Pad (+100 units) back to healthy levels.

---

## 5. Payment Analysis

| Method | Transactions | Revenue |
|--------|-------------|---------|
| Card | 5 | £459.87 |
| PayPal | 2 | £209.95 |
| Bank Transfer | 1 | £129.94 |

**Card payments** dominate both in volume and value. One order (Order #7, Liam Taylor) remains unpaid and pending — a process gap that would need addressing in a production environment.

---

## 6. Month-over-Month Growth

| Month | Revenue | MoM Growth |
|-------|---------|-----------|
| 2024-03 | £229.96 | — |
| 2024-04 | £564.94 | +145.7% |
| 2024-05 | £214.91 | −62.0% |
| 2024-06 | £89.97 | −58.1% |

The April spike is driven by the single high-value Standing Desk purchase (£399.99). Stripping out that outlier, the underlying trend shows consistent low-to-mid £100s in monthly revenue — consistent with a business in early growth.

---

*These findings are based on sample data for portfolio demonstration purposes.*
