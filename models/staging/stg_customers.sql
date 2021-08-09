with
    customers as (
        select 
            /* Primary key */
            cast(customerid as integer) as customer_id

            /* Foreign keys */
            , cast(personid as integer) as person_id
            , cast(territoryid as integer) as territory_id

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