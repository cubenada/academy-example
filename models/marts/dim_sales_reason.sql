with 
    sales_reason as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('order_id') }} as order_sk

            /* Primary key */
            , sales_order_header_sales_reason.order_id

            /* Columuns to use in marts */
            , sales_reason.reason_type
            , sales_reason.reason_description
        from {{ ref('stg_sales_order_header_sales_reason') }} as sales_order_header_sales_reason
        left join {{ ref('stg_sales_reason') }} as sales_reason
        on sales_order_header_sales_reason.sales_reason_id = sales_reason.sales_reason_id
)

select * from sales_reason