{{ config(materialized="table") }}

with cleaned_order_items 
as(

select order_id, product_id, status, sale_price

dense_rank() over(partition by order_id order by product_id desc ) as rank_by_id




)