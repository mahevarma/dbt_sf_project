{{ config(
    materialized='incremental'
) }}

select * from {{ source('src_jaffle_shop', 'orders')}} -- 1 lack -- 5min
tomm - 5 records

{% if is_incremental() %}

where _ETL_LOADED_AT > (Select max(_ETL_LOADED_AT) from {{this}})

{% endif %}