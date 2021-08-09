with
    sales_reason as (
        select
            /* Primary key */
            cast(salesreasonid as integer) as sales_reason_id

            /* Columns to use in final join */
            , cast(reasontype as string) as reason_type
            
            /* Columns to skip in final join */
            , `name`
            , modifieddate
            , _sdc_sequence
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesreason') }}
    )

select * from sales_reason