

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__employee_advance]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__employee_advance_current])
    
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
        [employee_id],
        [job_id],
        [department_id],
        [company_id],
        [journal_id],
        [currency_id],
        [responsible_id],
        [create_uid],
        [write_uid],
        [name],
        [payment_state],
        [state],
        
DATEADD(DAY, [date], cast('1970-01-01' as date))
 as [date],
        [amount],
        [approved_amount],
        [balance],
        [to_reconcile_amount],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
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
        
DATEADD(DAY, [deadline_request], cast('1970-01-01' as date))
 as [deadline_request],
        
DATEADD(DAY, [date_request], cast('1970-01-01' as date))
 as [date_request],
        
DATEADD(DAY, [payment_deadline], cast('1970-01-01' as date))
 as [payment_deadline],
        
DATEADD(DAY, [final_approval_date], cast('1970-01-01' as date))
 as [final_approval_date],
        
DATEADD(DAY, [date_return], cast('1970-01-01' as date))
 as [date_return],
        [analytic_distribution],
        [is_ready_payment],
        [is_sample_document],
        [material_requisition_id],
        [workflow_type],
        [x_workflow_stage_id],
        [active],
        [amount_residual],
        [last_approver_id],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id],
        [workflow_mode],
        [is_payment_order_created],
        [is_joint_venture_agreement]
from ranked
where rn = 1