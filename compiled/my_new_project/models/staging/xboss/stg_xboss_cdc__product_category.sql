


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'product_category'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__product_category])
    
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
        [parent_id] int            '$.parent_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [complete_name] varchar(max)   '$.complete_name',
        [parent_path] varchar(max)   '$.parent_path',
        [product_properties_definition] varchar(max)   '$.product_properties_definition',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [removal_strategy_id] int            '$.removal_strategy_id',
        [packaging_reserve_method] varchar(max)   '$.packaging_reserve_method',
        [technician_user_id] int            '$.technician_user_id',
        [equipment_assign_to] varchar(max)   '$.equipment_assign_to',
        [sequence_id] int            '$.sequence_id',
        [sequence_code] varchar(max)   '$.sequence_code',
        [automated_sequence] bit            '$.automated_sequence',
        [active] bit            '$.active',
        [allow_negative_stock] bit            '$.allow_negative_stock',
        [boq_type] varchar(max)   '$.boq_type'
    ) as j
)

select * from cdc_keyed
