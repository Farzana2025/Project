use nihadb;

#create table
create table sales
(
	sale_id int primary key,
    product_id int,
    quantity_sold int,
    sale_date Date,
    total_price decimal (10,2)
);

INSERT INTO sales VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

select * from sales;

CREATE TABLE products 
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

select * from products;

select product_name, unit_price
from products;

select sale_id, sale_date from sales;

select sale_id, product_id, quantity_sold, sale_date, total_price
from sales
where total_price > 100;

select product_id, product_name, category, unit_price
from products
where category = 'Electronics';

select sale_id, total_price
from sales
where sale_date = '2024-01-03';

select product_id, product_name from products
where unit_price > 100;

select sum(total_price) as Total_revenue
from sales;

select avg(unit_price) as average_unit_price
from products;

select sum(quantity_sold) as total_quantity_sold 
from sales;

select sale_id, product_id, total_price 
from sales 
where quantity_sold >  4;

select product_name, unit_price 
from products 
order by unit_price desc;

select round(sum(total_price), 2) as Total_sales
 from sales;

select Avg(total_price) as average_total_price from sales;

select sale_id, DATE_FORMAT(sale_date, '%Y-%m-%d') as sale_date
from sales;

#Calculate the total revenue generated from sales of products in the 'Electronics' category
select sum(s.total_price) as total_revenue
from sales s
join products p
on s.product_id = p.product_id
where p.category = 'Electronics';

#Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only values between $20 and $600.

select product_name, unit_price
from products
where unit_price between 20 and 600;

#Retrieve the product_name and category from the Products table, ordering the results by category in ascending order.

select product_name, category
from products
order by category asc;

#Calculate the total quantity_sold of products in the 'Electronics' category

select sum(s.quantity_sold) as total_quantity_sold, p.category
from sales s
join products p
on s.product_id = p.product_id
where p.category = 'Electronics';

#Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold multiplied by unit_price.

select p.product_name, s.quantity_sold * p.unit_price as Total_price
from  sales s join products p
on s.product_id = p.product_id;

#Calculate the total revenue generated from sales for each product category.

select sum(s.total_price) as Total_Revenue, p.category 
from sales s
join products p
on s.product_id = p.product_id
group by p.category;

#Find the product category with the highest average unit price.
select category,  Avg(unit_price) as Avg_unit_price
from products
group by category
order by Avg(unit_price) desc
limit 1;

# Identify products with total sales exceeding 30
select p.product_name
from sales s
join products p
on s.product_id = p.product_id
group by p.product_name
having sum(s.total_price) > 30;

#Count the number of sales made in each month.
SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS month, COUNT(quantity_sold) AS sales_count
FROM Sales s
GROUP BY month;

# Determine the average quantity sold for products with a unit price greater than $100.
select avg(s.quantity_sold) as Avg_Quanity_sold
from sales s
join products p
on s.product_id = p.product_id
where p.unit_price > 100;

#Retrieve the product name and total sales revenue for each product
select p.product_name, sum(s.total_price) as Total_sales_revenue
from sales s
join products p
on s.product_id = p.product_id
group by p.product_name;

# List all sales along with the corresponding product names.
SELECT s.sale_id, p.product_name
FROM Sales s
JOIN Products p 
ON s.product_id = p.product_id;

#Retrieve the product name and total sales revenue for each product.
select p.product_name, sum(s.total_price) as total_sales_revenue
from sales s
join products p
on s.product_id = p.product_id
group by p.product_name;

# Rank products based on total sales revenue.
SELECT p.product_name, SUM(s.total_price) AS total_sale_revenue,
       RANK() OVER (ORDER BY SUM(s.total_price) DESC) AS revenue_rank
FROM Sales s
JOIN Products p
ON s.product_id = p.product_id
GROUP BY p.product_name;

#Calculate the running total revenue for each product category.
SELECT p.category, p.product_name, s.sale_date, 
       SUM(s.total_price) OVER (PARTITION BY p.category ORDER BY s.sale_date) AS running_total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

#Categorize sales as "High", "Medium", or "Low" based on total price (e.g., > $200 is High, $100-$200 is Medium, < $100 is Low).
select   s.sale_id, p.product_name, s.total_price,
 case
	WHEN total_price > 200 THEN 'High'
           WHEN total_price BETWEEN 100 AND 200 THEN 'Medium'
           ELSE 'Low'
       END AS sales_category
FROM Sales s
join products p
on s.product_id = p.product_id;

#Identify sales where the quantity sold is greater than the average quantity sold.

select sale_id, quantity_sold
from sales s
where quantity_sold > (select avg(quantity_sold) from sales);

#Extract the month and year from the sale date and count the number of sales for each month.

SELECT CONCAT(YEAR(sale_date), '-', LPAD(MONTH(sale_date), 2, '0')) AS month,
       COUNT(*) AS sales_count
FROM Sales
GROUP BY  month;

#Calculate the number of days between the current date and the sale date for each sale.
select sale_id, datediff(now(), sale_date) as number_of_days
from sales;

# Identify sales made during weekdays versus weekends.
SELECT sale_id,
       CASE 
           WHEN DAYOFWEEK(sale_date) IN (1, 7) THEN 'Weekend'
           ELSE 'Weekday'
       END AS day_type
FROM Sales;

#Write a query to create a view named Total_Sales that displays the total sales amount for each product along with their names and categories.
CREATE VIEW Total_Sales AS
SELECT p.product_name, p.category, SUM(s.total_price) AS total_sales_amount
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_name, p.category;

select * from total_sales;

#Retrieve the product details (name, category, unit price) for products that have a quantity sold greater than the average quantity sold across all products.
SELECT product_name, category, unit_price
FROM Products
WHERE product_id IN (
    SELECT product_id
    FROM Sales
    GROUP BY product_id
    HAVING SUM(quantity_sold) > (SELECT AVG(quantity_sold) FROM Sales)
);

#provide an example scenario where indexing could significantly improve query performance in the given schema.

#Create a view named Top_Products that lists the top 3 products based on the total quantity sold.
Create view top_products as
select p.product_name, sum(s.quantity_sold) as total_quantity_sold
from sales s
join products p
on s.product_id = p.product_id
group by p.product_name
order by total_quantity_sold desc
limit 3;

select * from  top_products;

#Implement a transaction that deducts the quantity sold from the Products table when a sale is made in the Sales table, ensuring that both operations are either committed or rolled back together.

# Create a query that lists the product names along with their corresponding sales count.
SELECT p.product_name, COUNT(s.sale_id) AS sales_count
FROM Products p
LEFT JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_name;

#Write a query to find all sales where the total price is greater than the average total price of all sales
SELECT *
FROM Sales
WHERE total_price > (SELECT AVG(total_price) FROM Sales);

#Add a check constraint to the quantity_sold column in the Sales table to ensure that the quantity sold is always greater than zero.

# Create a view named Product_Sales_Info that displays product details along with the total number of sales made for each product.
create view products_sales_info2 as
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    COUNT(s.sale_id) AS total_sales
FROM 
    Products p
 JOIN 
    Sales s ON p.product_id = s.product_id
GROUP BY 
    p.product_id, p.product_name, p.category, p.unit_price;
select * from products_sales_info2;

#Develop a stored procedure named Update_Unit_Price that updates the unit price of a product in the Products table based on the provided product_id.

# Write a query that calculates the total revenue generated from each category of products for the year 2024.
SELECT 
    p.category,
    SUM(s.total_price) AS total_revenue
FROM 
    Sales s
JOIN 
    Products p 
    ON s.product_id = p.product_id
WHERE 
    YEAR(s.sale_date) = 2024
GROUP BY 
    p.category;