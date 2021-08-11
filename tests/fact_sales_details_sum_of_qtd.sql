with 
    sum_qtd as (
        select
            sum(order_qty) as qty
        from {{ ref('fact_sales_details') }}
        where order_date between '2012-01-01' and '2012-01-31'
    )

select * from sum_qtd where qty != 3967