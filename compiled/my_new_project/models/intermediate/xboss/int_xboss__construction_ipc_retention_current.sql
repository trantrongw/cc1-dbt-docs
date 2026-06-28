

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc_retention]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__construction_ipc_retention_current])
    
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
        [currency_id],
        [company_id],
        [journal_id],
        [sequence],
        [ipc_id],
        [move_id],
        [sale_retention_id],
        [purchase_retention_id],
        [create_uid],
        [write_uid],
        [name],
        [option],
        [planned_amount],
        [amount_total],
        [actual_amount],
        [amount_paid],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [percentage],
        [product_id],
        [previous_retention_amount],
        [can_delete],
        [analytic_distribution]
from ranked
where rn = 1