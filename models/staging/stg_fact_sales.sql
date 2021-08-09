with
    sales_order_header as (
        select
            /* Primary key */
            salesorderid as order_id

            /* Foreign key */
            , salespersonid as sales_person_id
            , customerid as customer_id
            , shiptoaddressid as ship_to_address_id
            , territoryid as territory_id
            , creditcardid as credit_card_id

            /* Columns to use in final join */
            , `status`
            , shipdate as ship_date
            , orderdate as order_date
            , duedate as due_date
            , subtotal
            , taxamt
            , freight	
            , totaldue as total

            /* Keys to skip in final join */
            , billtoaddressid
            , shipmethodid
            , currencyrateid

            /* Columns to skip in final join */
            , revisionnumber
	        , onlineorderflag
            , creditcardapprovalcode
            , accountnumber
            , purchaseordernumber
            , modifieddate	
            , rowguid
            , _sdc_table_version	
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesorderheader') }}
    )
    , sales_order_details as (
        select
            /* Primary key */
            salesorderdetailid as order_detail_id

            /* Foreign keys */
            , salesorderid as order_id
            , productid as product_id

            /* Columns to use in final join */
            , orderqty as order_qty
            , unitprice as unit_price
            , unitprice * unitpricediscount as unit_price_discount
	
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
    , credit_card as (
        select
            /* Primary key */
            creditcardid as credit_card_id

            /* Columns to use in final join */
            , cardtype as card_type

            /* Columns to skip in final join */
            , cardnumber	
            , expmonth
            , expyear
            , modifieddate	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'creditcard') }}
    )
    , sales_reason as (
        select
            /* Primary key */
            salesreasonid as sales_reason_id

            /* Columns to use in final join */
            , reasontype as reason_type
            
            /* Columns to skip in final join */
            , `name`
            , modifieddate
            , _sdc_sequence
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesreason') }}
    )
    , sales_order_header_sales_reason as (
        select
            /* Primary key */
            salesreasonid as sales_reason_id

            /* Foreign key */
            , salesorderid as order_id

            /* Columns to skip in final join */
            , modifieddate
            , _sdc_sequence
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesorderheadersalesreason') }}
    )
    , joined as (
        select
            /* Primary key */
            sales_order_details.order_detail_id

            /* Foreign keys */
            , sales_order_header.order_id
            , sales_order_header.sales_person_id
            , sales_order_header.customer_id
            , sales_order_header.ship_to_address_id
            , sales_order_header.territory_id
            , sales_order_details.product_id
            
            /* Columns to use in marts table */
            , sales_order_header.`status`
            , sales_order_header.order_date
            , sales_order_header.ship_date
            , sales_order_header.due_date
            , credit_card.card_type
            , sales_reason.reason_type
            , sales_order_details.order_qty
            , sales_order_details.unit_price
            , sales_order_details.unit_price_discount
            , sales_order_header.subtotal
            , sales_order_header.taxamt
            , sales_order_header.freight	
            , sales_order_header.total

        from sales_order_details
        left join sales_order_header
        on sales_order_details.order_id = sales_order_header.order_id
        left join credit_card
        on sales_order_header.credit_card_id = credit_card.credit_card_id
        left join sales_order_header_sales_reason
        on sales_order_header.order_id = sales_order_header_sales_reason.order_id
        left join sales_reason
        on sales_order_header_sales_reason.sales_reason_id = sales_reason.sales_reason_id
    )

select * from joined