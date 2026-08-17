# 🛍️ E-Store Pulse: E-Commerce Performance Analytics

**End-to-end analytics project** covering SQL data modeling, Excel reporting, and an interactive Power BI dashboard — built to analyze order volume, revenue, returns, and customer behavior for an e-commerce business.

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Data%20Analysis-217346?style=flat-square&logo=microsoftexcel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/status-complete-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

---

## 📌 Overview

**E-Store Pulse** is a full-stack data analytics project that simulates a real-world e-commerce reporting workflow — from raw transactional data to a decision-ready dashboard. The project answers key business questions for stakeholders:

- What are our total orders, gross sales, and net revenue?
- How healthy is our order fulfillment (shipped / delivered / returned / cancelled)?
- Which payment methods do customers prefer?
- How does performance vary by region and product?
- How does discounting behavior change with order quantity?
- Is revenue trending up or down year over year?

The workflow mirrors a typical analyst pipeline: **SQL** for data modeling and querying → **Excel** for structured reporting and validation → **Power BI** for interactive visualization.

---

## 🎥 Dashboard Demo

> 📹 *Video walkthrough of the live Power BI dashboard — filtering by product and region, exploring KPIs in real time.*

<!--
  Upload project2.mp4 to the repo (e.g. under /assets) or to GitHub via a release/issue attachment,
  then replace the link below with the raw video URL, or embed a GIF preview here.

  Example:
  https://github.com/Ganes-Sargar/estore-pulse-analytics/assets/<attachment-id>/project2.mp4
-->
🔗 **[Watch the demo video](#)**

---

## 🧰 Tech Stack

| Layer | Tool | Purpose |
|---|---|---|
| Database | **PostgreSQL** | Schema design, data storage, business-logic queries |
| Reporting | **Microsoft Excel** | Pivot-style summary sheets, formula-driven KPIs |
| Visualization | **Power BI** | Interactive dashboard with slicers, KPI cards, trend charts |
| Data | **CSV** | Portable raw dataset used across all three tools |

---

## 📊 Dashboard Preview

The Power BI report — **"E-Store Pulse: Performance Analytics"** — includes:

| KPI Cards | Visuals |
|---|---|
| Total Orders · Gross Sales · Net Revenue · Total Quantity · Return Rate (%) | Order Status (bar) · Payment Mode (donut) · Discount Frequency by Quantity (pie) · Sales Count Trend (area, 2022–2024) |

**Slicers:** `Product_Name` (10 categories) and `Region` (North / South / East / West) for full cross-filtering.

---

## 🗂️ Repository Structure

```
estore-pulse-analytics/
├── data/
│   └── ecommerce_orders.csv        # Raw transactional dataset (6,000 orders)
├── sql/
│   └── ecommerce_analysis.sql      # Schema, data load & business analysis queries
├── ecommerce_analysis.xlsx         # Excel workbook: Raw_Data + formula-driven Dashboard_Summary
└── README.md
```

---

## 📁 Dataset

**File:** `data/ecommerce_orders.csv` | **Rows:** 6,000 orders | **Period:** Jan 2022 – Dec 2024

| Column | Description |
|---|---|
| `Order_ID` | Unique order identifier |
| `Order_Date` | Date the order was placed |
| `Customer_ID` / `Customer_Name` | Customer identifiers |
| `Product_Name` | Backpack, Camera, Headphones, Keyboard, Laptop, Mobile, Mouse, Shoes, T-Shirt, Watch |
| `Category` | Electronics / Fashion / Accessories |
| `Region` / `City` | Order geography (North, South, East, West) |
| `Quantity` | Units ordered (1–5) |
| `Unit_Price`, `Gross_Sales` | Pricing and pre-discount revenue |
| `Discount_Percent`, `Discount_Amount` | Discount applied |
| `Net_Revenue` | Revenue after discount |
| `Payment_Mode` | Cash on Delivery, Debit Card, Credit Card, UPI, Net Banking |
| `Order_Status` | Shipped, Delivered, Returned, Cancelled |
| `Is_Returned` | 1 if the order was returned, else 0 |

> Data is synthetically generated to realistically reflect e-commerce order patterns for portfolio/demo purposes.

---

## 🗃️ SQL Analysis

**File:** `sql/ecommerce_analysis.sql`

Includes schema DDL and 14 analytical queries covering the exact metrics on the dashboard:

- KPI summary (orders, gross sales, net revenue, quantity, return rate)
- Order status & payment mode breakdowns
- Regional and product-level performance
- Discount frequency by quantity
- Yearly / monthly sales trend
- Top cities & top customers by revenue
- Return-rate hotspots by product × region
- Month-over-month revenue growth (window functions)

```sql
-- Example: Total Orders, Gross Sales, Net Revenue, Total Quantity, Return Rate (%)
SELECT
    COUNT(*)                                        AS total_orders,
    SUM(gross_sales)                                AS gross_sales,
    SUM(net_revenue)                                AS net_revenue,
    SUM(quantity)                                   AS total_quantity,
    ROUND(100.0 * SUM(is_returned) / COUNT(*), 2)   AS return_rate_pct
FROM ecommerce_orders;
```

---

## 📈 Excel Workbook

**File:** `ecommerce_analysis.xlsx`

| Sheet | Contents |
|---|---|
| `Raw_Data` | Full dataset as a formatted Excel Table |
| `Dashboard_Summary` | Live formulas (`SUM`, `COUNTIF`, `SUMIF`, `SUMIFS`) for KPI cards, order status, payment mode, regional, and product-level breakdowns |
| `Read_Me` | Sheet-by-sheet notes |

All summary figures recalculate automatically if the raw data changes — no manual re-entry required.

---

## 🔑 Key Insights

- Return rate holds steady around **25%** across all regions — signals a systemic fulfillment/quality issue worth investigating rather than a regional one.
- **South** region leads in both order volume and net revenue.
- **UPI** and **Net Banking** are the most-used digital payment modes, with **Cash on Delivery** still holding a meaningful share.
- Sales volume peaked in **2023** before declining in 2024 — a trend worth flagging for stakeholders.
- Discounting is fairly evenly distributed across order quantities, suggesting promotions aren't concentrated on bulk orders.

---

## 🚀 How to Reproduce

1. **Load the data into PostgreSQL**
   ```bash
   psql -d your_database -f sql/ecommerce_analysis.sql
   \copy ecommerce_orders FROM 'data/ecommerce_orders.csv' DELIMITER ',' CSV HEADER;
   ```
2. **Open `ecommerce_analysis.xlsx`** to explore the formula-driven summary, or rebuild pivots directly from `Raw_Data`.
3. **Connect Power BI** to the CSV/SQL table and recreate the KPI cards, slicers, and charts described above.

---

## 👤 Author

**Ganesh Sargar**
Final-year B.Tech CSE (IoT, Cyber Security & Blockchain) — Data Analyst | Data Enthusiast

- GitHub: [@Ganes-Sargar](https://github.com/Ganes-Sargar)
- LinkedIn: [ganesh-sargar-319386298](https://www.linkedin.com/in/ganesh-sargar-319386298)
- Email: sargarganesh800@gmail.com

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) — free to use, modify, and share with attribution.
