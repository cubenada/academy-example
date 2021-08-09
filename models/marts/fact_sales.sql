with 
    sales as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('sales_order_header.order_id') }} as order_sk

            /* Primary key */
            , sales_order_details.order_detail_id

            /* Foreign keys */
            , sales_order_header.order_id
            , sales_order_header.sales_person_id
            , sales_order_header.customer_id
            , sales_order_header.ship_to_address_id
            , sales_order_header.territory_id
            , sales_order_details.product_id
            
            /* Columns to use in marts table */
            , sales_order_header.`status`
            , sales_order_header.order_date
            , sales_order_header.ship_date
            , sales_order_header.due_date
            , credit_cards.card_type
            , sales_reason.reason_type
            , sales_order_details.order_qty
            , sales_order_details.unit_price
            , sales_order_details.unit_price_discount
            , sales_order_header.subtotal
            , sales_order_header.taxamt
            , sales_order_header.freight
            , sales_order_header.total
        from {{ ref('stg_sales_order_details') }} as sales_order_details
        left join {{ ref('stg_sales_order_header') }} as sales_order_header
        on sales_order_details.order_id = sales_order_header.order_id
        left join {{ ref('stg_credit_cards') }} as credit_cards
        on sales_order_header.credit_card_id = credit_cards.credit_card_id
        left join {{ ref('stg_sales_order_header_sales_reason') }} as sales_order_header_sales_reason
        on sales_order_header.order_id = sales_order_header_sales_reason.order_id
        left join {{ ref('stg_sales_reason') }} as sales_reason
        on sales_order_header_sales_reason.sales_reason_id = sales_reason.sales_reason_id
    )

select * from sales