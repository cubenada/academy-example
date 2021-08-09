with 
    customers as (
        select
            {{ dbt_utils.surrogate_key('customer_id') }} as customer_sk
            , *
        from {{ ref('stg_customers')}}
    )

select * from customers