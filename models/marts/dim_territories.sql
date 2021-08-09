with 
    territories as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('address_id') }} as address_sk

            /* Primary key */
            , addresses.address_id

            /* Columns to use in marts */
            , addresses.city
            , addresses.postal_code
            , country_regions.country_region_name
            , state_provinces.state_province_name
            , sales_territories.continent
        from {{ ref('stg_addresses') }} as addresses
        left join {{ ref('stg_state_provinces') }} as state_provinces
        on addresses.state_province_id = state_provinces.state_province_id
        left join {{ ref('stg_country_regions') }} as country_regions
        on state_provinces.country_region_code = country_regions.country_region_code
        left join {{ ref('stg_sales_territories') }} as sales_territories
        on state_provinces.territory_id = sales_territories.territory_id
    )

select * from territories