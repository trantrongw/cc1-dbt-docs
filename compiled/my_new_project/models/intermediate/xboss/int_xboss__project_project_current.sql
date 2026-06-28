

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__project_project]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__project_project_current])
    
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
        [alias_id],
        [sequence],
        [partner_id],
        [company_id],
        [analytic_account_id],
        [color],
        [user_id],
        [stage_id],
        [last_update_id],
        [create_uid],
        [write_uid],
        [access_token],
        [privacy_visibility],
        [rating_status],
        [rating_status_period],
        [last_update_status],
        
DATEADD(DAY, [date_start], cast('1970-01-01' as date))
 as [date_start],
        
DATEADD(DAY, [date], cast('1970-01-01' as date))
 as [date],
        [name],
        [label_tasks],
        [task_properties_definition],
        [description],
        [active],
        [allow_task_dependencies],
        [allow_milestones],
        [rating_active],
        
DATEADD(MICROSECOND, [rating_request_deadline] % 1000000,
    DATEADD(SECOND, [rating_request_deadline] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [rating_request_deadline],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [allow_timesheets],
        [allocated_hours],
        [label_issues],
        [use_issues],
        [log_assignee],
        [stage_sequence_create],
        [due_warning],
        [project_type],
        [bryntum_auto_scheduling],
        [bryntum_user_assignment],
        
DATEADD(MICROSECOND, [project_start_date] % 1000000,
    DATEADD(SECOND, [project_start_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [project_start_date],
        [apply_default_task_analytic_from_project],
        [issue_sequence_rule_id],
        [location_id],
        [type_of_construction],
        [sale_line_id],
        [allow_billable],
        [timesheet_product_id],
        [billing_type],
        [project_category_id],
        [department_id],
        [custom_retention_percent],
        [business_unit_id],
        [x_workspace_id],
        [project_code],
        [is_manage_with_gantt],
        [is_action_plan],
        [resource_calendar_id],
        [project_department]
from ranked
where rn = 1