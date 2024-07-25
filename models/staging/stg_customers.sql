select id as cust_id, first_name, last_name 
from {{source('src_jaffle_shop','customers')}}