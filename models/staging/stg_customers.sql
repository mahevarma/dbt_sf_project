
select id as customer_id, first_name, last_name 
from {{ source('src_jaffle_shop', 'customers')}}

