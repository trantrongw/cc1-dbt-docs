


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'workflow_base'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__workflow_base])
    
),
cdc_keyed as (
    select
        __dbz_operation,
        __dbz_timestamp,
        __dbz_lsn,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(__dbz_timestamp as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(__dbz_lsn as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
 as __event_key,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_')), '')), 2))
      as __id,
        j.*
    from cdc_src
    cross apply OPENJSON(record_data) with (
        [id] int            '$.id',
        [model_id] int            '$.model_id',
        [model_view_id] int            '$.model_view_id',
        [model_tree_view_id] int            '$.model_tree_view_id',
        [view_id] int            '$.view_id',
        [tree_view_id] int            '$.tree_view_id',
        [widget_view_id] int            '$.widget_view_id',
        [field_id] int            '$.field_id',
        [field_id1] int            '$.field_id1',
        [field_id2] int            '$.field_id2',
        [tracking] int            '$.tracking',
        [reset_group] int            '$.reset_group',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [diagram] varchar(max)   '$.diagram',
        [isActive] bit            '$.isActive',
        [allow_reset] bit            '$.allow_reset',
        [is_replace] bit            '$.is_replace',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [action_id] int            '$.action_id',
        [field_wf_roles_id] int            '$.field_wf_roles_id',
        [field_wf_id] int            '$.field_wf_id',
        [model_kanban_view_id] int            '$.model_kanban_view_id',
        [kanban_view_id] int            '$.kanban_view_id',
        [domain] varchar(max)   '$.domain',
        [hide_original_form_header] bit            '$.hide_original_form_header',
        [use_action_overload] bit            '$.use_action_overload',
        [use_kanban_with_workflow_stage] bit            '$.use_kanban_with_workflow_stage',
        [field_wf_state_date_id] int            '$.field_wf_state_date_id',
        [use_kanban_order_state_date] bit            '$.use_kanban_order_state_date',
        [x_sys_name] varchar(max)   '$.x_sys_name',
        [sys_name] varchar(max)   '$.sys_name',
        [activity_action_id] int            '$.activity_action_id',
        [field_workflow_stage_id] int            '$.field_workflow_stage_id',
        [root_state_workflow_id] int            '$.root_state_workflow_id',
        [use_activity_plan] bit            '$.use_activity_plan',
        [sla_duration_unit] varchar(max)   '$.sla_duration_unit',
        [sla_apply_work_calendar] bit            '$.sla_apply_work_calendar'
    ) as j
)

select * from cdc_keyed
