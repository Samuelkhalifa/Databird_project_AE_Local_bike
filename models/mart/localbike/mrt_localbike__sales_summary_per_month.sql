SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    FORMAT_DATE('%B', order_date) AS order_month_name,
    ROUND(SUM(os.item_quantity * os.item_list_price * (1 - os.item_discount)),2) AS total_amount_orders,
    COUNT(customer_id) AS nbr_customers,
    SUM(os.item_quantity) AS total_quantity_sold
FROM
    {{ ref("int_localbike__orders_summary")}} AS os
GROUP BY
    order_year,
    order_month,
    order_month_name
ORDER BY
    order_year,
    order_month
