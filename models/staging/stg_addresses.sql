with
    addresses as (
        select
            /* Primary key */	
            cast(addressid as integer) as address_id

            /* Foreign key */
            , cast(stateprovinceid as integer) as state_province_id

            /* Columns to use in final table */
	
            , cast(city as string) as city
            , cast(postalcode as string) as postal_code

            /* Columns to skip in final table */
            , addressline1	
            , addressline2
            , spatiallocation
	        , modifieddate
            , rowguid
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at
        from {{ source('person_adventure_works', 'address') }}
    )

select * from addresses