-- =========================================
-- Customer Retention Analysis (SQL Version)
-- Author: Siti Zahwa Nabila Putri
-- =========================================

-- 1. JOIN TABLES
-- Combine orders, customers, and payments data

SELECT 
    o.order_id,
    c.customer_unique_id,
    o.order_purchase_timestamp,
    p.payment_value
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';



-- 2. CUSTOMER-LEVEL AGGREGATION
-- Calculate total orders and spending per customer

SELECT 
    customer_unique_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(payment_value) AS total_spending,
    MIN(order_purchase_timestamp) AS first_purchase,
    MAX(order_purchase_timestamp) AS last_purchase
FROM joined_table
GROUP BY customer_unique_id;



-- 3. CUSTOMER TYPE SEGMENTATION
-- Identify repeat vs one-time customers

SELECT 
    CASE 
        WHEN COUNT(DISTINCT order_id) > 1 THEN 'Repeat'
        ELSE 'One-time'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM joined_table
GROUP BY customer_unique_id;



-- 4. REVENUE CONTRIBUTION BY CUSTOMER TYPE

SELECT 
    CASE 
        WHEN total_orders > 1 THEN 'Repeat'
        ELSE 'One-time'
    END AS customer_type,
    SUM(total_spending) AS total_revenue
FROM customer_summary
GROUP BY customer_type;



-- =========================================
-- Note:
-- This SQL script represents the logic used
-- in Python (Pandas) for customer analysis.
-- =========================================