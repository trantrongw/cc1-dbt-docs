with
    eap as (
        select
            id,
            model               = 'employee.advance',
            create_date,
            company_id,
            responsible_id,
            active,
            x_workflow_id,
            expense_workflow_id,
            is_sub_contract     = cast(null as int),
            is_customer_contract = cast(null as int),
            partner_id
        from [wh_core].[cc1].[int_xboss__employee_advance_current]
        where __is_deleted = 0
            and active = 1
            and company_id = 1
    ),
    hes as (
        select
            id,
            model               = 'hr.expense.sheet',
            create_date,
            company_id,
            responsible_id,
            active,
            x_workflow_id,
            expense_workflow_id,
            is_sub_contract     = cast(null as int),
            is_customer_contract = cast(null as int),
            partner_id
        from [wh_core].[cc1].[int_xboss__hr_expense_sheet_current]
        where __is_deleted = 0
            and active = 1
            and company_id = 1
    ),
    so as (
        select
            id,
            model               = 'sale.order',
            create_date,
            company_id,
            responsible_id      = cast(null as int),
            active              = cast(1 as int),
            x_workflow_id,
            expense_workflow_id = cast(null as int),
            is_sub_contract     = cast(null as int),
            is_customer_contract,
            partner_id
        from [wh_core].[cc1].[int_xboss__sale_order_current]
        where __is_deleted = 0
            and company_id = 1
            and id not in (7138)
    ),
    po as (
        select
            id,
            model               = 'purchase.order',
            create_date,
            company_id,
            responsible_id      = cast(null as int),
            active              = cast(1 as int),
            x_workflow_id,
            expense_workflow_id = cast(null as int),
            is_sub_contract,
            is_customer_contract = cast(null as int),
            partner_id
        from [wh_core].[cc1].[int_xboss__purchase_order_current]
        where __is_deleted = 0
            and company_id = 1
    ),
    mpr as (
        select
            id,
            model               = 'material.purchase.requisition',
            create_date,
            company_id,
            responsible_id      = cast(null as int),
            active              = cast(1 as int),
            x_workflow_id,
            expense_workflow_id = cast(null as int),
            is_sub_contract     = cast(null as int),
            is_customer_contract = cast(null as int),
            partner_id
        from [wh_core].[cc1].[int_xboss__material_purchase_requisition_current]
        where __is_deleted = 0
            and company_id = 1
    ),
    jc as (
        select
            id,
            model               = 'job.costing',
            create_date,
            company_id,
            responsible_id      = cast(null as int),
            active              = cast(1 as int),
            x_workflow_id,
            expense_workflow_id = cast(null as int),
            is_sub_contract     = cast(null as int),
            is_customer_contract = cast(null as int),
            partner_id          = cast(null as int)
        from [wh_core].[cc1].[int_xboss__job_costing_current]
        where __is_deleted = 0
            and company_id = 1
    ),
    union_data as (
        select * from eap
        union all select * from hes
        union all select * from so
        union all select * from po
        union all select * from mpr
        union all select * from jc
    ),
    add_days as (
        select
            approval_key = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.model as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
            approval_log_key = a.id_log,
            a.id,
            a.model,
            coalesce(e.id, d.id, 0) as employee_id,
            a.node_to,
            b.expense_workflow_id,
            cast(b.create_date as date) as create_date,
            b.company_id as company_id,
            a.start_date,
            a.end_date,
            c.is_end,
            iif(
                c.is_end = 1,
                0,
                datediff(day, a.start_date, coalesce(a.end_date, getdate()))
            ) as days,
            a.estimated_processing_time,
            node,
            a.is_backward,
            f.project_id,
            b.x_workflow_id,
            g.account_analytic_key,
            customer_key = b.partner_id,
            contract_type_key = case
                when b.model = 'sale.order'
                then b.model + '.' + iif(b.is_customer_contract = 1, 'ab', 'sale')
                when b.model = 'purchase.order'
                then b.model + '.' + iif(b.is_sub_contract = 1, 'bb', 'purchase')
                else b.model
            end
        from [wh_core].[cc1].[int_log_workflow_trans_end_date] a
        inner join union_data b on a.id = b.id and a.model = b.model
        left join
            [wh_core].[cc1].[int_workflow_node_close_workflow] c on a.node_to = c.node_id
        left join
            [wh_core].[cc1].[int_xboss__hr_employee_current] d
            on b.responsible_id = d.user_id
            and b.company_id = d.company_id
            and d.__is_deleted = 0
            and d.active = 1
        left join
            [wh_core].[cc1].[int_xboss__hr_employee_current] e
            on a.create_uid = e.user_id
            and b.company_id = e.company_id
            and e.__is_deleted = 0
            and e.active = 1
        left join
            [wh_core].[cc1].[int_approval_project_link] f
            on a.id = f.id
            and a.model = f.model
        left join
            [wh_core].[cc1].[int_account_analytic_union] g
            on a.id = g.id
            and a.model = g.model
        where b.active = 1
    -- and a.model in ('employee.advance','hr.expense.sheet')
    )
select
    a.approval_key,
    a.approval_log_key,
    employee_key = a.employee_id,
    workflow_key
    = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.node_to as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.x_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(a.expense_workflow_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    create_date_key = a.create_date,
    company_key = a.company_id,
    project_key = a.project_id,
    a.start_date,
    a.end_date,
    a.days,
    is_delay = iif(a.is_end = 1, 0, iif(days > a.estimated_processing_time, 1, 0)),
    a.is_backward,
    a.id,
    a.model,
    is_error = iif(c.approval_key is null, 'No', 'Yes'),
    a.account_analytic_key,
    a.contract_type_key,
    a.customer_key,
    a.estimated_processing_time
from add_days a
left join
    [wh_core].[cc1].[int_error__contract_and_log_node] c
    on a.approval_key = c.approval_key