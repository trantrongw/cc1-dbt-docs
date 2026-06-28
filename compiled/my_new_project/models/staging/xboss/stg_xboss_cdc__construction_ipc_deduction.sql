


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'construction_ipc_deduction'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc_deduction])
    
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
        [ipc_id] int            '$.ipc_id',
        [product_id] int            '$.product_id',
        [bill_id] int            '$.bill_id',
        [journal_entry_id] int            '$.journal_entry_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [description] varchar(max)   '$.description',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [amount] float          '$.amount',
        [journal_id] int            '$.journal_id',
        [method] varchar(max)   '$.method',
        [can_delete] bit            '$.can_delete',
        [previous_deduction_amount] float          '$.previous_deduction_amount',
        [sequence] int            '$.sequence',
        [analytic_distribution] varchar(max)   '$.analytic_distribution'
    ) as j
)

select * from cdc_keyed
