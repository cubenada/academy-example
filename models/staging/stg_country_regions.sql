with
    country_regions as (
        select
            /* Columns to use in final table */
            cast(countryregioncode as string) as country_region_code
            , cast(`name` as string) as country_region_name

            /* Columns to skip in final table */
            , modifieddate	
            , _sdc_sequence	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_batched_at
        from {{ source('person_adventure_works', 'countryregion') }}
    )

select * from country_regions