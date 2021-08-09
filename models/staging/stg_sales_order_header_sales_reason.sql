with
    sales_order_header_sales_reason as (
        select
            /* Primary key */
            cast(salesreasonid as integer) as sales_reason_id

            /* Foreign key */
            , cast(salesorderid as integer) as order_id

            /* Columns to skip in final join */
            , modifieddate
            , _sdc_sequence
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesorderheadersalesreason') }}
    )

select * from sales_order_header_sales_reason