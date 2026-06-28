with base as (
    select *, row_number() over (partition by DateKey order by DateKey) as rn
    from [wh_core].[cc1].[stg_seed__date]
    where DateKey >= 20250101 and DateKey <= 20261231
)
select * from base where rn = 1