{{ config(materialized="table") }}


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
            cast(substring(created_at, 1, 18) as datetime) as created_at

        from {{ source('src_ec','users')}}

 
