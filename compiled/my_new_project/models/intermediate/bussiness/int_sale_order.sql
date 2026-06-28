select
    --key
    approval_key = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast('sale.order' as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    employee_key = b.id,
    company_key = a.company_id,
    workflow_key
    =
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.x_workflow_stage_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.x_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(NULL as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    project_key = a.contract_project_id,
    create_date_key = cast(DATEADD(HOUR, 7, a.create_date) as date),
    sale_order_key = a.id,
    --header attributes
    create_date_vn = DATEADD(HOUR, 7, a.create_date),
    x_workflow_state_date_vn = DATEADD(HOUR, 7, a.x_workflow_state_date),
    a.x_workflow_stage_id,
    a.is_customer_contract,
    approval_code = a.name,
    approval_name = a.name,
    a.id,
    model = 'sale.order',
    link = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1225&action=2156&model=sale.order&view_type=form', '{id}', cast(a.id as varchar)),
    active = 1,
    a.state,
    priority = 'unknow',
    payment_state = 'unknow',
    f.account_analytic_key,
    contract_type = 'sale.order.' + iif(a.is_customer_contract = 1, 'ab', 'sale'),
    customer_key = a.partner_id,
    --sla
    start_date      = DATEADD(HOUR, 7, a.create_date),
    end_date        = iif(d.node_id = a.x_workflow_stage_id, DATEADD(HOUR, 7, a.x_workflow_state_date), null),
    days            = iif(
        d.node_id = a.x_workflow_stage_id,
        datediff(day, DATEADD(HOUR, 7, a.create_date), DATEADD(HOUR, 7, a.x_workflow_state_date)),
        datediff(day, cast(DATEADD(HOUR, 7, a.create_date) as date), getdate())
    )
from [wh_core].[cc1].[int_xboss__sale_order_current] a
left join
    [wh_core].[cc1].[int_xboss__hr_employee_current] b
    on a.user_id = b.user_id
    and a.company_id = b.company_id
    and b.__is_deleted = 0
    and b.active = 1
left join
    [wh_core].[cc1].[int_sale_order_account_analytic_mapping] f on a.id = f.id
left join
    [wh_core].[cc1].[int_workflow_node_close_workflow] d on d.node_id = a.x_workflow_stage_id
where a.__is_deleted = 0
    and a.company_id = 1
    and a.id not in (7138)