SELECT
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
FROM
    {{ source("local_bike", "order_items")}}