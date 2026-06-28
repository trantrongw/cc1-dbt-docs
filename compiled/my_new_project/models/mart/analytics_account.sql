select 
    account_analytic_key
    ,business_plan_name = b.name
    ,business_unit_name = c.name
    ,department_name = d.name
    ,revenue_item_name = e.name
    ,cost_item_name = f.name
from [wh_core].[cc1].[int_account_analytic_deduplication] a
left join [wh_core].[cc1].[int_account_analytic_account] b on a.business_plan_id = b.id
left join [wh_core].[cc1].[int_account_analytic_account] c on a.business_unit_id = c.id
left join [wh_core].[cc1].[int_account_analytic_account] d on a.department_id = d.id
left join [wh_core].[cc1].[int_account_analytic_account] e on a.revenue_item_id = e.id
left join [wh_core].[cc1].[int_account_analytic_account] f on a.cost_item_id = f.id