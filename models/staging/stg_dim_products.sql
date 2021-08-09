with
    products as (
        select
            /* Primary key */
            productid as product_id

            /* Foreign key */
            , productsubcategoryid as product_subcategory_id

            /* Columns to use in marts */
            , name as product_name
            , color
            , productline as product_line
            , style
            , size
            , weight
            , listprice as list_price
            , standardcost as standard_cost

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
    , productsubcategory as (
        select
            /* Primary key */
            productsubcategoryid as product_subcategory_id

            /* Foreign key */	
            , productcategoryid as product_category_id

            /* Columns to use in marts */
            , name as subcategory

            /* Columns to skip in final table */
            , modifieddate
            , rowguid	
            , _sdc_sequence	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_batched_at
        from {{ source('production_adventure_works', 'productsubcategory') }}
    )
    , productcategory as (
        select
            /* Primary key */
            productcategoryid as product_category_id

            /* Columns to use in marts */
            , name as category

            /* Columns to skip in final table */
            , modifieddate	
            , rowguid	
            , _sdc_sequence	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_batched_at
        from {{ source('production_adventure_works', 'productcategory') }}
    )
    , joined as (
        select
            /* Primary key */
            products.product_id

            /* Columns to use in marts */
            , products.product_name
            , productcategory.category
            , productsubcategory.subcategory
            , products.color
            , products.product_line
            , products.style
            , products.size
            , products.weight
            , products.list_price
            , products.standard_cost
        from products
        left join productsubcategory
        on products.product_subcategory_id = productsubcategory.product_subcategory_id
        left join productcategory
        on productsubcategory.product_category_id = productcategory.product_category_id
    )

select * from joined