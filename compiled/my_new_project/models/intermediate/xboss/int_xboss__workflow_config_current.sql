

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__workflow_config]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__workflow_config_current])
    
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
        [model_id],
        [category_id],
        [workflow_id],
        [sequence],
        [company_id],
        [create_uid],
        [write_uid],
        [name],
        [code],
        [type],
        [description],
        [domain],
        [active],
        [isActive],
        [allow_create],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [paid_by],
        [main_attachment_id],
        [parent_id],
        [reimbursement_account_id],
        [minimum_payment_cycle_days],
        [auto_post_entries],
        [allow_direct_payable_payment],
        [field_wf_id],
        [automatic],
        [filter_account_prefix],
        [allow_multi_request],
        [allow_over_origin_amount],
        [partner_id],
        [default_journal_id],
        [outstanding_same_reference],
        [user_manual_url],
        [lock_ref_amount],
        [number_of_signs_per_row],
        [expense_has_invoice],
        [position_page],
        [allow_zero_price_unit],
        [invalid_journal_id],
        [transfer_partner_mode],
        [allow_no_payment],
        [workflow_mode],
        [allow_reimbursement_exceeding_advance],
        [outstanding_same_beneficiary],
        [purchase_journal_id],
        [is_joint_venture_agreement]
from ranked
where rn = 1