

with snap as (
    select * from [wh_core].[cc1].[int_error_snapshot]
),

today as (
    select CAST(GETDATE() AS DATE) as dt
),

-- first/last seen per error_key
agg as (
    select
        error_key
        ,error_code
        ,id
        ,model
        ,link
        ,duplicate_group
        ,MIN(snapshot_date) as first_seen_date
        ,MAX(snapshot_date) as last_seen_date
        ,COUNT(DISTINCT snapshot_date) as occurrence_day_count
    from snap
    group by error_key, error_code, id, model, link, duplicate_group
),

classified as (
    select
        a.error_key
        ,a.error_code
        ,a.id
        ,a.model
        ,a.link
        ,a.duplicate_group
        ,a.first_seen_date
        ,iif(a.last_seen_date < t.dt, a.last_seen_date, null) as resolved_date
        ,DATEDIFF(
            DAY,
            a.first_seen_date,
            iif(a.last_seen_date < t.dt, a.last_seen_date, t.dt)
        ) as age_days
        ,case
            when a.last_seen_date < t.dt     then 'resolved'
            when a.first_seen_date = t.dt    then 'new'
            else                                  'persisting'
        end as error_status
        ,a.occurrence_day_count
    from agg a
    cross join today t
)

select
    error_key
    ,error_code
    ,id
    ,model
    ,link
    ,duplicate_group
    ,first_seen_date
    ,resolved_date
    ,age_days
    ,error_status
    ,iif(occurrence_day_count > 1, 1, 0) as is_recurred
    ,occurrence_day_count
from classified