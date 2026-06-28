select
    project_key = a.id,
    company_key = a.company_id,
    vn_project_name = cast(
        coalesce(
            json_value(a.name, '$.vi_VN'), json_value(a.name, '$.en_US'), 'Unknow'
        ) as varchar(100)
    ),
    vn_business_unit = cast(
        coalesce(
            json_value(b.name, '$.vi_VN'), json_value(a.name, '$.en_US'), 'Unknow'
        ) as varchar(100)
    )
from [wh_core].[cc1].[int_xboss__project_project_current] a
left join
    [wh_core].[cc1].[int_xboss__account_analytic_account_current] b on a.business_unit_id = b.id
where a.__is_deleted = 0
    and a.active = 1