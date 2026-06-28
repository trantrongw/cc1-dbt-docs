

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__sale_order]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__sale_order_current])
    
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
        [campaign_id],
        [source_id],
        [medium_id],
        [company_id],
        [partner_id],
        [journal_id],
        [partner_invoice_id],
        [partner_shipping_id],
        [fiscal_position_id],
        [payment_term_id],
        [pricelist_id],
        [currency_id],
        [user_id],
        [team_id],
        [analytic_account_id],
        [create_uid],
        [write_uid],
        [access_token],
        [name],
        [state],
        [client_order_ref],
        [origin],
        [reference],
        [signed_by],
        [invoice_status],
        
DATEADD(DAY, [validity_date], cast('1970-01-01' as date))
 as [validity_date],
        [note],
        [currency_rate],
        [amount_untaxed],
        [amount_tax],
        [amount_total],
        [amount_to_invoice],
        [locked],
        [require_signature],
        [require_payment],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [commitment_date] % 1000000,
    DATEADD(SECOND, [commitment_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [commitment_date],
        
DATEADD(MICROSECOND, [date_order] % 1000000,
    DATEADD(SECOND, [date_order] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [date_order],
        
DATEADD(MICROSECOND, [signed_on] % 1000000,
    DATEADD(SECOND, [signed_on] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [signed_on],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [prepayment_percent],
        [pending_email_template_id],
        [sale_order_template_id],
        [incoterm],
        [warehouse_id],
        [procurement_group_id],
        [incoterm_location],
        [picking_policy],
        [delivery_status],
        
DATEADD(MICROSECOND, [effective_date] % 1000000,
    DATEADD(SECOND, [effective_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [effective_date],
        [project_id],
        [opportunity_id],
        [task_id],
        [amount_invoice_paid],
        [amount_residual],
        [days_to_confirm],
        [inter_comp_purchase_order_id],
        [auto_generated],
        [advance_payment_link],
        [contract_project_id],
        [contract_ref_no],
        [deduct_terms],
        
DATEADD(DAY, [contract_start_date], cast('1970-01-01' as date))
 as [contract_start_date],
        
DATEADD(DAY, [contract_end_date], cast('1970-01-01' as date))
 as [contract_end_date],
        [narration],
        [warn_msg],
        [is_customer_contract],
        [custom_product_type_check],
        [advance_payment_amount],
        [advance_pay_percentage],
        [penalty_amount],
        [advance_deduct_percentage],
        [analytic_distribution],
        [x_workflow_state],
        [x_workflow_approve_user],
        [x_workflow_id],
        
DATEADD(MICROSECOND, [x_workflow_state_date] % 1000000,
    DATEADD(SECOND, [x_workflow_state_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [x_workflow_state_date],
        [inspection_job_card_id],
        [repair_job_card_id],
        [amount_unpaid],
        [is_property],
        [contract_type_id],
        [construction_item],
        [construction_package],
        [x_workflow_stage_id],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id],
        [x_workflow_config_id],
        [is_joint_venture_agreement]
from ranked
where rn = 1