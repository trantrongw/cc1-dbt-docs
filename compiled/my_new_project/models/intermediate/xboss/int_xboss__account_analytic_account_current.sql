

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__account_analytic_account]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__account_analytic_account_current])
    
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
        [plan_id],
        [root_plan_id],
        [company_id],
        [partner_id],
        [create_uid],
        [write_uid],
        [code],
        [name],
        [active],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [issue_transfer_limit_employee_level],
        [department_id],
        [total_progress_account],
        [amount_fee_paid],
        [manager_id],
        [property_id],
        [tenant_id],
        [contact_id],
        [acc_pay_dep_rec_id],
        [acc_pay_dep_ret_id],
        [rent_type_id],
        [invc_id],
        [doc_name],
        [deposit_scheme_type],
        [state],
        
DATEADD(DAY, [date], cast('1970-01-01' as date))
 as [date],
        
DATEADD(DAY, [date_start], cast('1970-01-01' as date))
 as [date_start],
        
DATEADD(DAY, [ten_date], cast('1970-01-01' as date))
 as [ten_date],
        [description],
        [duration_cover],
        [rent],
        [deposit],
        [total_rent],
        [amount_return],
        [is_property],
        [rent_entry_chck],
        [multi_prop],
        [penalty_a],
        [recurring],
        [tenancy_cancelled],
        [main_cost],
        [agent],
        [commission_type],
        [commission],
        [commission_create],
        [fix_qty],
        [fix_cost],
        [property_owner_id],
        [is_landlord_rent],
        [landlord_rent],
        [penalty_day],
        [penalty],
        [property_parent_id],
        [fee_type_id],
        
DATEADD(DAY, [start_date_calculate_rent], cast('1970-01-01' as date))
 as [start_date_calculate_rent],
        
DATEADD(DAY, [start_date_calculate_utility], cast('1970-01-01' as date))
 as [start_date_calculate_utility],
        [rent_payer_id],
        [service_payer_id],
        [tenancy_parent_id],
        
DATEADD(DAY, [termination_date], cast('1970-01-01' as date))
 as [termination_date],
        [number_day_deadline_reminder],
        [parent_id],
        [requisition_tender_id],
        [tender_stage_id],
        [tender_plan_responsible_id],
        [partner_address_id],
        [commercial_partner_id],
        
DATEADD(DAY, [scheduled_bid_request_date], cast('1970-01-01' as date))
 as [scheduled_bid_request_date],
        
DATEADD(DAY, [date_end], cast('1970-01-01' as date))
 as [date_end],
        [is_bid_selection_project],
        
DATEADD(MICROSECOND, [scheduled_bid_selection_date] % 1000000,
    DATEADD(SECOND, [scheduled_bid_selection_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [scheduled_bid_selection_date],
        [number_duration],
        [job_cost_group_id],
        [spread_template_id]
from ranked
where rn = 1