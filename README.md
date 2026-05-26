# 📚 Book Store Operations & Sales Analysis
[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)

This project involves a deep dive into a Book Store's operational data to analyze inventory health, genre-level sales performance, and customer purchasing trends using structured SQL queries.

## 📌 Project Overview

The goal of this analysis is to extract actionable insights from the Book Store dataset, focusing on:

* **Inventory Management:** Identifying out-of-stock titles and reconciling oversold books.
* **Product Performance:** Ranking genres and authors by total units sold and revenue contribution.
* **Customer Behavior:** Segmenting buyers based on order frequency and total spending (AOV).

## 💡 Key Business Insights

* **Top Genre:** Mystery contributed the highest units sold (504) among all product segments.
* **Stock Lag:** Several titles show negative remaining stock after fulfilling orders, indicating inventory data gaps.
* **Customer Segmentation:** 27.8% of customers are repeat buyers, placing 2 or more orders with a higher average spend.
* **Revenue Trends:** 94.6% of all orders exceeded $20, with a total store revenue of $75,628.66.

## 🛠️ Tech Stack

* **Database:** PostgreSQL
* **Tools:** pgAdmin / PostgreSQL
* **Data Source:** `Books.csv`, `Customers.csv`, `Orders.csv` (included in repository)

## 🔍 Key SQL Insights

The [Book_Store.sql](./Book_Store.sql) file contains queries addressing:

1. **Total Revenue & Stock:** Aggregate revenue from all orders and total available inventory.
2. **Genre Deep-dive:** Which book genres have the highest turnover and unit sales?
3. **Inventory Gap:** Calculation of remaining stock after fulfilling all placed orders.

### Sample Query: Top Genres by Units Sold

```sql
SELECT 
    b.Genre,
    SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre
ORDER BY Total_Books_Sold DESC;
```

## 🚀 Getting Started

1. **Clone the Repository**
```bash
   git clone https://github.com/bsanghvi78/Book_Store.git
   cd Book_Store
```

2. **Import the Dataset**
   * Use the `Books.csv`, `Customers.csv`, and `Orders.csv` files to populate your SQL database tables.
   * Ensure the table schema in `Book_Store.sql` matches the dataset structure before importing.

3. **Run the SQL Queries**
   * Execute the scripts available in `Book_Store.sql`.
   * These queries contain the business logic and analytical insights for the project.

---

## 📁 Repository Structure

* **`Book_Store.sql`** — All SQL queries including table creation, data import, and analytical insights
* **`Books.csv`** — Dataset containing book titles, authors, genres, prices, and stock levels
* **`Customers.csv`** — Dataset containing customer profiles and geographic information
* **`Orders.csv`** — Primary dataset containing order transactions, quantities, and revenue records

> 📌 Dataset included in this repository.
