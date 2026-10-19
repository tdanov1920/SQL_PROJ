with

source as (

    select * from {{ source('stripe', 'payment') }}

),

transformed as (
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        (amount / 100.0) as amount,
        created as payment_date
    from source
)

select * from transformed;