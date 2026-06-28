with account_analytic as (
    select
        a.id,
        business_plan_id = max(d.id),
        business_unit_id = max(e.id),
        department_id    = max(f.id),
        revenue_item_id  = max(g.id),
        cost_item_id     = max(h.id)
    from [wh_core].[cc1].[int_xboss__account_payment_current] a
    outer apply openjson(a.analytic_distribution) b
    outer apply string_split(b.[key], ',') c
    left join [wh_core].[cc1].[int_xboss__account_analytic_account_current] d
        on c.[value] = d.id and d.plan_id = 1 and d.__is_deleted = 0 and d.active = 1
    left join [wh_core].[cc1].[int_xboss__account_analytic_account_current] e
        on c.[value] = e.id and e.plan_id = 6 and e.__is_deleted = 0 and e.active = 1
    left join [wh_core].[cc1].[int_xboss__account_analytic_account_current] f
        on c.[value] = f.id and f.plan_id = 3 and f.__is_deleted = 0 and f.active = 1
    left join [wh_core].[cc1].[int_xboss__account_analytic_account_current] g
        on c.[value] = g.id and g.plan_id = 4 and g.__is_deleted = 0 and g.active = 1
    left join [wh_core].[cc1].[int_xboss__account_analytic_account_current] h
        on c.[value] = h.id and h.plan_id = 5 and h.__is_deleted = 0 and h.active = 1
    where a.__is_deleted = 0
    group by a.id
)
select
     a.id
    ,a.business_plan_id
    ,a.business_unit_id
    ,a.department_id
    ,a.revenue_item_id
    ,a.cost_item_id
    ,account_analytic_key = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.business_plan_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.business_unit_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.department_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.revenue_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.cost_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))

    ,[project_id]=max(b.id)
from account_analytic a
    left join [wh_core].[cc1].[int_xboss__account_analytic_account_current] c
        on a.business_plan_id = c.id and c.__is_deleted = 0 and c.active = 1
    left join [wh_core].[cc1].[int_xboss__project_project_current] b
        on c.code = b.project_code and b.__is_deleted = 0 and b.active = 1
group by
    a.id
    ,a.business_plan_id
    ,a.business_unit_id
    ,a.department_id
    ,a.revenue_item_id
    ,a.cost_item_id
    ,
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.business_plan_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.business_unit_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.department_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.revenue_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.cost_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
