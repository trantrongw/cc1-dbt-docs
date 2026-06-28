

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__job_costing]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__job_costing_current])
    
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
        [user_id],
        [currency_id],
        [company_id],
        [project_id],
        [analytic_id],
        [partner_id],
        [task_id],
        [create_uid],
        [write_uid],
        [access_token],
        [number],
        [name],
        [description],
        [state],
        [so_number],
        
DATEADD(DAY, [contract_date], cast('1970-01-01' as date))
 as [contract_date],
        
DATEADD(DAY, [start_date], cast('1970-01-01' as date))
 as [start_date],
        
DATEADD(DAY, [complete_date], cast('1970-01-01' as date))
 as [complete_date],
        [notes_job],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [material_total],
        [labor_total],
        [overhead_total],
        [jobcost_total],
        [custom_analytic_plan_id],
        [custom_allow_budget_project],
        [requisition_count],
        [custom_cost_type],
        [billable_method],
        [sale_order_id],
        [source_job_cost_id],
        [revision_number],
        [next_jobcost_revision_id],
        [previous_jobcost_revision_id],
        [allow_validation_percentage],
        [planned_revenue_total],
        [actual_revenue_total],
        [planned_pl_percent],
        [planned_pl_amount],
        [actual_pl_percent],
        [actual_pl_amount],
        [actual_cost_total],
        [x_workflow_state],
        [x_workflow_approve_user],
        [x_workflow_id],
        
DATEADD(MICROSECOND, [x_workflow_state_date] % 1000000,
    DATEADD(SECOND, [x_workflow_state_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [x_workflow_state_date],
        [business_type],
        [x_workflow_stage_id],
        [department_id],
        [note_total_receivable_debt],
        [note_overdue_debt],
        [note_current_debt],
        [total_receivable_debt],
        [overdue_debt],
        [current_debt],
        [x_workflow_config_id],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id],
        [note_credit_limit],
        [credit_limit],
        [main_attachment_id],
        [template_report]
from ranked
where rn = 1