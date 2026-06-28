

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__construction_ipc_current])
    
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
        [project_id],
        [ipc_type_id],
        [contractor_id],
        [analytic_id],
        [company_id],
        [site_user_id],
        [approve_user_id],
        [custom_status],
        [user_id],
        [currency_id],
        [project_manager_id],
        [custom_task_id],
        [retention_product_id],
        [advance_product_id],
        [create_uid],
        [write_uid],
        [access_token],
        [name],
        [ipc_option_type],
        
DATEADD(DAY, [date], cast('1970-01-01' as date))
 as [date],
        [description],
        [notes],
        [total_amount],
        [retention_amount],
        [net_amount],
        [advance_recovery_amount],
        [previous_certified_amount],
        [cumulative_certified_amount],
        [stage_readonly],
        [show_po_vendor_bill],
        [active],
        [is_cancel],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [retention_percent],
        [customer_id],
        [sale_order_id],
        [purchase_order_id],
        [penalty_reason],
        [deduct_terms],
        [total_contract_amount],
        [invoice_to_date_amount],
        [remaining_progress_billing],
        [previously_invoiced_due],
        [current_invoice_amount],
        [less_paid_amount],
        [total_due_amount],
        [is_customer_ipc],
        [advance_recovery_completed],
        [penalty_amount],
        [customer_advance_payment],
        [vendor_advance_payment],
        [advance_deduct_percentage],
        [advance_pay_percentage],
        [x_workflow_state],
        [x_workflow_approve_user],
        [x_workflow_id],
        
DATEADD(MICROSECOND, [x_workflow_state_date] % 1000000,
    DATEADD(SECOND, [x_workflow_state_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [x_workflow_state_date],
        [payment_milestone],
        [acceptance_cert_number],
        
DATEADD(DAY, [start_date], cast('1970-01-01' as date))
 as [start_date],
        
DATEADD(DAY, [end_date], cast('1970-01-01' as date))
 as [end_date],
        [ipc_adjusment_amount],
        [final_ipc_amount],
        [deduction_amount],
        [is_approved],
        [total_amount_untaxed],
        [total_amount_tax],
        [previous_payment_amount],
        [current_payment_amount],
        [is_paid],
        [account_responsible_id],
        [journal_id],
        [x_workflow_stage_id],
        [analytic_distribution],
        [recovery_amount],
        [interim_payment_ipc_id],
        [invoice_status],
        [payment_type],
        [include_interim_payment],
        [include_variation_payment],
        [advance_percentage],
        [contract_appendix_amount_untaxed],
        [contract_appendix_amount_tax],
        [contract_appendix_amount],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id]
from ranked
where rn = 1