with dup_groups as (
    select
        b.business_plan_id,
        a.amount,
        string_agg(cast(a.id as varchar(20)), ',') as tags
    from [wh_core].[cc1].[int_xboss__account_payment_current] a
    inner join [wh_core].[cc1].[int_account_account] acc
        on a.destination_account_id = acc.id
        and acc.code in ('131101001', '131101002')
    left join [wh_core].[cc1].[int_account_payment_account_analytic_mapping] b on a.id = b.id
    inner join [wh_core].[cc1].[int_xboss__account_move_current] c
        on a.move_id = c.id
        and c.__is_deleted = 0
    where a.__is_deleted = 0
      and b.business_plan_id is not null
      and c.state = 'posted'
      and c.company_id = 1
    group by b.business_plan_id, a.amount
    having count(1) > 1
),
split_ids as (
    select distinct
        cast(s.value as int) as payment_id,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(d.business_plan_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(d.amount as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
 as duplicate_group
    from dup_groups d
    cross apply string_split(d.tags, ',') s
)

select
    a.id,
    model = 'account.payment',
    link  = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=556&action=773&model=account.payment&view_type=form', '{id}', cast(a.id as varchar)),
    error_code      = 'AP001',
    duplicate_group = si.duplicate_group
from split_ids si
inner join [wh_core].[cc1].[int_xboss__account_payment_current] a
    on si.payment_id = a.id
    and a.__is_deleted = 0