

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__account_payment]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__account_payment_current])
    
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
        [move_id],
        [partner_bank_id],
        [paired_internal_transfer_payment_id],
        [payment_method_line_id],
        [payment_method_id],
        [currency_id],
        [partner_id],
        [outstanding_account_id],
        [destination_account_id],
        [destination_journal_id],
        [create_uid],
        [write_uid],
        [payment_type],
        [partner_type],
        [payment_reference],
        [amount],
        [amount_company_currency_signed],
        [is_reconciled],
        [is_matched],
        [is_internal_transfer],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [payment_transaction_id],
        [payment_token_id],
        [source_payment_id],
        [employee_id],
        [no_of_origin],
        [recipient_payer],
        [employee_advance_id],
        [employee_advance_reconcile_id],
        [payment_type_line_id],
        [payment_type_id],
        [ref],
        [comment],
        [sale_id],
        [purchase_id],
        [approval_ref],
        [is_request_ready],
        [suggest_lines],
        [loan_borrow_order_id],
        [loan_lend_order_id],
        [analytic_distribution],
        [requisition_id],
        [pos_payment_method_id],
        [force_outstanding_account_id],
        [pos_session_id],
        [pos_order_id],
        [force_pass_unique_ref],
        [tenancy_id],
        [property_id],
        [is_linked_apr],
        [beneficiary_id],
        [beneficiary_bank_id],
        [is_alternative_beneficiary],
        [is_internal_direct],
        [beneficiary_address],
        [disbursement_code],
        [manual_currency_rate],
        [manual_currency_rate_active]
from ranked
where rn = 1