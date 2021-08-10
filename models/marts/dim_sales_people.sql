with
    sales_people as (
        select
            /* Surrogate key */
            {{ dbt_utils.surrogate_key('sales_person_id') }} as sales_person_sk

            /* Primary key */
            , sales_people.sales_person_id

            /* Columns to use in marts */
            , people.first_name
            , people.last_name
            , employees.gender
        from {{ ref('stg_sales_people') }} as sales_people
        left join {{ ref('stg_employees') }} as employees
        on sales_people.sales_person_id = employees.employee_id
        left join {{ ref('stg_people') }} as people
        on sales_people.sales_person_id = people.business_entity_id
    )

select * from sales_people