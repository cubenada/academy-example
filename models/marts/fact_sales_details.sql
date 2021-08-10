with
    sales_order_details as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('stg_sales_order_details.order_detail_id') }} as order_detail_sk

            /* Primary key */
            , order_detail_id

            /* Foregin key */
            , order_id
            , product_id

            /* Columns to use in marts */
            , order_qty
            , unit_price
            , unit_price_discount
        from {{ ref('stg_sales_order_details') }}
    )

select * from sales_order_details