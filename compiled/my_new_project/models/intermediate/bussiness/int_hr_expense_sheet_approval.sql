select
    [approval_key] = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast('hr.expense.sheet' as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    [employee_key] = a.employee_id,
    [company_key] = a.company_id,
    -- ,[RESPONSIBLE_EMPLOYEE_KEY]=COALESCE(a.responsible_id,a.account_responsible_id)
    [workflow_key]
    =
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.x_workflow_stage_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.x_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.expense_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    [project_key] = c.project_id,
    [create_date_key] = cast(DATEADD(HOUR, 7, a.create_date) as date),
    create_date_vn = DATEADD(HOUR, 7, a.create_date),
    x_workflow_state_date_vn = DATEADD(HOUR, 7, a.x_workflow_state_date),
    [start_date]      = DATEADD(HOUR, 7, a.create_date),
    [end_date]        = iif(d.node_id = a.x_workflow_stage_id, DATEADD(HOUR, 7, a.x_workflow_state_date), null),
    [days]            = iif(
        d.node_id = a.x_workflow_stage_id,
        datediff(day, DATEADD(HOUR, 7, a.create_date), DATEADD(HOUR, 7, a.x_workflow_state_date)),
        datediff(day, cast(DATEADD(HOUR, 7, a.create_date) as date), getdate())
    ),
    [approval_code] = a.code,
    [approval_name] = a.name,
    a.id,
    model = 'hr.expense.sheet',
    [link] = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=193&action=845&active_id=105&model=hr.expense.sheet&view_type=form', '{id}', cast(a.id as varchar)),
    a.state,
    a.priority,
    a.payment_state,
    e.account_analytic_key,
    [customer_key] = a.partner_id
from [wh_core].[cc1].[int_xboss__hr_expense_sheet_current] as a
inner join [wh_core].[cc1].[int_xboss__workflow_node_current] b
    on a.x_workflow_stage_id = b.id
    and b.__is_deleted = 0
    and b.id <> 20
left join
    [wh_core].[cc1].[int_workflow_node_close_workflow] d on d.node_id = a.x_workflow_stage_id
left join [wh_core].[cc1].[int_approval_project_link] c on a.id = c.id and c.model = 'hr.expense.sheet'
left join
    [wh_core].[cc1].[int_hr_expense_sheet_account_analytic_mapping] e
    on a.id = e.id
where a.__is_deleted = 0
    and a.active = 1
    and a.company_id = 1