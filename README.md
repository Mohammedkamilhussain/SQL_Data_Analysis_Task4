SQL for Data Analysis (E-commerce Dataset)

Overview:
This project is an aspect of my Data Analyst Internship tasks where I used MySQL to extract and analyze data from a sample e-commerce database.

The analysis involved:
- Filtering data using `SELECT` and `WHERE`
- Aggregating results with `GROUP BY` and `SUM`
- Joining tables with `INNER JOIN` and `LEFT JOIN`
- Using subqueries
- Creating views
- Adding indexes for performance

Files in this repository:
- **task4.sql** → MySQL script that creates tables, inserts data, and executes the analysis queries.
- **/screenshots/** → Folder for query results.
- **README.md** → This file which explains the work.

Screenshots:
1. **USA Customers**
   - Query:
     ```sql
     SELECT * FROM customers WHERE country = 'USA' ORDER BY customer_name ASC;
   - ![USA customers](screenshots/01_customers_usa.png)

2. **Total sales by category**
   - Query:
     ```sql
     SELECT p.category, SUM(oi.price * oi.quantity) AS total_sales
     FROM order_items oi
     JOIN products p ON oi.product_id = p.product_id
     GROUP BY p.category
     ORDER BY total_sales DESC;
   - ![Total sales by category](screenshots/02_sales_by_category.png)

3. **Orders with customer names (INNER JOIN)**
   - Query:
     ```sql
     SELECT o.order_id, c.customer_name, o.order_date, o.total_amount
     FROM orders o
     INNER JOIN customers c ON o.customer_id = c.customer_id;

4. **Customers with/without Orders (LEFT JOIN)**
   - Query:
     ```sql
     SELECT c.customer_name, o.order_id
     FROM customers c
     LEFT JOIN orders o ON c.customer_id = o.customer_id;
   - ![Left Join](screenshots/04_left_join_customers_orders.png)

5. **Monthly Sales View**
   - Query:
     ```sql
     SELECT * FROM monthly_sales;
   - ![Monthly Sales](screenshots/05_monthly_sales.png)

Tools Used:
- MySQL 8.0
- MySQL Workbench
- GitHub
