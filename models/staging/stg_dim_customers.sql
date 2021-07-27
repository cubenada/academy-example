with
    customers as (
        select 
            /* Primary key */
            customerid as customer_id

            /* Foreign keys */
            , personid as person_id
            , territoryid as territory_id

            /* Columns to skip in marts */
            , storeid
            , modifieddate	
            , rowguid	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'customer') }}
    )

select * from customers