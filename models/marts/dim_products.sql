with
    products as (
        select
            /* Surrogate key*/
            {{ dbt_utils.surrogate_key('product_id') }} as product_sk

            /* Primary key */
            , products.product_id

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
        from {{ ref('stg_products') }} as products
        left join {{ ref('stg_product_subcategory') }} as productsubcategory
        on products.product_subcategory_id = productsubcategory.product_subcategory_id
        left join {{ ref('stg_product_category') }} as productcategory
        on productsubcategory.product_category_id = productcategory.product_category_id
    )

select * from products