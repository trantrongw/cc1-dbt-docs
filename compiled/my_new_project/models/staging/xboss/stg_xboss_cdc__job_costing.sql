


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'job_costing'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__job_costing])
    
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
        [user_id] int            '$.user_id',
        [currency_id] int            '$.currency_id',
        [company_id] int            '$.company_id',
        [project_id] int            '$.project_id',
        [analytic_id] int            '$.analytic_id',
        [partner_id] int            '$.partner_id',
        [task_id] int            '$.task_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [access_token] varchar(max)   '$.access_token',
        [number] varchar(max)   '$.number',
        [name] varchar(max)   '$.name',
        [description] varchar(max)   '$.description',
        [state] varchar(max)   '$.state',
        [so_number] varchar(max)   '$.so_number',
        [contract_date] int            '$.contract_date',
        [start_date] int            '$.start_date',
        [complete_date] int            '$.complete_date',
        [notes_job] varchar(max)   '$.notes_job',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [material_total] decimal(38,10) '$.material_total',
        [labor_total] decimal(38,10) '$.labor_total',
        [overhead_total] decimal(38,10) '$.overhead_total',
        [jobcost_total] decimal(38,10) '$.jobcost_total',
        [custom_analytic_plan_id] int            '$.custom_analytic_plan_id',
        [custom_allow_budget_project] varchar(max)   '$.custom_allow_budget_project',
        [requisition_count] int            '$.requisition_count',
        [custom_cost_type] varchar(max)   '$.custom_cost_type',
        [billable_method] varchar(max)   '$.billable_method',
        [sale_order_id] int            '$.sale_order_id',
        [source_job_cost_id] int            '$.source_job_cost_id',
        [revision_number] int            '$.revision_number',
        [next_jobcost_revision_id] int            '$.next_jobcost_revision_id',
        [previous_jobcost_revision_id] int            '$.previous_jobcost_revision_id',
        [allow_validation_percentage] float          '$.allow_validation_percentage',
        [planned_revenue_total] decimal(38,10) '$.planned_revenue_total',
        [actual_revenue_total] decimal(38,10) '$.actual_revenue_total',
        [planned_pl_percent] decimal(38,10) '$.planned_pl_percent',
        [planned_pl_amount] decimal(38,10) '$.planned_pl_amount',
        [actual_pl_percent] decimal(38,10) '$.actual_pl_percent',
        [actual_pl_amount] decimal(38,10) '$.actual_pl_amount',
        [actual_cost_total] decimal(38,10) '$.actual_cost_total',
        [x_workflow_state] varchar(max)   '$.x_workflow_state',
        [x_workflow_approve_user] varchar(max)   '$.x_workflow_approve_user',
        [x_workflow_id] int            '$.x_workflow_id',
        [x_workflow_state_date] bigint         '$.x_workflow_state_date',
        [business_type] varchar(max)   '$.business_type',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [department_id] int            '$.department_id',
        [note_total_receivable_debt] varchar(max)   '$.note_total_receivable_debt',
        [note_overdue_debt] varchar(max)   '$.note_overdue_debt',
        [note_current_debt] varchar(max)   '$.note_current_debt',
        [total_receivable_debt] decimal(38,10) '$.total_receivable_debt',
        [overdue_debt] decimal(38,10) '$.overdue_debt',
        [current_debt] decimal(38,10) '$.current_debt',
        [x_workflow_config_id] int            '$.x_workflow_config_id',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id',
        [note_credit_limit] varchar(max)   '$.note_credit_limit',
        [credit_limit] decimal(38,10) '$.credit_limit',
        [main_attachment_id] int            '$.main_attachment_id',
        [template_report] varchar(max)   '$.template_report'
    ) as j
)

select * from cdc_keyed
