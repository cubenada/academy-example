with 
    customers as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('customers2.customer_id') }} as customer_sk

            /* Primary key */
            , customers2.customer_id

            /* Foreign keys */
            , customers2.person_id
            , customers2.territory_id

            /* Columns to use in marts */
            , people.first_name
            , people.last_name
        from {{ ref('stg_customers')}} as customers2
        left join {{ ref('stg_people') }} as people
        on customers2.person_id = people.business_entity_id
    )

select * from customers