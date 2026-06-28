

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__log_workflow_trans]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__log_workflow_trans_current])
    
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
        [trans_id],
        [node_id],
        [res_id],
        [create_uid],
        [write_uid],
        [name],
        [username],
        [note],
        [active],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        
DATEADD(DAY, [date_deadline], cast('1970-01-01' as date))
 as [date_deadline],
        [model],
        [workflow_id],
        [sla_status],
        
DATEADD(MICROSECOND, [start_datetime] % 1000000,
    DATEADD(SECOND, [start_datetime] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [start_datetime],
        [time_spent_raw],
        [time_spent],
        [estimated_processing_time]
from ranked
where rn = 1