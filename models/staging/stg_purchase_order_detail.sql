with 
    purchase_order_detail as (
        select
            /* Primary key */
            cast(purchaseorderdetailid as integer) as purchase_order_detail_id

            /* Foreign keys */
            , cast(purchaseorderid as integer) as purchase_order_id
            , cast(productid as integer) as product_id

            /* Columns to use in final join */
            , cast(duedate as date) as due_date
            , cast(orderqty as integer) as order_qty
            , cast(unitprice as numeric) as unit_price
            , cast(receivedqty as integer) as received_qty
            , cast(rejectedqty as integer) as rejected_qty

            /* Columns to skip in final join */
            , modifieddate
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('purchasing_adventure_works', 'purchaseorderdetail') }}
    )

select * from purchase_order_detail