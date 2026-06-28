

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__hr_expense_sheet]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__hr_expense_sheet_current])
    
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
        [message_main_attachment_id],
        [company_id],
        [employee_id],
        [department_id],
        [user_id],
        [currency_id],
        [employee_journal_id],
        [payment_method_line_id],
        [journal_id],
        [create_uid],
        [write_uid],
        [name],
        [state],
        [approval_state],
        [payment_state],
        
DATEADD(DAY, [accounting_date], cast('1970-01-01' as date))
 as [accounting_date],
        [total_amount],
        [untaxed_amount],
        [total_tax_amount],
        [amount_residual],
        
DATEADD(MICROSECOND, [approval_date] % 1000000,
    DATEADD(SECOND, [approval_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [approval_date],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [business_trip_request_id],
        [vendor_bill_journal_id],
        [has_invoice],
        [invisible_payment],
        [responsible_id],
        [code],
        [x_workflow_state],
        [x_workflow_approve_user],
        [x_workflow_id],
        
DATEADD(MICROSECOND, [x_workflow_state_date] % 1000000,
    DATEADD(SECOND, [x_workflow_state_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [x_workflow_state_date],
        [main_attachment_id],
        [expense_workflow_id],
        [account_responsible_id],
        [partner_id],
        [partner_bank_id],
        [label],
        [priority],
        [mode_payment],
        [cash_receiver],
        [workflow_type],
        
DATEADD(DAY, [deadline_request], cast('1970-01-01' as date))
 as [deadline_request],
        
DATEADD(DAY, [date_request], cast('1970-01-01' as date))
 as [date_request],
        
DATEADD(DAY, [payment_deadline], cast('1970-01-01' as date))
 as [payment_deadline],
        
DATEADD(DAY, [final_approval_date], cast('1970-01-01' as date))
 as [final_approval_date],
        [approved_amount],
        [is_ready_payment],
        [balance_amount],
        [balance_amount_display],
        [balance_negative_amount],
        [return_amount],
        [payment_amount],
        [transfer_amount],
        [payment_mode],
        [is_sample_document],
        [analytic_distribution],
        [company_currency_id],
        [x_workflow_stage_id],
        [force_pass_unique_ref],
        [note],
        [is_unplanned],
        [active],
        [last_approver_id],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id],
        [is_advance_exceeding_paid_amount],
        [is_payment_order_created],
        [jva_reimbursement_amount],
        [jva_operating_cost],
        [jva_construction_support_cost],
        [jva_paid_amount],
        [jva_remain_amount],
        [is_joint_venture_agreement]
from ranked
where rn = 1