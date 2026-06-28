select
    t1. [employee_advance_id] as id,
    model = 'employee.advance',
    max(t2.id) as project_id,
    count(1) as cn
from [wh_core].[cc1].[int_xboss__employee_advance_project_analytic_rel_current] t1
    inner join [wh_core].[cc1].[int_xboss__account_analytic_account_current] t3
        on t1.account_analytic_id = t3.id
        and t3.__is_deleted = 0
        and t3.active = 1
    inner join [wh_core].[cc1].[int_xboss__project_project_current] t2
        on (t3.id = t2.analytic_account_id or t3.code = t2.project_code)
        and t2.__is_deleted = 0
        and t2.active = 1
where t1.__is_deleted = 0
group by t1. [employee_advance_id]
union all
select
    t1. [hr_expense_sheet_id] as id,
    model = 'hr.expense.sheet',
    max(t2.id) as project_id,
    count(1) as cn
from [wh_core].[cc1].[int_xboss__hr_expense_sheet_project_analytic_rel_current] t1
inner join [wh_core].[cc1].[int_xboss__account_analytic_account_current] t3
    on t1.account_analytic_id = t3.id
    and t3.__is_deleted = 0
    and t3.active = 1
inner join [wh_core].[cc1].[int_xboss__project_project_current] t2
    on (t3.id = t2.analytic_account_id or t3.code = t2.project_code)
    and t2.__is_deleted = 0
    and t2.active = 1
where t1.__is_deleted = 0
group by t1. [hr_expense_sheet_id]