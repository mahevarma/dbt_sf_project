


WITH UserSpending AS (
    SELECT
        first_name,
        last_name,
        SUM(sales_price) AS TotalAmountSpent
    FROM
        {{ref("stg_users")}}
    JOIN
        {{ref("stg_orders")}} using (id)
    JOIN
        {{ref("stg_order_items")}} using (order_id)
    WHERE
        Status NOT IN ('Cancelled', 'Returned')
    GROUP BY
        first_name, last_name
)

SELECT
    first_name,
    last_name,
    TotalAmountSpent
FROM
    UserSpending
ORDER BY
    TotalAmountSpent DESC
LIMIT 5
