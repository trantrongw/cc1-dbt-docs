

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__account_asset_category]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__account_asset_category_current])
    
),
ranked as (
    select *,
           ROW_NUMBER() OVER (PARTITION BY __id ORDER BY __dbz_timestamp DESC, __dbz_lsn DESC) as rn
    from staged
)
select
    __dbz_operation,
    __dbz_timestamp,
    __dbz_lsn,
    __id,
    case when __dbz_operation = 'd' then 1 else 0 end as __is_deleted,
    __dbz_timestamp                                    as __last_changed_at,
        [id],
        [asset_account_id],
        [depreciation_account_id],
        [depreciation_expense_account_id],
        [disposal_expense_account_id],
        [revaluation_decrease_account_id],
        [revaluation_increase_account_id],
        [journal_id],
        [company_id],
        [method_number],
        [method_period],
        [create_uid],
        [write_uid],
        [name],
        [method],
        [method_time],
        [type],
        [date_first_accounting],
        
DATEADD(DAY, [method_end], cast('1970-01-01' as date))
 as [method_end],
        [analytic_distribution],
        [active],
        [prorata],
        [open_asset],
        [use_company_currency],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [method_progress_factor],
        [stock_input_account_id],
        [sequence_id],
        [short_code],
        [auto_create_value_option],
        [multiple_assets_per_line]
from ranked
where rn = 1