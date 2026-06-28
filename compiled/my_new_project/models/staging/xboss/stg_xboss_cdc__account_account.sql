


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'account_account'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__account_account])
    
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
        [group_id] int            '$.group_id',
        [root_id] int            '$.root_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [code] varchar(max)   '$.code',
        [account_type] varchar(max)   '$.account_type',
        [internal_group] varchar(max)   '$.internal_group',
        [name] varchar(max)   '$.name',
        [note] varchar(max)   '$.note',
        [deprecated] bit            '$.deprecated',
        [include_initial_balance] bit            '$.include_initial_balance',
        [reconcile] bit            '$.reconcile',
        [non_trade] bit            '$.non_trade',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [show_both_dr_and_cr_trial_balance] bit            '$.show_both_dr_and_cr_trial_balance',
        [appears_on_overview] bit            '$.appears_on_overview',
        [is_view_only] bit            '$.is_view_only',
        [is_flexible_account] bit            '$.is_flexible_account'
    ) as j
)

select * from cdc_keyed
