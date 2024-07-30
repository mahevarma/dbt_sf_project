{{ config(
    materialized = 'incremental',
    unique_key = 'id'
) }}

SELECT
    *
FROM
    {{ source(
        'src_jaffle_shop',
        'orders'
    ) }}

{% if is_incremental() %}
WHERE
    _ETL_LOADED_AT > (
        SELECT
            MAX(_ETL_LOADED_AT)
        FROM
            {{ this }}
    )
{% endif %}
