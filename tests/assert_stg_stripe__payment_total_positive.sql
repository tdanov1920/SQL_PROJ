with payments as (
    select
        order_id,
        sum(amount) as total_amount
    from {{ ref('stg_stripe__payments') }}
    group by order_id
)

select *
from payments
where total_amount < 0