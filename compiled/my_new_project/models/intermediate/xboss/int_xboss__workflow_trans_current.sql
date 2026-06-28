

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__workflow_trans]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__workflow_trans_current])
    
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
        [node_from],
        [node_to],
        [workflow_id],
        [sequence],
        [model_id],
        [model_view_id],
        [menu_id],
        [server_action_id],
        [win_act_id],
        [strokenWidth],
        [create_uid],
        [write_uid],
        [name],
        [code],
        [condition],
        [real_id],
        [task_condition],
        [trans_type],
        [action_type],
        [fill],
        [stroke],
        
DATEADD(DAY, [date_deadline], cast('1970-01-01' as date))
 as [date_deadline],
        [context],
        [py_code],
        [is_backward],
        [auto],
        [need_note],
        [is_approve],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [extra_server_action_id],
        [display_mode],
        [confirm_title],
        [confirm_label],
        [confirm_message],
        [show_confirm],
        [notification_title],
        [notification_message],
        [use_push_notification],
        [x_sys_name],
        [sys_name],
        [responsible_field_id],
        [wizard_action_id],
        [external_workflow_id],
        [external_linked_field_id],
        [external_trigger_trans_id],
        [external_linked_field_name],
        [condition_type],
        [condition_domain],
        [will_keep_event],
        [skip_condition_check_roles],
        [visible_condition_role_id]
from ranked
where rn = 1