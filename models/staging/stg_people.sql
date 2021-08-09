with
    people as (
        select
            /* Primary key */
            cast(businessentityid as integer) as business_entity_id

            /* Columns to use in marts */
            , cast(firstname as string) as first_name
            , cast(lastname as string) as last_name

            /* Columns to skip in final join */
            , title
            , middlename
            , persontype
            , namestyle
            , suffix
            , emailpromotion
            , modifieddate
            , rowguid
            , _sdc_table_version
            , _sdc_batched_at
            , _sdc_received_at
            , _sdc_sequence
        from {{ source('person_adventure_works', 'person')}}
    )

select * from people