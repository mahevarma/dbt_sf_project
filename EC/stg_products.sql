{{ config(materialized="view") }}

with
    stg_products as (

        select
           id as product_id,
           cost,	
           category,
           name,	
           brand,
           retail_price,
           department,
           sku,
           distribution_center_id


        from {{ source('src_ec','products')}}

    )

select *
from stg_products
