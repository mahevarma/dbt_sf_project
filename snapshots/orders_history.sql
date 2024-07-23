{% snapshot orders_snapshot %}
{{
        config(
          target_schema='public',
          strategy='timestamp',
          unique_key='id',
          updated_at='_ETL_LOADED_AT',
        )
 }}

select * from {{ source('src_jaffle_shop', 'orders')}}

{% endsnapshot %}

   