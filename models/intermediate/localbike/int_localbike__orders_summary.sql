SELECT
    o.order_id,
    order_status,
    order_date,
    required_date,
    shipped_date,
    o.store_id,
    o.staff_id,
    o.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    c.phone AS customer_phone,
    c.email AS customer_email,
    c.street AS customer_street,
    c.city AS customer_city,
    c.state AS customer_state,
    c.zip_code AS customer_zip_code,
    s.first_name AS staff_first_name,
    s.last_name AS staff_last_name,
    s.email AS staff_email,
    s.phone AS staff_phone,
    s.active AS staff_active,
    s.manager_id,
    store_name,
    st.phone AS store_phone,
    st.email AS store_email,
    st.street AS store_street,
    st.city AS store_city,
    st.state AS store_state,
    st.zip_code AS store_zip_code,
    oi.item_id,
    oi.product_id,
    oi.quantity AS item_quantity,
    oi.list_price AS item_list_price,
    oi.discount AS item_discount
FROM
    {{ ref("stg_localbike__orders")}} AS o
    LEFT JOIN {{ ref("stg_localbike__customers")}} AS c ON o.customer_id = c.customer_id
    LEFT JOIN {{ ref("stg_localbike__staffs")}} AS s ON o.staff_id = s.staff_id
    LEFT JOIN {{ ref("stg_localbike__stores")}} AS st ON o.store_id = st.store_id
    LEFT JOIN {{ ref("stg_localbike__order_items")}} AS oi ON o.order_id = oi.order_id