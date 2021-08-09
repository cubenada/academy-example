with
    sales_people as (
        select
            /* Primary key */
            businessentityid as sales_person_id

            /* Foreign key */
            , territoryid as territory_id

            /* Columns to skip in final table */
            , salesquota
            , modifieddate
            , rowguid
            , saleslastyear
            , commissionpct
            , salesytd
            , bonus
            , _sdc_table_version
            , _sdc_received_at
            , _sdc_sequence
            , _sdc_batched_at
        from {{ source('sales_adventure_works', 'salesperson') }}
    )
    , employees as (
        select
            /* Primary key */
            businessentityid as employee_id

            /* Columns to use in marts */
            , gender

            /* Columns to skip in final table */
            , jobtitle
            , nationalidnumber
            , loginid
            , sickleavehours
            , currentflag
            , salariedflag
            , hiredate
            , vacationhours
            , birthdate	
            , maritalstatus	
            , organizationnode	
            , modifieddate
            , rowguid	
            , _sdc_batched_at	
	        , _sdc_table_version	
            , _sdc_received_at	
            , _sdc_sequence	
        from {{ source('humanresources_adventure_works', 'employee') }}
    )
    , people as (
        select
            /* Primary key */
            businessentityid as business_entity_id

            /* Columns to use in marts */
            , firstname as first_name
            , lastname as last_name

            /* Columns to skip in final table */
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
    , joined as (
        select
            /* Primary key */
            sales_people.sales_person_id

            /* Foreign key */
            , sales_people.territory_id

            /* Columns to use in marts */
            , people.first_name
            , people.last_name
            , employees.gender
        from sales_people
        left join employees
        on sales_people.sales_person_id = employees.employee_id
        left join people
        on sales_people.sales_person_id = people.business_entity_id
    )

select * from joined