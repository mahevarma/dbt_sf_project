select id payment_id, orderid as oder_id, status, amount,created as payment_date from 
{{ source('src_jaffle_payments', 'payment')}}