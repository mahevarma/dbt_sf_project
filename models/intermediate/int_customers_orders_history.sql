with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('orders') }}
),
payments as (
    select * from {{ ref('stg_payments') }}
)