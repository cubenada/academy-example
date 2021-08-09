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
    , purchase_order_header as (
        select
            /* Primary key */
            cast(purchaseorderid as integer) as purchase_order_id

            /* Foreign keys */
            , cast(vendorid as integer) as vendor_id
            , cast(shipmethodid as integer) as ship_method_id
            , cast(employeeid as integer) as employee_id

            /* Columns to use in final join */
            , cast(`status` as integer) as `status`
            , cast(orderdate as date) as order_date
            , cast(shipdate as date) as ship_date
            , cast(freight as numeric) as freight
            , cast(taxamt as numeric) as taxamt

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