# SQL-Based E-Commerce Analytics System

## 📌 Project Overview

This project focuses on analyzing a real-world e-commerce dataset using SQL to extract actionable business insights. The goal is to transform raw relational data into meaningful information that supports business decision-making across customer behavior, revenue trends, and product performance.

---

## 🧾 Problem Statement

An e-commerce company has accumulated large volumes of transactional data but lacks the ability to extract meaningful business insights such as customer contribution, revenue trends, retention behavior, and product performance.

This project builds a SQL-based analytics system to convert raw data into structured insights for decision-making.

---

## 🎯 Objectives

* Analyze customer purchasing behavior
* Evaluate revenue distribution across customers, cities, and time
* Identify high-value customers and business opportunities
* Perform advanced SQL analysis using window functions
* Translate data into business insights

---

## 📂 Dataset

Dataset used: **Brazilian E-Commerce Public Dataset by Olist**
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Includes:

* Customers
* Orders
* Order Items
* Products

---

## 🛠️ Tools & Technologies

* SQL (SQLite)
* DB Browser for SQLite
* Git & GitHub

---

## 🗄️ Database Schema

The database schema defines the structure of the relational database, including tables and relationships.

Tables included:

* `customers`
* `orders`
* `order_items`
* `products`

👉 Schema is defined in:

```
schema.sql
```

---

## 📊 Key Analyses Performed

### 1. Data Exploration

* Verified dataset structure
* Validated relationships between tables

---

### 2. Customer & Order Analysis

* Joined customers and orders
* Identified one-time vs repeat customers
* Analyzed order distribution across cities

---

### 3. Revenue Analysis

* Calculated total revenue
* Computed Average Order Value (~160.58)
* Analyzed monthly revenue trends
* Built cumulative revenue using window functions

---

### 4. Advanced Customer Analytics

* Segmented customers into High, Medium, Low value
* Performed Pareto analysis (Top 20% customers contribution)
* Analyzed customer retention behavior

---

### 5. Time-Based Analysis

* Identified monthly trends
* Detected revenue drops using `LAG()`
* Analyzed seasonality patterns

---

### 6. City-Level Insights

* Ranked cities by revenue using window functions
* Identified geographic revenue concentration

---

### 7. Product Analysis

* Identified top product categories by revenue
* Analyzed product demand distribution

---

## 🔍 Key Business Insights

* Revenue is highly concentrated in major cities, with São Paulo (~2.17M) and Rio de Janeiro (~1.15M) dominating
* Approximately 97% of customers are one-time buyers, indicating low retention
* Customer base is highly skewed: ~95% low-value customers and only ~1–2% high-value customers
* Top 20% of customers contribute ~54% of revenue, indicating a moderately balanced distribution
* Business shows strong and consistent growth, reaching ~15.8M cumulative revenue
* Revenue peaks in November 2017, indicating strong seasonal demand
* Product revenue is well distributed, showing a diversified portfolio
* Revenue drops are mostly seasonal; late 2018 drop is due to incomplete data

---

## 📁 Project Structure

```
sql-ecommerce-analysis/
│
├── schema.sql
├── queries.sql
└── README.md
```

---

## 🚀 How to Run

1. Open DB Browser for SQLite
2. Create database
3. Run `schema.sql` to create tables
4. Import CSV files into respective tables
5. Execute queries from `queries.sql`

---

## 📌 Future Improvements

* Perform cohort and retention analysis
* Build interactive dashboard (Power BI / Tableau)
* Implement percentile-based segmentation
* Add predictive modeling (Customer Lifetime Value)

---

## 👨‍💻 Author

Gandharv Kulkarni