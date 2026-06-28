select
    -- keys
    ipc_key = a.id,
    company_key         = a.company_id,
    project_key         = a.project_id,
    workflow_key        = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.x_workflow_stage_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.x_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(NULL as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    create_date_vn      = DATEADD(HOUR, 7, a.create_date),
    create_date_key     = cast(DATEADD(HOUR, 7, a.create_date) as date),
    employee_key        = b.id,
    customer_key        = a.contractor_id,
    sale_order_key    = a.sale_order_id,
    purchase_order_key = a.purchase_order_id,
    currency_key      = a.currency_id,
    contract_type_key = 'construction_ipc.' + iif(a.is_customer_ipc = 1, 'ab', 'bb'),
    f.account_analytic_key,
    end_date_key = iif(json_value(c.name, '$.en_US') = 'Hoàn Thành', cast(dateadd(hour, 7, a.x_workflow_state_date) as date), null),
    -- header info
    a.x_workflow_stage_id,
    a.x_workflow_id,
    a.name,
    a.is_customer_ipc,
    a.payment_milestone,
    a.invoice_status,
    a.start_date,
    a.end_date,
    -- amounts
    a.current_payment_amount,
    a.current_invoice_amount,
    a.total_contract_amount,
    a.total_amount,
    a.total_due_amount,
    a.previous_payment_amount,
    a.previous_certified_amount,
    a.advance_recovery_amount,
    a.deduction_amount,
    a.retention_amount,
    a.penalty_amount,
    a.net_amount
from [wh_core].[cc1].[int_xboss__construction_ipc_current] a
left join [wh_core].[cc1].[int_xboss__workflow_node_current] c
    on a.x_workflow_stage_id = c.id
    and c.__is_deleted = 0
    and c.id <> 20
left join [wh_core].[cc1].[int_xboss__hr_employee_current] b
    on a.user_id = b.user_id
    and a.company_id = b.company_id
    and b.__is_deleted = 0
    and b.active = 1
left join [wh_core].[cc1].[int_construction_ipc_account_analytic_mapping] f on a.id = f.id
where a.__is_deleted = 0
    and a.active = 1
    and a.company_id = 1
    and (json_value(c.name, '$.en_US') not in ('Đã Hủy', 'Lưu trữ', 'Cancelled')
        or c.name is null)