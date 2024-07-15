{{ config(materialized='table') }}


select id as order_id,
user_id as customer_id,
status,
order_date  
from {{ source('src_jaffle_shop', 'orders')}}