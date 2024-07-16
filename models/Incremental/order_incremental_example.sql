{{ config(
    materialized='incremental',
    unique_key='id'
) }}

select * from {{ source('src_jaffle_shop', 'orders')}} 


{% if is_incremental() %}

where _ETL_LOADED_AT > (Select max(_ETL_LOADED_AT) from {{this}})

{% endif %}