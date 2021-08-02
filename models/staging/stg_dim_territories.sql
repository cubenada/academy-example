with
    addresses as (
        select
            /* Primary key */	
            addressid as address_id

            /* Foreign key */
            , stateprovinceid as state_province_id

            /* Columns to use in final table */
	
            , city
            , postalcode as postal_code

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
    , country_regions as (
        select
            /* Columns to use in final table */
            countryregioncode as country_region_code
            , name as country_region_name

            /* Columns to skip in final table */
            , modifieddate	
            , _sdc_sequence	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_batched_at
        from {{ source('person_adventure_works', 'countryregion') }}
    )
    , state_provinces as (
        select
            /* Primary key */	
            stateprovinceid as state_province_id

            /* Foreign key */
            , territoryid as territory_id

            /* Columns to use in final table */
            , stateprovincecode as state_province_code
            , name as state_province_name
            , countryregioncode as country_region_code

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
    , sales_territories as (
        select
            /* Primary key */
            territoryid as territory_id

            /* Columns to use in final table */
            , `group` as continent
            , countryregioncode as country_region_code

            /* Columns to skip in final table */
            , name as sales_territory_name
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
    , joined as (
        select
            /* Primary key */
            addresses.address_id
            
            /* Foreign key */
            , sales_territories.territory_id

            /* Columns to use in marts */
            , addresses.city
            , addresses.postal_code
            , country_regions.country_region_name
            , state_provinces.state_province_name
            , sales_territories.continent
        from addresses
        left join state_provinces
        on addresses.state_province_id = state_provinces.state_province_id
        left join country_regions
        on state_provinces.country_region_code = country_regions.country_region_code
        left join sales_territories
        on state_provinces.territory_id = sales_territories.territory_id
    )

select * from joined