


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'ir_model'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__ir_model])
    
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
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [model] varchar(max)   '$.model',
        [order] varchar(max)   '$.order',
        [state] varchar(max)   '$.state',
        [name] varchar(max)   '$.name',
        [info] varchar(max)   '$.info',
        [transient] bit            '$.transient',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [allow_modify_master_data] bit            '$.allow_modify_master_data',
        [is_mail_thread] bit            '$.is_mail_thread',
        [is_mail_activity] bit            '$.is_mail_activity',
        [is_mail_blacklist] bit            '$.is_mail_blacklist',
        [website_form_default_field_id] int            '$.website_form_default_field_id',
        [website_form_label] varchar(max)   '$.website_form_label',
        [website_form_key] varchar(max)   '$.website_form_key',
        [website_form_access] bit            '$.website_form_access',
        [automatic_custom_tracking_domain] varchar(max)   '$.automatic_custom_tracking_domain',
        [active_custom_tracking] bit            '$.active_custom_tracking',
        [automatic_custom_tracking] bit            '$.automatic_custom_tracking',
        [restrict_delete_attachment] varchar(max)   '$.restrict_delete_attachment',
        [delete_attachment_domain] varchar(max)   '$.delete_attachment_domain'
    ) as j
)

select * from cdc_keyed
