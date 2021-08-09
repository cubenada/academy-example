with
    employees as (
        select
            /* Primary key */
            cast(businessentityid as integer) as employee_id

            /* Columns to use in marts */
            , cast(gender as string) as gender

            /* Columns to skip in final join */
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

select * from employees