# 🛍️ E-Store Pulse: E-Commerce Performance Analytics

**End-to-end analytics project** covering SQL data modeling, Excel reporting, and an interactive Power BI dashboard — built to analyze order volume, revenue, returns, and customer behavior for an e-commerce business.

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Data%20Analysis-217346?style=flat-square&logo=microsoftexcel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/status-complete-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

---

## 📌 Overview

**E-Store Pulse** is a full-stack data analytics project that simulates a real-world e-commerce reporting workflow — from raw transactional data to a decision-ready dashboard.

The project answers key business questions such as:

- What are our total orders, gross sales, and net revenue?
- How healthy is our order fulfillment (Shipped / Delivered / Returned / Cancelled)?
- Which payment methods do customers prefer?
- How does performance vary by region and product?
- How does discounting behavior change with order quantity?
- Is revenue trending up or down year over year?

The workflow mirrors a real analyst pipeline:

**PostgreSQL → Excel → Power BI**

---

# 🎥 Dashboard Demo

> **Interactive walkthrough of the Power BI dashboard** showing KPI cards, slicers, sales trends, payment analysis, and regional performance.

<p align="center">
  <a href="./project2.mp4">
    <img src="https://img.shields.io/badge/▶️_Watch_Live_Dashboard_Demo-Click_Here-red?style=for-the-badge" alt="Watch Demo">
  </a>
</p>

<p align="center">
  <sub>Click the button above to play the complete dashboard walkthrough.</sub>
</p>

---

## 🧰 Tech Stack

| Layer | Tool | Purpose |
|-------|------|----------|
| Database | PostgreSQL | Schema design, data storage, business analysis |
| Reporting | Microsoft Excel | KPI summaries and validation |
| Visualization | Power BI | Interactive dashboard |
| Data | CSV | Raw transactional dataset |

---

## 📊 Dashboard Features

The Power BI dashboard includes:

### KPI Cards

- 📦 Total Orders
- 💰 Gross Sales
- 💵 Net Revenue
- 🛒 Total Quantity
- 🔄 Return Rate

### Interactive Visuals

- Order Status Distribution
- Payment Mode Breakdown
- Discount Frequency by Quantity
- Sales Trend (2022–2024)

### Slicers

- Product Name (10 categories)
- Region (North, South, East, West)

---

## 🗂️ Repository Structure

```text
E-Store-Pulse/
├── LICENSE
├── README.md
├── ecommerce_analysis.sql
├── ecommerce_analysis.xlsx
├── ecommerce_orders.csv
└── project2.mp4
```

---

## 📁 Dataset

**File:** `ecommerce_orders.csv`

| Detail | Value |
|--------|-------|
| Rows | 6,000 Orders |
| Period | Jan 2022 – Dec 2024 |
| Type | Synthetic Portfolio Dataset |

### Dataset Columns

| Column | Description |
|--------|-------------|
| Order_ID | Unique order ID |
| Order_Date | Purchase date |
| Customer_ID | Customer identifier |
| Customer_Name | Customer name |
| Product_Name | Product purchased |
| Category | Electronics / Fashion / Accessories |
| Region | North / South / East / West |
| City | Customer city |
| Quantity | Units ordered |
| Unit_Price | Product price |
| Gross_Sales | Before discount |
| Discount_Percent | Discount applied |
| Discount_Amount | Discount value |
| Net_Revenue | Revenue after discount |
| Payment_Mode | UPI, Card, COD, etc. |
| Order_Status | Delivered, Returned, etc. |
| Is_Returned | Return flag |

> The dataset is synthetically generated to simulate realistic e-commerce business scenarios.

---

## 🗃️ SQL Analysis

**File:** `ecommerce_analysis.sql`

The SQL script includes:

- Database schema creation
- Data loading
- Business KPI queries
- Window functions
- Trend analysis
- Customer insights
- Regional performance analysis

### Example Query

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(gross_sales) AS gross_sales,
    SUM(net_revenue) AS net_revenue,
    SUM(quantity) AS total_quantity,
    ROUND(100.0 * SUM(is_returned) / COUNT(*), 2) AS return_rate_pct
FROM ecommerce_orders;
```

---

## 📈 Excel Reporting

**File:** `ecommerce_analysis.xlsx`

The workbook contains:

| Sheet | Purpose |
|-------|---------|
| Raw_Data | Complete dataset |
| Dashboard_Summary | Formula-driven KPI dashboard |
| Read_Me | Documentation |

The Excel dashboard updates automatically whenever the raw dataset changes.

---

## 📊 Key Business Insights

- Return rate remains around **25%** across all regions.
- **South Region** generates the highest revenue.
- **UPI** and **Net Banking** dominate digital payments.
- Sales volume peaks during **2023**.
- Discounts remain fairly balanced across order quantities.

These insights help stakeholders identify revenue trends, customer behavior, and operational opportunities.

---

## 🚀 How to Reproduce

### 1. Load SQL Database

```bash
psql -d your_database -f ecommerce_analysis.sql
```

Import CSV

```sql
\copy ecommerce_orders FROM 'ecommerce_orders.csv' DELIMITER ',' CSV HEADER;
```

### 2. Open Excel

Explore the live KPI calculations inside `ecommerce_analysis.xlsx`.

### 3. Open Power BI

Connect Power BI to either:

- PostgreSQL
- CSV dataset

Then recreate the dashboard using KPI cards, slicers, and charts.

---

## ⭐ Project Highlights

- ✔ End-to-End Data Analytics Project
- ✔ PostgreSQL Business Queries
- ✔ Formula-Driven Excel Dashboard
- ✔ Interactive Power BI Report
- ✔ Synthetic Real-World Dataset
- ✔ Recruiter-Friendly Portfolio Project

---

## 👤 Author

**Ganesh Sargar**

Final-Year B.Tech CSE (IoT, Cyber Security & Blockchain)

**Aspiring Data Analyst**

- GitHub: **[@Ganes-Sargar](https://github.com/Ganes-Sargar)**
- LinkedIn: **[ganesh-sargar-319386298](https://www.linkedin.com/in/ganesh-sargar-319386298)**
- Email: **sargarganesh800@gmail.com**

---

## 📄 License

This project is licensed under the **MIT License**.

Feel free to use, modify, and share with proper attribution.
