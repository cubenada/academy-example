with
    credit_card as (
        select
            /* Primary key */
            cast(creditcardid as integer) as credit_card_id

            /* Columns to use in final join */
            , cast(cardtype as string) as card_type

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

select * from credit_card