

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__material_purchase_requisition]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__material_purchase_requisition_current])
    
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
        [department_id],
        [employee_id],
        [approve_manager_id],
        [reject_manager_id],
        [approve_employee_id],
        [reject_employee_id],
        [company_id],
        [location_id],
        [analytic_account_id],
        [dest_location_id],
        [delivery_picking_id],
        [requisiton_responsible_id],
        [employee_confirm_id],
        [custom_picking_type_id],
        [create_uid],
        [write_uid],
        [access_token],
        [name],
        [state],
        
DATEADD(DAY, [request_date], cast('1970-01-01' as date))
 as [request_date],
        
DATEADD(DAY, [date_end], cast('1970-01-01' as date))
 as [date_end],
        
DATEADD(DAY, [date_done], cast('1970-01-01' as date))
 as [date_done],
        
DATEADD(DAY, [managerapp_date], cast('1970-01-01' as date))
 as [managerapp_date],
        
DATEADD(DAY, [manareject_date], cast('1970-01-01' as date))
 as [manareject_date],
        
DATEADD(DAY, [userreject_date], cast('1970-01-01' as date))
 as [userreject_date],
        
DATEADD(DAY, [userrapp_date], cast('1970-01-01' as date))
 as [userrapp_date],
        
DATEADD(DAY, [receive_date], cast('1970-01-01' as date))
 as [receive_date],
        
DATEADD(DAY, [confirm_date], cast('1970-01-01' as date))
 as [confirm_date],
        [reason],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [task_id],
        [task_user_id],
        [project_id],
        [purchase_order_id],
        [equipment_machine_total],
        [worker_resource_total],
        [work_cost_package_total],
        [subcontract_total],
        [request_classification],
        [note],
        [maintenance_request_id],
        [currency_id],
        [analytic_distribution],
        [x_workflow_state],
        [x_workflow_approve_user],
        [x_workflow_id],
        
DATEADD(MICROSECOND, [x_workflow_state_date] % 1000000,
    DATEADD(SECOND, [x_workflow_state_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [x_workflow_state_date],
        [source_document],
        [create_from_jcs],
        [employee_advance_count],
        [x_workflow_stage_id],
        [partner_id],
        [business_type],
        [already_purchase_requested],
        [already_stock_requested],
        
DATEADD(MICROSECOND, [submission_date] % 1000000,
    DATEADD(SECOND, [submission_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [submission_date],
        [job_cost_sheet],
        [procurement_type],
        [x_workflow_update_user_id],
        [x_workflow_responsible_user_id]
from ranked
where rn = 1