select
    t1.id,
    model = 'hr.expense.sheet',
    link  = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=193&action=845&active_id=105&model=hr.expense.sheet&view_type=form', '{id}', cast(t1.id as varchar)),
    t3.name,
    error_code = 'HES001'
from [wh_core].[cc1].[int_xboss__hr_expense_sheet_current] t1
    left join [wh_core].[cc1].[int_hr_expense_sheet_account_analytic_mapping] t2 on t1.id = t2.id
    left join [wh_core].[cc1].[int_xboss__workflow_config_current] t3
        on t1.expense_workflow_id = t3.id
        and t3.__is_deleted = 0
        and t3.active = 1
    left join [wh_core].[cc1].[int_xboss__project_project_current] t4
        on t2.business_plan_id = t4.analytic_account_id
        and t4.__is_deleted = 0
        and t4.active = 1
where t4.id is null
    and t1.__is_deleted = 0
    and t1.active = 1
    and t1.company_id = 1
    and t3.code = 'XL'