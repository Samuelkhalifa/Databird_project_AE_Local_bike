SELECT
    EXTRACT(MONTH FROM order_date) AS order_month,
    FORMAT_DATE('%B', order_date) AS order_month_name,
    ROUND(SUM(os.item_quantity * os.item_list_price * (1 - os.item_discount)),2) AS total_amount_orders        
FROM
    {{ ref("int_localbike__orders_summary")}} AS os
    LEFT JOIN {{ ref("int_localbike__products_summary")}} AS ps ON os.product_id = ps.product_id
GROUP BY
    order_month,
    order_month_name
ORDER BY
    order_month