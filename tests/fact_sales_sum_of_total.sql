with 
    sum_total as (
        select
            round(sum(total), 2) as total
        from {{ ref('fact_sales') }}
        where order_date between '2012-01-01' and '2012-01-31'
    )

select * from sum_total where total != 4458337.44