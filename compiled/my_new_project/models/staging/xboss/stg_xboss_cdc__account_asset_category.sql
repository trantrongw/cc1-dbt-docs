


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'account_asset_category'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__account_asset_category])
    
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
        [asset_account_id] int            '$.asset_account_id',
        [depreciation_account_id] int            '$.depreciation_account_id',
        [depreciation_expense_account_id] int            '$.depreciation_expense_account_id',
        [disposal_expense_account_id] int            '$.disposal_expense_account_id',
        [revaluation_decrease_account_id] int            '$.revaluation_decrease_account_id',
        [revaluation_increase_account_id] int            '$.revaluation_increase_account_id',
        [journal_id] int            '$.journal_id',
        [company_id] int            '$.company_id',
        [method_number] int            '$.method_number',
        [method_period] int            '$.method_period',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [method] varchar(max)   '$.method',
        [method_time] varchar(max)   '$.method_time',
        [type] varchar(max)   '$.type',
        [date_first_accounting] varchar(max)   '$.date_first_accounting',
        [method_end] int            '$.method_end',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [active] bit            '$.active',
        [prorata] bit            '$.prorata',
        [open_asset] bit            '$.open_asset',
        [use_company_currency] bit            '$.use_company_currency',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [method_progress_factor] float          '$.method_progress_factor',
        [stock_input_account_id] int            '$.stock_input_account_id',
        [sequence_id] int            '$.sequence_id',
        [short_code] varchar(max)   '$.short_code',
        [auto_create_value_option] varchar(max)   '$.auto_create_value_option',
        [multiple_assets_per_line] bit            '$.multiple_assets_per_line'
    ) as j
)

select * from cdc_keyed
