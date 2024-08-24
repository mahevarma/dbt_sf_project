{{ config(materialized="table") }}

with
    stg_users as (
        select
            id as user_id,
            first_name,
            last_name,
            email,
            age,
            gender,
            state,
            street_address,
            postal_code,
            city,
            country,
            latitude,
            longitude,
            traffic_source,
            cast(substring('created_at', 1, 18) as datetime)

        from {{ source('src_ec','users')}}

    )

select *
from stg_users
