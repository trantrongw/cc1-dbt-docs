

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__account_journal]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__account_journal_current])
    
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
        [default_account_id],
        [suspense_account_id],
        [sequence],
        [currency_id],
        [company_id],
        [profit_account_id],
        [loss_account_id],
        [bank_account_id],
        [sale_activity_type_id],
        [sale_activity_user_id],
        [secure_sequence_id],
        [create_uid],
        [write_uid],
        [color],
        [access_token],
        [code],
        [type],
        [invoice_reference_type],
        [invoice_reference_model],
        [bank_statements_source],
        [name],
        [sequence_override_regex],
        [sale_activity_note],
        [active],
        [restrict_mode_hash_table],
        [refund_sequence],
        [payment_sequence],
        [show_on_dashboard],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [is_advance_journal],
        [swift_bic_bank_code],
        [is_opening],
        [sequence_id],
        [refund_sequence_id],
        [has_sequence_holes],
        [account_einvoice_serial_id],
        [account_einvoice_template_id],
        [account_einvoice_type_id],
        [einvoice_item_name],
        [einvoice_item_name_new_line_replacement],
        [einvoice_send_mail_option],
        [einvoice_credit_note_option],
        [einvoice_price_unit_discount_computation],
        [send_mail_einvoice_disabled],
        [einvoice_display_bank_account],
        [einvoice_required_date_invoice],
        [sinvoice_sellerinfo],
        [einvoice_pos_issue_now],
        [sinvoice_exclude_qty_unit_price],
        [sinvoice_discount_only_display_total],
        [bank_account_partner_id],
        [custom_bank_id],
        [is_loan_journal],
        [allow_enforce_analytic]
from ranked
where rn = 1