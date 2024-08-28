{{ config(materialized="table") }}

WITH RankedOrders AS (
    SELECT
        Order_Id,
        Product_Id,
        Created_At,
        ROW_NUMBER() OVER (PARTITION BY Order_Id, Product_Id ORDER BY Created_At DESC) AS rn
    FROM
        {{ source("src_ec","order_items")}}
)
SELECT
    Order_Id,
    Product_Id,
    Created_At
FROM
    RankedOrders
WHERE
    rn = 1
