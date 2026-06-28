

-- Incremental thay thế dbt snapshot: append 1 lần/ngày, không UPDATE/DELETE
-- Nhanh hơn ~3x so với snapshot vì chỉ 1 INSERT thay vì CREATE tmp + UPDATE + INSERT



select
    error_key
    ,error_code
    ,id
    ,model
    ,link
    ,duplicate_group
    ,CAST(GETDATE() AS DATE) as snapshot_date
from [wh_core].[cc1].[error] e
where not exists (
    select 1
    from [wh_core].[cc1].[int_error_snapshot] h
    where h.snapshot_date = CAST(GETDATE() AS DATE)
    and h.error_key = e.error_key
)

