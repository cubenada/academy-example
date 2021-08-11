with
    sales_order_details as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('sales_details.order_detail_id') }} as order_detail_sk

            /* Primary key */
            , sales_details.order_detail_id

            /* Foregin key */
            , sales_details.order_id
            , sales_details.product_id

            /* Columns to use in marts */
            , sales.order_date
            , sales_details.order_qty
            , sales_details.unit_price
            , sales_details.unit_price_discount
        from {{ ref('stg_sales_order_details') }} as sales_details
        left join {{ ref('stg_sales_order_header') }} as sales
        on sales_details.order_id = sales.order_id
    )

select * from sales_order_details