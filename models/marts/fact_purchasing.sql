with 
    purchasing as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('purchase_order_detail_id') }} as purchase_order_detail_sk

            /* Primary key */
            , purchase_order_detail.purchase_order_detail_id

            /* Foreign keys */
            , purchase_order_detail.purchase_order_id
            , purchase_order_detail.product_id

            /* Columns to use in final join */
            , purchase_order_detail.due_date
            , purchase_order_detail.order_qty
            , purchase_order_detail.unit_price
            , purchase_order_detail.received_qty
            , purchase_order_detail.rejected_qty
        from {{ ref('stg_purchase_order_detail') }} as purchase_order_detail
        left join {{ ref('stg_purchase_order_header') }} as purchase_order_header
        on purchase_order_detail.purchase_order_id = purchase_order_header.purchase_order_id
    )

select * from purchasing