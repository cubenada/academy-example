with
    customers as (
        select 
            /* Primary key */
            customerid as customer_id

            /* Foreign keys */
            , personid as person_id
            , territoryid as territory_id

            /* Columns to skip in marts */
            , storeid
            , modifieddate	
            , rowguid	
            , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_sequence	
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'customer') }}
    )
    , people as (
        select 
            /* Primary key */
            businessentityid as business_entity_id

            /* Columns to use in marts */
            , firstname	as first_name
            , middlename as middle_name
            , lastname as last_name
            , title

            /* Columns to skip in marts */
            , persontype
            , namestyle
            , suffix
            , emailpromotion
            , modifieddate
            , rowguid
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('person_adventure_works', 'person')}}
    )
    , businessentitycontacts as (
        select
            /* Primary key */
            businessentityid as business_entity_id

            /* Foreign keys */
            , personid as person_id

            /* Columns to skip in marts */
            , contacttypeid
            , modifieddate
            , rowguid
            , _sdc_sequence
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_batched_at
        from {{ source('person_adventure_works', 'businessentitycontact')}}
    )
    , joined as (
        select 
            /* Primary key */
            customers.customer_id

            /* Foreign keys */
            , customers.person_id
            , customers.territory_id
            , businessentitycontacts.business_entity_id

            /* Columns to use in marts */
            , people.first_name
            , people.middle_name
            , people.last_name
            , people.title
        from customers
        left join businessentitycontacts
        on customers.person_id = businessentitycontacts.person_id
        left join people
        on businessentitycontacts.business_entity_id = people.business_entity_id
    )

select * from joined