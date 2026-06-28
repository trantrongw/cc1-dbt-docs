

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__hr_department]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__hr_department_current])
    
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
        [company_id],
        [parent_id],
        [manager_id],
        [color],
        [master_department_id],
        [create_uid],
        [write_uid],
        [complete_name],
        [parent_path],
        [name],
        [note],
        [active],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [chief_officer_id],
        [address_id],
        [address_location_id],
        [code],
        [type],
        [account_expense_id],
        [analytic_account_id],
        [employee_feedback_template],
        [manager_feedback_template],
        [appraisal_properties_definition],
        [custom_appraisal_templates],
        [appraisal_survey_template_id],
        [dest_location_id],
        [payroll_partner_id]
from ranked
where rn = 1