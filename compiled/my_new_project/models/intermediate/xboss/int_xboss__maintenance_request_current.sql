

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__maintenance_request]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__maintenance_request_current])
    
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
        [company_id],
        [owner_user_id],
        [category_id],
        [equipment_id],
        [user_id],
        [stage_id],
        [color],
        [maintenance_team_id],
        [repeat_interval],
        [create_uid],
        [write_uid],
        [email_cc],
        [name],
        [priority],
        [kanban_state],
        [maintenance_type],
        [instruction_type],
        [instruction_google_slide],
        [repeat_unit],
        [repeat_type],
        
DATEADD(DAY, [request_date], cast('1970-01-01' as date))
 as [request_date],
        
DATEADD(DAY, [close_date], cast('1970-01-01' as date))
 as [close_date],
        
DATEADD(DAY, [repeat_until], cast('1970-01-01' as date))
 as [repeat_until],
        [description],
        [instruction_text],
        [archive],
        [recurring_maintenance],
        
DATEADD(MICROSECOND, [schedule_date] % 1000000,
    DATEADD(SECOND, [schedule_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [schedule_date],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [duration],
        [employee_id],
        [approval_id],
        [vehicle_id],
        [driver_id],
        [maintenance_vehicle_id],
        [approval_user_id],
        [maintenance_schedule_type],
        [recurring_type],
        [ref],
        [request_status],
        [amount_budget],
        [amount],
        [maintenance_km],
        [maintenance_time_operation],
        [recurring_km],
        [lot_id],
        [dest_location_id],
        [joborder_id],
        [requisition_employee_id],
        [custom_project_id],
        [picking_type_id],
        [is_task],
        [is_requisition],
        [is_vehicle_maintenance],
        
DATEADD(MICROSECOND, [approval_date] % 1000000,
    DATEADD(SECOND, [approval_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [approval_date],
        [schedule_line_id],
        [maintenance_level_id],
        [cycle_number],
        [current_value],
        [initial_value],
        [maintenance_mode],
        [notes],
        
DATEADD(MICROSECOND, [alert_date] % 1000000,
    DATEADD(SECOND, [alert_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [alert_date],
        
DATEADD(MICROSECOND, [completed_date] % 1000000,
    DATEADD(SECOND, [completed_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [completed_date],
        [property_id],
        [invc_id],
        [account_id],
        [tenant_id],
        
DATEADD(DAY, [date_invoice], cast('1970-01-01' as date))
 as [date_invoice],
        [renters_fault],
        [invc_check],
        [is_in_progress],
        [cost],
        [maintenance_classification]
from ranked
where rn = 1