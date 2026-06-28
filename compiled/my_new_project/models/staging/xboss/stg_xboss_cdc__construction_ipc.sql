


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'construction_ipc'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc])
    
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
        [project_id] int            '$.project_id',
        [ipc_type_id] int            '$.ipc_type_id',
        [contractor_id] int            '$.contractor_id',
        [analytic_id] int            '$.analytic_id',
        [company_id] int            '$.company_id',
        [site_user_id] int            '$.site_user_id',
        [approve_user_id] int            '$.approve_user_id',
        [custom_status] int            '$.custom_status',
        [user_id] int            '$.user_id',
        [currency_id] int            '$.currency_id',
        [project_manager_id] int            '$.project_manager_id',
        [custom_task_id] int            '$.custom_task_id',
        [retention_product_id] int            '$.retention_product_id',
        [advance_product_id] int            '$.advance_product_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [access_token] varchar(max)   '$.access_token',
        [name] varchar(max)   '$.name',
        [ipc_option_type] varchar(max)   '$.ipc_option_type',
        [date] int            '$.date',
        [description] varchar(max)   '$.description',
        [notes] varchar(max)   '$.notes',
        [total_amount] decimal(38,10) '$.total_amount',
        [retention_amount] decimal(38,10) '$.retention_amount',
        [net_amount] decimal(38,10) '$.net_amount',
        [advance_recovery_amount] decimal(38,10) '$.advance_recovery_amount',
        [previous_certified_amount] decimal(38,10) '$.previous_certified_amount',
        [cumulative_certified_amount] decimal(38,10) '$.cumulative_certified_amount',
        [stage_readonly] bit            '$.stage_readonly',
        [show_po_vendor_bill] bit            '$.show_po_vendor_bill',
        [active] bit            '$.active',
        [is_cancel] bit            '$.is_cancel',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [retention_percent] float          '$.retention_percent',
        [customer_id] int            '$.customer_id',
        [sale_order_id] int            '$.sale_order_id',
        [purchase_order_id] int            '$.purchase_order_id',
        [penalty_reason] varchar(max)   '$.penalty_reason',
        [deduct_terms] varchar(max)   '$.deduct_terms',
        [total_contract_amount] decimal(38,10) '$.total_contract_amount',
        [invoice_to_date_amount] decimal(38,10) '$.invoice_to_date_amount',
        [remaining_progress_billing] decimal(38,10) '$.remaining_progress_billing',
        [previously_invoiced_due] decimal(38,10) '$.previously_invoiced_due',
        [current_invoice_amount] decimal(38,10) '$.current_invoice_amount',
        [less_paid_amount] decimal(38,10) '$.less_paid_amount',
        [total_due_amount] decimal(38,10) '$.total_due_amount',
        [is_customer_ipc] bit            '$.is_customer_ipc',
        [advance_recovery_completed] bit            '$.advance_recovery_completed',
        [penalty_amount] float          '$.penalty_amount',
        [customer_advance_payment] float          '$.customer_advance_payment',
        [vendor_advance_payment] float          '$.vendor_advance_payment',
        [advance_deduct_percentage] float          '$.advance_deduct_percentage',
        [advance_pay_percentage] float          '$.advance_pay_percentage',
        [x_workflow_state] varchar(max)   '$.x_workflow_state',
        [x_workflow_approve_user] varchar(max)   '$.x_workflow_approve_user',
        [x_workflow_id] int            '$.x_workflow_id',
        [x_workflow_state_date] bigint         '$.x_workflow_state_date',
        [payment_milestone] varchar(max)   '$.payment_milestone',
        [acceptance_cert_number] varchar(max)   '$.acceptance_cert_number',
        [start_date] int            '$.start_date',
        [end_date] int            '$.end_date',
        [ipc_adjusment_amount] decimal(38,10) '$.ipc_adjusment_amount',
        [final_ipc_amount] decimal(38,10) '$.final_ipc_amount',
        [deduction_amount] decimal(38,10) '$.deduction_amount',
        [is_approved] bit            '$.is_approved',
        [total_amount_untaxed] decimal(38,10) '$.total_amount_untaxed',
        [total_amount_tax] decimal(38,10) '$.total_amount_tax',
        [previous_payment_amount] decimal(38,10) '$.previous_payment_amount',
        [current_payment_amount] decimal(38,10) '$.current_payment_amount',
        [is_paid] bit            '$.is_paid',
        [account_responsible_id] int            '$.account_responsible_id',
        [journal_id] int            '$.journal_id',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [recovery_amount] decimal(38,10) '$.recovery_amount',
        [interim_payment_ipc_id] int            '$.interim_payment_ipc_id',
        [invoice_status] varchar(max)   '$.invoice_status',
        [payment_type] varchar(max)   '$.payment_type',
        [include_interim_payment] bit            '$.include_interim_payment',
        [include_variation_payment] bit            '$.include_variation_payment',
        [advance_percentage] float          '$.advance_percentage',
        [contract_appendix_amount_untaxed] decimal(38,10) '$.contract_appendix_amount_untaxed',
        [contract_appendix_amount_tax] decimal(38,10) '$.contract_appendix_amount_tax',
        [contract_appendix_amount] decimal(38,10) '$.contract_appendix_amount',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id'
    ) as j
)

select * from cdc_keyed
