with
    sales_people as (
        select
            /* Primary key */
            cast(businessentityid as integer) as sales_person_id

            /* Foreign key */
            , cast(territoryid as integer) as territory_id

            /* Columns to skip in final join */
            , salesquota
            , modifieddate
            , rowguid
            , saleslastyear
            , commissionpct
            , salesytd
            , bonus
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesperson') }}
    )

select * from sales_people