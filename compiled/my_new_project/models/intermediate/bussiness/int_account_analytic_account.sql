select
    id,
    name = cast(
        coalesce(
            json_value(name, '$.vi_VN'), json_value(name, '$.en_US'), 'Unknow'
        ) as varchar(100)
    ),
    plan_id
from [wh_core].[cc1].[int_xboss__account_analytic_account_current]
where __is_deleted = 0
    and active = 1