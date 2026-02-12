WITH monthly_sales_first_details AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        EXTRACT(MONTH FROM order_date) AS order_month,
        FORMAT_DATE('%B', order_date) AS order_month_name,
        ROUND(SUM(os.item_quantity * os.item_list_price * (1 - os.item_discount)),2) AS total_amount_orders,
        COUNT(DISTINCT customer_id) AS nbr_customers,
        os.product_id AS product_id,
        ps.product_name AS product_name,
        SUM(os.item_quantity) AS total_quantity_sold
    FROM
        {{ ref("int_localbike__orders_summary")}} AS os
        LEFT JOIN {{ ref("int_localbike__products_summary")}} AS ps ON os.product_id = ps.product_id
    GROUP BY
        order_year,
        order_month,
        order_month_name,
        product_id,
        product_name
    ORDER BY
        order_year,
        order_month
),

ranked_products AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY order_year, order_month ORDER BY total_quantity_sold DESC) AS rank_product
    FROM
        monthly_sales_first_details
)

SELECT
    *
FROM
    ranked_products
WHERE
    rank_product = 1