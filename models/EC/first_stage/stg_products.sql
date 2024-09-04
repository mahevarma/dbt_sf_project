{{ config(materialized="view") }}


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

  
