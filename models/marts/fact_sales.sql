with 
    sales as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('sales_order_header.order_id') }} as order_sk

            /* Primary key */
            , sales_order_header.order_id

            /* Foreign keys */
            , sales_order_header.sales_person_id
            , sales_order_header.customer_id
            , sales_order_header.ship_to_address_id
            
            /* Columns to use in marts table */
            , sales_order_header.`status`
            , sales_order_header.order_date
            , sales_order_header.ship_date
            , sales_order_header.due_date
            , credit_cards.card_type
            , sales_order_header.subtotal
            , sales_order_header.taxamt
            , sales_order_header.freight
            , sales_order_header.total
        from {{ ref('stg_sales_order_header') }} as sales_order_header
        left join {{ ref('stg_credit_cards') }} as credit_cards
        on sales_order_header.credit_card_id = credit_cards.credit_card_id
    )

select * from sales