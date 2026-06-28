select
    1 as approval_age_group_key,
    '0-1 ngày' as approval_age_group_name,
    1 as approval_age_group_order
union all
select 2, '2-3 ngày', 2
union all
select 3, '4-7 ngày', 3
union all
select 4, 'Trên 7 ngày', 4