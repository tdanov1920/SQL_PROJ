with

-- RAW CTE's

staging_customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),

staging_orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

staging_payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

-- MARTS

order_payments as (
    select order_id, 
        max(payment_date) as payment_finalized_date, 
        sum(amount) as total_amount_paid
    from  staging_payments
    where status <> 'fail'
    group by 1
),

paid_orders as (
    select o.order_id,
        o.customer_id,
        o.order_date,
        o.status as order_status,
        p.total_amount_paid,
        p.payment_finalized_date,
        c.first_name    as customer_first_name,
        c.last_name as customer_last_name,
        min(o.order_date) over 
        (partition by c.customer_id) as first_order_date
        , max(o.order_date) over 
        (partition by c.customer_id) as most_recent_order_date
        , count(o.order_id) over (partition by c.customer_id) as number_of_orders
    from  staging_orders as o
    left join order_payments as p 
    on o.order_id = p.order_id
left join staging_customers c 
on o.customer_id = c.customer_id 
),

customer_lifetime_value as (
    select
        p.order_id,
        sum(t2.total_amount_paid) as clv_bad
        from paid_orders p
        left join paid_orders t2 
        on p.customer_id = t2.customer_id and p.order_id >= t2.order_id
        group by 1
        order by p.order_id
),

final as (
    select
    p_o.*,
    row_number() over 
    (order by p_o.order_id) as transaction_seq,
    row_number() over 
    (partition by p_o.customer_id order by p_o.order_id) as customer_sales_seq,
    case when p_o.first_order_date = p_o.order_date
    then 'new'
    else 'return' end as nvsr,
    x.clv_bad as customer_lifetime_value,
    p_o.first_order_date as fdos
    from paid_orders p_o
    left outer join 
    customer_lifetime_value as x on 
    x.order_id = p_o.order_id
    order by order_id

)


select * from final;






