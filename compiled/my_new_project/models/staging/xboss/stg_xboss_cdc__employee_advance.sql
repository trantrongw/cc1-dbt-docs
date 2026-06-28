


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'employee_advance'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__employee_advance])
    
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
        [employee_id] int            '$.employee_id',
        [job_id] int            '$.job_id',
        [department_id] int            '$.department_id',
        [company_id] int            '$.company_id',
        [journal_id] int            '$.journal_id',
        [currency_id] int            '$.currency_id',
        [responsible_id] int            '$.responsible_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [payment_state] varchar(max)   '$.payment_state',
        [state] varchar(max)   '$.state',
        [date] int            '$.date',
        [amount] decimal(38,10) '$.amount',
        [approved_amount] decimal(38,10) '$.approved_amount',
        [balance] decimal(38,10) '$.balance',
        [to_reconcile_amount] decimal(38,10) '$.to_reconcile_amount',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [x_workflow_state] varchar(max)   '$.x_workflow_state',
        [x_workflow_approve_user] varchar(max)   '$.x_workflow_approve_user',
        [x_workflow_id] int            '$.x_workflow_id',
        [x_workflow_state_date] bigint         '$.x_workflow_state_date',
        [main_attachment_id] int            '$.main_attachment_id',
        [expense_workflow_id] int            '$.expense_workflow_id',
        [account_responsible_id] int            '$.account_responsible_id',
        [partner_id] int            '$.partner_id',
        [partner_bank_id] int            '$.partner_bank_id',
        [label] varchar(max)   '$.label',
        [priority] varchar(max)   '$.priority',
        [mode_payment] varchar(max)   '$.mode_payment',
        [cash_receiver] varchar(max)   '$.cash_receiver',
        [deadline_request] int            '$.deadline_request',
        [date_request] int            '$.date_request',
        [payment_deadline] int            '$.payment_deadline',
        [final_approval_date] int            '$.final_approval_date',
        [date_return] int            '$.date_return',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [is_ready_payment] bit            '$.is_ready_payment',
        [is_sample_document] bit            '$.is_sample_document',
        [material_requisition_id] int            '$.material_requisition_id',
        [workflow_type] varchar(max)   '$.workflow_type',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [active] bit            '$.active',
        [amount_residual] decimal(38,10) '$.amount_residual',
        [last_approver_id] int            '$.last_approver_id',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id',
        [workflow_mode] varchar(max)   '$.workflow_mode',
        [is_payment_order_created] bit            '$.is_payment_order_created',
        [is_joint_venture_agreement] bit            '$.is_joint_venture_agreement'
    ) as j
)

select * from cdc_keyed
