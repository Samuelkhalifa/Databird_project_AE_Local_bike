SELECT
    p.product_id,
    product_name,
    p.brand_id,
    p.category_id,
    model_year,
    list_price,
    c.category_name,
    store_id,
    quantity,
    b.brand_name
FROM
    {{ ref("stg_localbike__products")}} AS p
    LEFT JOIN {{ ref("stg_localbike__categories")}} AS c ON p.category_id = c.category_id
    LEFT JOIN {{ ref("stg_localbike__stocks")}} AS s ON p.product_id = s.product_id
    LEFT JOIN {{ ref("stg_localbike__brands")}} AS b ON p.brand_id = b.brand_id
