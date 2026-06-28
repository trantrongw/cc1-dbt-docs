

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__hr_job]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__hr_job_current])
    
),
ranked as (
    select *,
           ROW_NUMBER() OVER (PARTITION BY __id ORDER BY __dbz_timestamp DESC, __dbz_lsn DESC) as rn
    from staged
)
select
    __dbz_operation,
    __dbz_timestamp,
    __dbz_lsn,
    __id,
    case when __dbz_operation = 'd' then 1 else 0 end as __is_deleted,
    __dbz_timestamp                                    as __last_changed_at,
        [id],
        [sequence],
        [expected_employees],
        [no_of_employee],
        [no_of_recruitment],
        [no_of_hired_employee],
        [department_id],
        [company_id],
        [contract_type_id],
        [create_uid],
        [write_uid],
        [name],
        [description],
        [requirements],
        [active],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [alias_id],
        [address_id],
        [manager_id],
        [user_id],
        [color],
        [applicant_properties_definition],
        [website_id],
        [website_meta_og_img],
        
DATEADD(DAY, [published_date], cast('1970-01-01' as date))
 as [published_date],
        [website_meta_title],
        [website_meta_description],
        [website_meta_keywords],
        [seo_name],
        [website_description],
        [job_details],
        [is_published],
        [currency_id],
        [wage],
        [payroll_timesheet_enabled],
        [recuitment_requests_count],
        [survey_id],
        [assessment_survey_id]
from ranked
where rn = 1