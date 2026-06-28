


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'ir_model_fields'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__ir_model_fields])
    
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
        [relation_field_id] int            '$.relation_field_id',
        [model_id] int            '$.model_id',
        [related_field_id] int            '$.related_field_id',
        [size] int            '$.size',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [complete_name] varchar(max)   '$.complete_name',
        [model] varchar(max)   '$.model',
        [relation] varchar(max)   '$.relation',
        [relation_field] varchar(max)   '$.relation_field',
        [ttype] varchar(max)   '$.ttype',
        [related] varchar(max)   '$.related',
        [state] varchar(max)   '$.state',
        [on_delete] varchar(max)   '$.on_delete',
        [domain] varchar(max)   '$.domain',
        [relation_table] varchar(max)   '$.relation_table',
        [column1] varchar(max)   '$.column1',
        [column2] varchar(max)   '$.column2',
        [depends] varchar(max)   '$.depends',
        [currency_field] varchar(max)   '$.currency_field',
        [field_description] varchar(max)   '$.field_description',
        [help] varchar(max)   '$.help',
        [compute] varchar(max)   '$.compute',
        [copied] bit            '$.copied',
        [required] bit            '$.required',
        [readonly] bit            '$.readonly',
        [index] bit            '$.index',
        [translate] bit            '$.translate',
        [group_expand] bit            '$.group_expand',
        [selectable] bit            '$.selectable',
        [store] bit            '$.store',
        [sanitize] bit            '$.sanitize',
        [sanitize_overridable] bit            '$.sanitize_overridable',
        [sanitize_tags] bit            '$.sanitize_tags',
        [sanitize_attributes] bit            '$.sanitize_attributes',
        [sanitize_style] bit            '$.sanitize_style',
        [sanitize_form] bit            '$.sanitize_form',
        [strip_style] bit            '$.strip_style',
        [strip_classes] bit            '$.strip_classes',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [tracking] int            '$.tracking',
        [website_form_blacklisted] bit            '$.website_form_blacklisted',
        [serialization_field_id] int            '$.serialization_field_id',
        [custom_tracking] bit            '$.custom_tracking',
        [native_tracking] bit            '$.native_tracking',
        [trackable] bit            '$.trackable',
        [ai_domain] varchar(max)   '$.ai_domain',
        [system_prompt] varchar(max)   '$.system_prompt',
        [ai] bit            '$.ai'
    ) as j
)

select * from cdc_keyed
