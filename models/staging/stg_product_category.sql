with 
    productcategory as (
        select
            /* Primary key */
            cast(productcategoryid as integer) as product_category_id

            /* Columns to use in marts */
            , cast(`name` as string) as category

            /* Columns to skip in final table */
            , modifieddate	
            , rowguid	
            , _sdc_sequence	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_batched_at
        from {{ source('production_adventure_works', 'productcategory') }}
    )

select * from productcategory