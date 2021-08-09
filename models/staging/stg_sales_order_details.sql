with
    sales_order_details as (
        select
            /* Primary key */
            cast(salesorderdetailid as integer) as order_detail_id

            /* Foreign keys */
            , cast(salesorderid as integer) as order_id
            , cast(productid as integer) as product_id

            /* Columns to use in final join */
            , cast(orderqty as integer) as order_qty
            , cast(unitprice as numeric) as unit_price
            , cast((unitprice * unitpricediscount) as numeric) as unit_price_discount
	
            /* Columns to skip in final join */
            , carriertrackingnumber
            , modifieddate
            , rowguid
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesorderdetail') }}
    )

select * from sales_order_details