--Database_Setup
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_Sales;

-- Data Exploration & Cleaning
select count(distinct customer_id)
from retail_Sales;

select distinct category
from retail_Sales;

select * from retail_sales
where 
     sale_date is null or sale_time is null or customer_id is null or 
     gender is null or age is null or category is null or quantity is null or
     price_per_unit is null or cogs is null;

Delete from retail_Sales
where 
     sale_date is null or sale_time is null or customer_id is null or
      gender is null or age is null or category is null or
      quantity is null or price_per_unit is null or cogs is null;

-- Data Analysis & Findings
  -- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select *
from retail_Sales
where sale_date = '2022-11-05'


-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select *
from retail_Sales
where category = 'Clothing'
and
To_char(sale_date, 'YYYY-MM') = '2021-11'
and
quantity >=4;
-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.:
select 
      category,
      sum(total_Sale) as Net_Sales,
      count (*) as Total_Orders
from Retail_Sales
group by category
order by net_Sales;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select
    round(avg(age),2) as avg_age
from retail_Sales
where category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retail_Sales
where total_Sale > 1000
order by total_sale desc;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
     category,
     gender,
     count(*) as Total_trans
from retail_sales
group by 
        category,
        gender
order by 1;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
      year,
      month,
      avg_sale
from 
(
	select 
	     extract(year from sale_date) as Year,
	     extract(month from sale_date) as Month,
	     avg(total_sale) as Avg_Sale,
	     rank()over(partition by extract(year from sale_date) order by avg(total_Sale)desc)as Rank
from retail_Sales
group by 1,2
) as t1
where rank = 1;

-- 8.**Write a SQL query to find the top 5 customers based on the highest total sales **:
select 
      customer_id,
     sum(total_sale) as Total_Sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
       count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category
order by cnt_unique_cs desc;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(
	select *,
	 case
	     when extract(hour from sale_time) <12 then 'Morning'
	     when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	     else 'Evening'
	  end as Shift
	from retail_sales
	)
	select 
	     shift,
	     count(*) as Total_orders
from hourly_sale
group by shift
	   
