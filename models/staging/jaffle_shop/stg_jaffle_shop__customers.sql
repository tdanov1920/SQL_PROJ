with

staging_customers as (
    select * from {{ source('jaffle_shop', 'customers') }}
),

transformed as (

    select 
        id as customer_id,
        first_name,
        last_name
    from staging_customers

)

select * from transformed