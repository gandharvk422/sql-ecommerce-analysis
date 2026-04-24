# SQL E-Commerce Analytics

## 📌 Project Overview

This project focuses on analyzing an e-commerce dataset using SQL to extract meaningful business insights. The objective is to understand customer behavior, revenue distribution, and overall business performance through structured queries.

---

## 🎯 Objectives

* Analyze customer and order data
* Identify top-performing cities and customers
* Calculate revenue distribution
* Extract actionable business insights

---

## 📂 Dataset

Dataset used: **[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)**

It includes:

* Customers data
* Orders data
* Order items data
* Products data

---

## 🛠️ Tools & Technologies

* SQL (SQLite)
* DB Browser for SQLite
* Git & GitHub

---

## 📊 Key Analyses Performed

### 1. Data Exploration

* Verified dataset structure
* Checked total records

---

### 2. Customer & Order Analysis

* Joined customers and orders
* Identified order distribution across cities

---

### 3. City-Level Insights

* Top cities by number of orders
* Top cities by total revenue

---

### 4. Revenue Analysis

* Calculated total revenue using order items
* Identified revenue concentration across cities

---

### 5. Customer Analysis

* Identified top customers by revenue contribution

---

## 🔍 Key Insights

* São Paulo dominates both order volume and revenue (~2.17M), indicating strong market concentration
* Revenue is heavily concentrated in top cities like Rio de Janeiro and Belo Horizonte
* Customer revenue contribution is relatively distributed, with no extreme dependency on a single customer
* Significant drop in revenue after top cities suggests opportunities for expansion in mid-tier regions

---

## 📁 Project Structure

```
sql-ecommerce-analysis/
│
├── queries.sql
└── README.md
```

---

## 🚀 How to Run

1. Open database using DB Browser for SQLite
2. Load dataset tables (`customers`, `orders`, `order_items`, `products`)
3. Execute queries from `queries.sql`

---

## 📌 Future Improvements

* Add time-based analysis (monthly trends)
* Perform cohort and retention analysis
* Build interactive dashboard using Power BI or Tableau

---

## 👨‍💻 Author

Gandharv Kulkarni