

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__purchase_order]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__purchase_order_current])
    
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
        [partner_id],
        [dest_address_id],
        [currency_id],
        [invoice_count],
        [fiscal_position_id],
        [payment_term_id],
        [incoterm_id],
        [user_id],
        [company_id],
        [create_uid],
        [write_uid],
        [access_token],
        [name],
        [priority],
        [origin],
        [partner_ref],
        [state],
        [invoice_status],
        [notes],
        [amount_untaxed],
        [amount_tax],
        [amount_total],
        [mail_reminder_confirmed],
        [mail_reception_confirmed],
        
DATEADD(MICROSECOND, [date_order] % 1000000,
    DATEADD(SECOND, [date_order] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [date_order],
        
DATEADD(MICROSECOND, [date_approve] % 1000000,
    DATEADD(SECOND, [date_approve] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [date_approve],
        
DATEADD(MICROSECOND, [date_planned] % 1000000,
    DATEADD(SECOND, [date_planned] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [date_planned],
        
DATEADD(MICROSECOND, [date_calendar_start] % 1000000,
    DATEADD(SECOND, [date_calendar_start] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [date_calendar_start],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [currency_rate],
        [request_id],
        [picking_type_id],
        [group_id],
        [incoterm_location],
        [receipt_status],
        
DATEADD(MICROSECOND, [effective_date] % 1000000,
    DATEADD(SECOND, [effective_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [effective_date],
        [custom_requisition_id],
        [picking_id],
        [sh_amount_resisual],
        [subcontractor_id],
        [inter_comp_sale_order_id],
        [auto_generated],
        [requisition_id],
        [purchase_group_id],
        [custom_construction_ipc_id],
        [advance_payment_link],
        [contract_project_id],
        [original_po_id],
        [contract_ref_no],
        [deduct_terms],
        
DATEADD(DAY, [contract_start_date], cast('1970-01-01' as date))
 as [contract_start_date],
        
DATEADD(DAY, [contract_end_date], cast('1970-01-01' as date))
 as [contract_end_date],
        [narration],
        [is_sub_contract],
        [advance_payment_amount],
        [advance_pay_percentage],
        [penalty_amount],
        [advance_deduct_percentage],
        [analytic_distribution],
        [contract_state],
        
DATEADD(DAY, [contract_date], cast('1970-01-01' as date))
 as [contract_date],
        [x_workflow_state],
        [x_workflow_approve_user],
        [x_workflow_id],
        
DATEADD(MICROSECOND, [x_workflow_state_date] % 1000000,
    DATEADD(SECOND, [x_workflow_state_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [x_workflow_state_date],
        [appendix_reference_number],
        [appendix_status],
        
DATEADD(DAY, [appendix_date], cast('1970-01-01' as date))
 as [appendix_date],
        
DATEADD(DAY, [appendix_start_date], cast('1970-01-01' as date))
 as [appendix_start_date],
        
DATEADD(DAY, [appendix_end_date], cast('1970-01-01' as date))
 as [appendix_end_date],
        [is_ready_apr],
        [contractor_rating_answer_id],
        [requisition_analytic_id],
        [analytic_account_id],
        [requisition_analytic_group_id],
        [is_tender],
        [bid_selected],
        [has_negotiate_price],
        
DATEADD(MICROSECOND, [latest_bid_price_time] % 1000000,
    DATEADD(SECOND, [latest_bid_price_time] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [latest_bid_price_time],
        [rating_capacity_experience],
        [rating_technical],
        [rating_contract_responsiveness],
        [initial_bid_price],
        [business_type],
        [has_service_product],
        [procurement_type],
        [journal_id],
        [is_linked_apr],
        [note_template_id],
        [x_workflow_stage_id],
        [construction_package],
        [contract_type_id],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id],
        [x_workflow_config_id],
        [foreign_trade],
        [main_attachment_id]
from ranked
where rn = 1