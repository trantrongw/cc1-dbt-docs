select
    --keys
    approval_key = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast('purchase.order' as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    employee_key = b.id,
    company_key = a.company_id,
    workflow_key
    =
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.x_workflow_stage_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.x_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(NULL as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    project_key = a.contract_project_id,
    create_date_key = cast(DATEADD(HOUR, 7, a.create_date) as date),
    customer_key = a.partner_id,
    f.account_analytic_key,
    purchase_order_key = a.id,
    --attributes
    a.x_workflow_stage_id,
    a.is_sub_contract,
    create_date_vn = DATEADD(HOUR, 7, a.create_date),
    x_workflow_state_date_vn = DATEADD(HOUR, 7, a.x_workflow_state_date),
    start_date      = DATEADD(HOUR, 7, a.create_date),
    end_date        = iif(d.node_id = a.x_workflow_stage_id, DATEADD(HOUR, 7, a.x_workflow_state_date), null),
    days            = iif(
        d.node_id = a.x_workflow_stage_id,
        datediff(day, DATEADD(HOUR, 7, a.create_date), DATEADD(HOUR, 7, a.x_workflow_state_date)),
        datediff(day, cast(DATEADD(HOUR, 7, a.create_date) as date), getdate())
    ),
    approval_code = a.name,
    approval_name = a.name,
    a.id,
    model = 'purchase.order',
    link = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1156&action=1924&model=purchase.order&view_type=form', '{id}', cast(a.id as varchar)),
    active = 1,
    a.state,
    a.priority,
    payment_state = 'unknow',
    contract_type = 'purchase.order.' + iif(a.is_sub_contract = 1, 'bb', 'purchase')

from [wh_core].[cc1].[int_xboss__purchase_order_current] a
left join
    [wh_core].[cc1].[int_xboss__hr_employee_current] b
    on a.user_id = b.user_id
    and a.company_id = b.company_id
    and b.__is_deleted = 0
    and b.active = 1
left join
    [wh_core].[cc1].[int_workflow_node_close_workflow] d on d.node_id = a.x_workflow_stage_id
left join [wh_core].[cc1].[int_purchase_order_account_analytic_mapping] f on a.id = f.id
where a.__is_deleted = 0
    and a.company_id = 1