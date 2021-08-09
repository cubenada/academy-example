with
    productsubcategory as (
        select
            /* Primary key */
            cast(productsubcategoryid as integer) as product_subcategory_id

            /* Foreign key */	
            , cast(productcategoryid as integer) as product_category_id

            /* Columns to use in marts */
            , cast(`name` as string) as subcategory

            /* Columns to skip in final table */
            , modifieddate
            , rowguid	
            , _sdc_sequence	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_batched_at
        from {{ source('production_adventure_works', 'productsubcategory') }}
    )

select * from productsubcategory