with 
    sum_qty as (
        select
            sum(order_qty) as qty
        from {{ ref('fact_purchasing') }}
        where due_date between '2012-01-01' and '2012-01-31'
    )

select * from sum_qty where qty != 13109