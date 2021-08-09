with
    sales_order_header as (
        select
            /* Primary key */
            cast(salesorderid as integer) as order_id

            /* Foreign key */
            , cast(salespersonid as integer) as sales_person_id
            , cast(customerid as integer) as customer_id
            , cast(shiptoaddressid as integer) as ship_to_address_id
            , cast(territoryid as integer) as territory_id
            , cast(creditcardid as integer) as credit_card_id

            /* Columns to use in final join */
            , cast(`status` as integer) as `status`
            , cast(shipdate as date) as ship_date
            , cast(orderdate as date) as order_date
            , cast(duedate as date) as due_date
            , cast(subtotal as numeric) as subtotal
            , cast(taxamt as numeric) as taxamt
            , cast(freight as numeric) as freight
            , cast(totaldue as numeric) as total

            /* Columns to skip in final join */
            , billtoaddressid
            , shipmethodid
            , currencyrateid
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

select * from sales_order_header