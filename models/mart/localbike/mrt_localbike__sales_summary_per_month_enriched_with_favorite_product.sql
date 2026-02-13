SELECT
    ss.*,
    fp.product_id AS favorite_product_id,
    fp.product_name AS favorite_product_name,
    fp.total_quantity_sold AS favorite_product_total_quantity_sold,
    fp.total_amount_in_orders AS favorite_product_total_amount_in_orders
FROM
    {{ ref("mrt_localbike__sales_summary_per_month")}} AS ss
    LEFT JOIN {{ ref("mrt_localbike__favorite_product_per_month")}} AS fp
        ON ss.order_year = fp.order_year AND ss.order_month = fp.order_month
    