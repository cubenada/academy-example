with 
    purchase_order_detail as (
        select
            /* Primary key */
            purchaseorderdetailid as purchase_order_detail_id

            /* Foreign keys */
            , purchaseorderid as purchase_order_id
            , productid	as product_id

            /* Columns to use in final join */
            , duedate as due_date
            , orderqty as order_qty
            , unitprice as unit_price
            , receivedqty as received_qty
            , rejectedqty as rejected_qty

            /* Columns to skip in final join */
            , modifieddate
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('purchasing_adventure_works', 'purchaseorderdetail') }}
    )
    , purchase_order_header as (
        select
            /* Primary key */
            purchaseorderid as purchase_order_id

            /* Foreign keys */
            , vendorid as vendor_id
            , shipmethodid as ship_method_id
            , employeeid as employee_id

            /* Columns to use in final join */
            , `status`
            , orderdate as order_date
            , shipdate as ship_date
            , subtotal
            , freight
            , taxamt

            /* Columns to skip in final join */
            , revisionnumber
            , modifieddate
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at

        from {{ source('purchasing_adventure_works', 'purchaseorderheader') }}
    )
    , joined as (
        select
            /* Primary key */
            purchase_order_detail.purchase_order_detail_id

            /* Foreign keys */
            , purchase_order_detail.purchase_order_id
            , purchase_order_detail.product_id

            /* Columns to use in final join */
            , purchase_order_detail.due_date
            , purchase_order_detail.order_qty
            , purchase_order_detail.unit_price
            , purchase_order_detail.received_qty
            , purchase_order_detail.rejected_qty
        from purchase_order_detail
        left join purchase_order_header
        on purchase_order_detail.purchase_order_id = purchase_order_header.purchase_order_id
    )

select * from joined