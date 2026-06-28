


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'hr_job'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__hr_job])
    
),
cdc_keyed as (
    select
        __dbz_operation,
        __dbz_timestamp,
        __dbz_lsn,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(__dbz_timestamp as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(__dbz_lsn as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
 as __event_key,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_')), '')), 2))
      as __id,
        j.*
    from cdc_src
    cross apply OPENJSON(record_data) with (
        [id] int            '$.id',
        [sequence] int            '$.sequence',
        [expected_employees] int            '$.expected_employees',
        [no_of_employee] int            '$.no_of_employee',
        [no_of_recruitment] int            '$.no_of_recruitment',
        [no_of_hired_employee] int            '$.no_of_hired_employee',
        [department_id] int            '$.department_id',
        [company_id] int            '$.company_id',
        [contract_type_id] int            '$.contract_type_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [description] varchar(max)   '$.description',
        [requirements] varchar(max)   '$.requirements',
        [active] bit            '$.active',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [alias_id] int            '$.alias_id',
        [address_id] int            '$.address_id',
        [manager_id] int            '$.manager_id',
        [user_id] int            '$.user_id',
        [color] int            '$.color',
        [applicant_properties_definition] varchar(max)   '$.applicant_properties_definition',
        [website_id] int            '$.website_id',
        [website_meta_og_img] varchar(max)   '$.website_meta_og_img',
        [published_date] int            '$.published_date',
        [website_meta_title] varchar(max)   '$.website_meta_title',
        [website_meta_description] varchar(max)   '$.website_meta_description',
        [website_meta_keywords] varchar(max)   '$.website_meta_keywords',
        [seo_name] varchar(max)   '$.seo_name',
        [website_description] varchar(max)   '$.website_description',
        [job_details] varchar(max)   '$.job_details',
        [is_published] bit            '$.is_published',
        [currency_id] int            '$.currency_id',
        [wage] decimal(38,10) '$.wage',
        [payroll_timesheet_enabled] bit            '$.payroll_timesheet_enabled',
        [recuitment_requests_count] int            '$.recuitment_requests_count',
        [survey_id] int            '$.survey_id',
        [assessment_survey_id] int            '$.assessment_survey_id'
    ) as j
)

select * from cdc_keyed
