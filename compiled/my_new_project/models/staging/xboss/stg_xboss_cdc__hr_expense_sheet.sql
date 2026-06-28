


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'hr_expense_sheet'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__hr_expense_sheet])
    
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
        [message_main_attachment_id] int            '$.message_main_attachment_id',
        [company_id] int            '$.company_id',
        [employee_id] int            '$.employee_id',
        [department_id] int            '$.department_id',
        [user_id] int            '$.user_id',
        [currency_id] int            '$.currency_id',
        [employee_journal_id] int            '$.employee_journal_id',
        [payment_method_line_id] int            '$.payment_method_line_id',
        [journal_id] int            '$.journal_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [state] varchar(max)   '$.state',
        [approval_state] varchar(max)   '$.approval_state',
        [payment_state] varchar(max)   '$.payment_state',
        [accounting_date] int            '$.accounting_date',
        [total_amount] decimal(38,10) '$.total_amount',
        [untaxed_amount] decimal(38,10) '$.untaxed_amount',
        [total_tax_amount] decimal(38,10) '$.total_tax_amount',
        [amount_residual] decimal(38,10) '$.amount_residual',
        [approval_date] bigint         '$.approval_date',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [business_trip_request_id] int            '$.business_trip_request_id',
        [vendor_bill_journal_id] int            '$.vendor_bill_journal_id',
        [has_invoice] bit            '$.has_invoice',
        [invisible_payment] bit            '$.invisible_payment',
        [responsible_id] int            '$.responsible_id',
        [code] varchar(max)   '$.code',
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
        [workflow_type] varchar(max)   '$.workflow_type',
        [deadline_request] int            '$.deadline_request',
        [date_request] int            '$.date_request',
        [payment_deadline] int            '$.payment_deadline',
        [final_approval_date] int            '$.final_approval_date',
        [approved_amount] decimal(38,10) '$.approved_amount',
        [is_ready_payment] bit            '$.is_ready_payment',
        [balance_amount] float          '$.balance_amount',
        [balance_amount_display] float          '$.balance_amount_display',
        [balance_negative_amount] float          '$.balance_negative_amount',
        [return_amount] float          '$.return_amount',
        [payment_amount] float          '$.payment_amount',
        [transfer_amount] float          '$.transfer_amount',
        [payment_mode] varchar(max)   '$.payment_mode',
        [is_sample_document] bit            '$.is_sample_document',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [company_currency_id] int            '$.company_currency_id',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [force_pass_unique_ref] bit            '$.force_pass_unique_ref',
        [note] varchar(max)   '$.note',
        [is_unplanned] bit            '$.is_unplanned',
        [active] bit            '$.active',
        [last_approver_id] int            '$.last_approver_id',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id',
        [is_advance_exceeding_paid_amount] bit            '$.is_advance_exceeding_paid_amount',
        [is_payment_order_created] bit            '$.is_payment_order_created',
        [jva_reimbursement_amount] decimal(38,10) '$.jva_reimbursement_amount',
        [jva_operating_cost] decimal(38,10) '$.jva_operating_cost',
        [jva_construction_support_cost] decimal(38,10) '$.jva_construction_support_cost',
        [jva_paid_amount] decimal(38,10) '$.jva_paid_amount',
        [jva_remain_amount] decimal(38,10) '$.jva_remain_amount',
        [is_joint_venture_agreement] bit            '$.is_joint_venture_agreement'
    ) as j
)

select * from cdc_keyed
