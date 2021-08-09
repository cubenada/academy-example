with
    sales_territories as (
        select
            /* Primary key */
            cast(territoryid as integer) as territory_id

            /* Columns to use in final table */
            , cast(`group` as string) as continent
            , cast(countryregioncode as string) as country_region_code

            /* Columns to skip in final table */
            , `name`
            , costlastyear	
            , salesytd
	        , saleslastyear	
            , costytd
            , modifieddate	
            , rowguid
            , _sdc_table_version		
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at	
	
        from {{ source('sales_adventure_works', 'salesterritory') }}
    )

select * from sales_territories