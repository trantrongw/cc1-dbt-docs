


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'workflow_trans'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__workflow_trans])
    
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
        [node_from] int            '$.node_from',
        [node_to] int            '$.node_to',
        [workflow_id] int            '$.workflow_id',
        [sequence] int            '$.sequence',
        [model_id] int            '$.model_id',
        [model_view_id] int            '$.model_view_id',
        [menu_id] int            '$.menu_id',
        [server_action_id] int            '$.server_action_id',
        [win_act_id] int            '$.win_act_id',
        [strokenWidth] int            '$.strokenWidth',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [code] varchar(max)   '$.code',
        [condition] varchar(max)   '$.condition',
        [real_id] varchar(max)   '$.real_id',
        [task_condition] varchar(max)   '$.task_condition',
        [trans_type] varchar(max)   '$.trans_type',
        [action_type] varchar(max)   '$.action_type',
        [fill] varchar(max)   '$.fill',
        [stroke] varchar(max)   '$.stroke',
        [date_deadline] int            '$.date_deadline',
        [context] varchar(max)   '$.context',
        [py_code] varchar(max)   '$.py_code',
        [is_backward] bit            '$.is_backward',
        [auto] bit            '$.auto',
        [need_note] bit            '$.need_note',
        [is_approve] bit            '$.is_approve',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [extra_server_action_id] int            '$.extra_server_action_id',
        [display_mode] varchar(max)   '$.display_mode',
        [confirm_title] varchar(max)   '$.confirm_title',
        [confirm_label] varchar(max)   '$.confirm_label',
        [confirm_message] varchar(max)   '$.confirm_message',
        [show_confirm] bit            '$.show_confirm',
        [notification_title] varchar(max)   '$.notification_title',
        [notification_message] varchar(max)   '$.notification_message',
        [use_push_notification] bit            '$.use_push_notification',
        [x_sys_name] varchar(max)   '$.x_sys_name',
        [sys_name] varchar(max)   '$.sys_name',
        [responsible_field_id] int            '$.responsible_field_id',
        [wizard_action_id] int            '$.wizard_action_id',
        [external_workflow_id] int            '$.external_workflow_id',
        [external_linked_field_id] int            '$.external_linked_field_id',
        [external_trigger_trans_id] int            '$.external_trigger_trans_id',
        [external_linked_field_name] varchar(max)   '$.external_linked_field_name',
        [condition_type] varchar(max)   '$.condition_type',
        [condition_domain] varchar(max)   '$.condition_domain',
        [will_keep_event] bit            '$.will_keep_event',
        [skip_condition_check_roles] bit            '$.skip_condition_check_roles',
        [visible_condition_role_id] int            '$.visible_condition_role_id'
    ) as j
)

select * from cdc_keyed
