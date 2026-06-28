


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'hr_department'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__hr_department])
    
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
        [company_id] int            '$.company_id',
        [parent_id] int            '$.parent_id',
        [manager_id] int            '$.manager_id',
        [color] int            '$.color',
        [master_department_id] int            '$.master_department_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [complete_name] varchar(max)   '$.complete_name',
        [parent_path] varchar(max)   '$.parent_path',
        [name] varchar(max)   '$.name',
        [note] varchar(max)   '$.note',
        [active] bit            '$.active',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [chief_officer_id] int            '$.chief_officer_id',
        [address_id] int            '$.address_id',
        [address_location_id] int            '$.address_location_id',
        [code] varchar(max)   '$.code',
        [type] varchar(max)   '$.type',
        [account_expense_id] int            '$.account_expense_id',
        [analytic_account_id] int            '$.analytic_account_id',
        [employee_feedback_template] varchar(max)   '$.employee_feedback_template',
        [manager_feedback_template] varchar(max)   '$.manager_feedback_template',
        [appraisal_properties_definition] varchar(max)   '$.appraisal_properties_definition',
        [custom_appraisal_templates] bit            '$.custom_appraisal_templates',
        [appraisal_survey_template_id] int            '$.appraisal_survey_template_id',
        [dest_location_id] int            '$.dest_location_id',
        [payroll_partner_id] int            '$.payroll_partner_id'
    ) as j
)

select * from cdc_keyed
