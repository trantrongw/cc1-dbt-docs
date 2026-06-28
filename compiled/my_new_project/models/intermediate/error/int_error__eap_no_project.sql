select
    t1.*,
    model = 'employee.advance',
    link  = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=193&action=2123&active_id=118&model=employee.advance&view_type=form', '{id}', cast(t4.id as varchar)),
    error_code = 'EAP001',
    t5.name
from [wh_core].[cc1].[int_xboss__employee_advance_project_analytic_rel_current] t1
    inner join [wh_core].[cc1].[int_xboss__account_analytic_account_current] t3
        on t1.account_analytic_id = t3.id
        and t3.__is_deleted = 0
        and t3.active = 1
    inner join [wh_core].[cc1].[int_xboss__employee_advance_current] t4
        on t1.employee_advance_id = t4.id
        and t4.__is_deleted = 0
        and t4.active = 1
    inner join [wh_core].[cc1].[int_xboss__workflow_config_current] t5
        on t4.expense_workflow_id = t5.id
        and t5.__is_deleted = 0
        and t5.active = 1
    left join [wh_core].[cc1].[int_xboss__project_project_current] t2
        on t3.id = t2.analytic_account_id
        and t2.__is_deleted = 0
        and t2.active = 1
where t1.__is_deleted = 0
    and t2.id is null
    and t5.code = 'XL'
    and t4.company_id = 1