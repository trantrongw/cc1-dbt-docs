

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__workflow_base]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__workflow_base_current])
    
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
        [model_view_id],
        [model_tree_view_id],
        [view_id],
        [tree_view_id],
        [widget_view_id],
        [field_id],
        [field_id1],
        [field_id2],
        [tracking],
        [reset_group],
        [create_uid],
        [write_uid],
        [name],
        [diagram],
        [isActive],
        [allow_reset],
        [is_replace],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [action_id],
        [field_wf_roles_id],
        [field_wf_id],
        [model_kanban_view_id],
        [kanban_view_id],
        [domain],
        [hide_original_form_header],
        [use_action_overload],
        [use_kanban_with_workflow_stage],
        [field_wf_state_date_id],
        [use_kanban_order_state_date],
        [x_sys_name],
        [sys_name],
        [activity_action_id],
        [field_workflow_stage_id],
        [root_state_workflow_id],
        [use_activity_plan],
        [sla_duration_unit],
        [sla_apply_work_calendar]
from ranked
where rn = 1