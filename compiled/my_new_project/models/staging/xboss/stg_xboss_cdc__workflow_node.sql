


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'workflow_node'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__workflow_node])
    
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
        [sequence] int            '$.sequence',
        [workflow_id] int            '$.workflow_id',
        [reset_group_id] int            '$.reset_group_id',
        [strokenWidth] int            '$.strokenWidth',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [code] varchar(max)   '$.code',
        [descript] varchar(max)   '$.descript',
        [split_mode] varchar(max)   '$.split_mode',
        [join_mode] varchar(max)   '$.join_mode',
        [action] varchar(max)   '$.action',
        [fill] varchar(max)   '$.fill',
        [stroke] varchar(max)   '$.stroke',
        [arg] varchar(max)   '$.arg',
        [is_start] bit            '$.is_start',
        [is_stop] bit            '$.is_stop',
        [show_state] bit            '$.show_state',
        [no_reset] bit            '$.no_reset',
        [event_need] bit            '$.event_need',
        [weixin_need] bit            '$.weixin_need',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [activity_type_id] int            '$.activity_type_id',
        [activity_summary] varchar(max)   '$.activity_summary',
        [activity_description] varchar(max)   '$.activity_description',
        [estimated_processing_time] float          '$.estimated_processing_time',
        [reminder_time_before_the_due_date] float          '$.reminder_time_before_the_due_date',
        [x_sys_name] varchar(max)   '$.x_sys_name',
        [sys_name] varchar(max)   '$.sys_name',
        [is_close_workflow] bit            '$.is_close_workflow',
        [is_ready_payment] bit            '$.is_ready_payment',
        [is_final_approval] bit            '$.is_final_approval',
        [is_display_adjust_amount_button] bit            '$.is_display_adjust_amount_button',
        [is_display_allocation_payment_button] bit            '$.is_display_allocation_payment_button',
        [group_node_id] int            '$.group_node_id',
        [visible_condition_domain] varchar(max)   '$.visible_condition_domain',
        [fold] bit            '$.fold',
        [is_display_outstanding_widget] bit            '$.is_display_outstanding_widget',
        [sign_title_display_type] varchar(max)   '$.sign_title_display_type',
        [not_reload_document] bit            '$.not_reload_document',
        [allow_display_move_preview] bit            '$.allow_display_move_preview',
        [is_display_close_adv_req_button] bit            '$.is_display_close_adv_req_button',
        [activity_plan_id] int            '$.activity_plan_id',
        [activity_plan_mode] varchar(max)   '$.activity_plan_mode'
    ) as j
)

select * from cdc_keyed
