with
    state_provinces as (
        select
            /* Primary key */	
            cast(stateprovinceid as integer) as state_province_id

            /* Foreign key */
            , cast(territoryid as integer) as territory_id

            /* Columns to use in final table */
            , cast(stateprovincecode as string) as state_province_code
            , cast(`name` as string) as state_province_name
            , cast(countryregioncode as string) as country_region_code

            /* Columns to skip in final table */
            , isonlystateprovinceflag
            , modifieddate	
            , rowguid	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at	
        from {{ source('person_adventure_works', 'stateprovince')}}
    )

select * from state_provinces