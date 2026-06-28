

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__workflow_node]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__workflow_node_current])
    
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
        [sequence],
        [workflow_id],
        [reset_group_id],
        [strokenWidth],
        [create_uid],
        [write_uid],
        [name],
        [code],
        [descript],
        [split_mode],
        [join_mode],
        [action],
        [fill],
        [stroke],
        [arg],
        [is_start],
        [is_stop],
        [show_state],
        [no_reset],
        [event_need],
        [weixin_need],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [activity_type_id],
        [activity_summary],
        [activity_description],
        [estimated_processing_time],
        [reminder_time_before_the_due_date],
        [x_sys_name],
        [sys_name],
        [is_close_workflow],
        [is_ready_payment],
        [is_final_approval],
        [is_display_adjust_amount_button],
        [is_display_allocation_payment_button],
        [group_node_id],
        [visible_condition_domain],
        [fold],
        [is_display_outstanding_widget],
        [sign_title_display_type],
        [not_reload_document],
        [allow_display_move_preview],
        [is_display_close_adv_req_button],
        [activity_plan_id],
        [activity_plan_mode]
from ranked
where rn = 1