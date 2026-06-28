select
    a.id as employee_key,
    -- a.user_id,
    -- a.company_id,
    a.name as employee_name,
    isnull(
        cast(
            coalesce(
                json_value(b.name, '$.vi_VN'), json_value(b.name, '$.en_US')
            ) as varchar(1000)
        ),
        'Unknow'
    ) as vn_department_name
from [wh_core].[cc1].[int_xboss__hr_employee_current] a
left join [wh_core].[cc1].[int_xboss__hr_department_current] b on a.[department_id] = b.id
where a.__is_deleted = 0
    and a.active = 1