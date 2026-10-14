select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount is usually stored in cents, divide by 100 to get dollars
    amount / 100.0 as amount

from {{ source('stripe', 'payment') }}