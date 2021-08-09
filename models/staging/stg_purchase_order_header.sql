with
    purchase_order_header as (
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

select * from purchase_order_header