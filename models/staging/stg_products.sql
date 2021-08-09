with
    products as (
        select
            /* Primary key */
            cast(productid as integer) as product_id

            /* Foreign key */
            , cast(productsubcategoryid as integer) as product_subcategory_id

            /* Columns to use in marts */
            , cast(`name` as string) as product_name
            , cast(color as string) as color
            , cast(productline as string) as product_line
            , cast(style as string) as style
            , cast(size as string) as size
            , cast(`weight` as numeric) as `weight`
            , cast(listprice as numeric) as list_price
            , cast(standardcost as numeric) as standard_cost

            /* Columns to skip in final table */
            , productmodelid
            , sellstartdate	
            , sellenddate
            , safetystocklevel
            , finishedgoodsflag
            , class
            , makeflag
            , productnumber
            , daystomanufacture
            , reorderpoint
            , weightunitmeasurecode
            , sizeunitmeasurecode
            , modifieddate
            , rowguid
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('production_adventure_works', 'product') }}
        where finishedgoodsflag = True
    )

select * from products