with
    eap as (
        select
            id,
            model               = 'employee.advance',
            x_workflow_id,
            x_workflow_stage_id,
            company_id,
            active,
            link                = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=193&action=2123&active_id=118&model=employee.advance&view_type=form', '{id}', cast(id as varchar))
        from [wh_core].[cc1].[int_xboss__employee_advance_current]
        where __is_deleted = 0
            and active = 1
    ),
    hes as (
        select
            id,
            model               = 'hr.expense.sheet',
            x_workflow_id,
            x_workflow_stage_id,
            company_id,
            active,
            link                = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=193&action=845&active_id=105&model=hr.expense.sheet&view_type=form', '{id}', cast(id as varchar))
        from [wh_core].[cc1].[int_xboss__hr_expense_sheet_current]
        where __is_deleted = 0
            and active = 1
    ),
    so as (
        select
            id,
            model               = 'sale.order',
            x_workflow_id,
            x_workflow_stage_id,
            company_id,
            active              = cast(1 as int),
            link                = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1225&action=2156&model=sale.order&view_type=form', '{id}', cast(id as varchar))
        from [wh_core].[cc1].[int_xboss__sale_order_current]
        where __is_deleted = 0
            and id not in (7138)
    ),
    po as (
        select
            id,
            model               = 'purchase.order',
            x_workflow_id,
            x_workflow_stage_id,
            company_id,
            active              = cast(1 as int),
            link                = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1156&action=1924&model=purchase.order&view_type=form', '{id}', cast(id as varchar))
        from [wh_core].[cc1].[int_xboss__purchase_order_current]
        where __is_deleted = 0
    ),
    mpr as (
        select
            id,
            model               = 'material.purchase.requisition',
            x_workflow_id,
            x_workflow_stage_id,
            company_id,
            active              = cast(1 as int),
            link                = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1221&action=2139&model=material.purchase.requisition&view_type=form', '{id}', cast(id as varchar))
        from [wh_core].[cc1].[int_xboss__material_purchase_requisition_current]
        where __is_deleted = 0
    ),
    jc as (
        select
            id,
            model               = 'job.costing',
            x_workflow_id,
            x_workflow_stage_id,
            company_id,
            active              = cast(1 as int),
            link                = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1271&action=2180&model=job.costing&view_type=form', '{id}', cast(id as varchar))
        from [wh_core].[cc1].[int_xboss__job_costing_current]
        where __is_deleted = 0
    ),
    union_data as (
        select * from eap
        union all select * from hes
        union all select * from so
        union all select * from po
        union all select * from mpr
        union all select * from jc
    )
select
    approval_key = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(model as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    a.id,
    a.model,
    a.x_workflow_stage_id,
    b.node_to,
    a.link,
    error_code = 'CN001'
from
    union_data a
    outer apply
    (
        select top 1 t.node_to
        from [wh_core].[cc1].[int_log_workflow_trans_deduplication] t
        where t.res_id = a.id and t.model = a.model
        order by t.create_date desc
    ) b
where a.company_id = 1 and (a.x_workflow_stage_id <> b.node_to or a.x_workflow_stage_id is null) and a.active = 1