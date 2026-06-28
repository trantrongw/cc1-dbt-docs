


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'construction_ipc_retention'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc_retention])
    
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
        [currency_id] int            '$.currency_id',
        [company_id] int            '$.company_id',
        [journal_id] int            '$.journal_id',
        [sequence] int            '$.sequence',
        [ipc_id] int            '$.ipc_id',
        [move_id] int            '$.move_id',
        [sale_retention_id] int            '$.sale_retention_id',
        [purchase_retention_id] int            '$.purchase_retention_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [option] varchar(max)   '$.option',
        [planned_amount] decimal(38,10) '$.planned_amount',
        [amount_total] decimal(38,10) '$.amount_total',
        [actual_amount] decimal(38,10) '$.actual_amount',
        [amount_paid] decimal(38,10) '$.amount_paid',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [percentage] float          '$.percentage',
        [product_id] int            '$.product_id',
        [previous_retention_amount] decimal(38,10) '$.previous_retention_amount',
        [can_delete] bit            '$.can_delete',
        [analytic_distribution] varchar(max)   '$.analytic_distribution'
    ) as j
)

select * from cdc_keyed
