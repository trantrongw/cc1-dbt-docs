with
    wf_node as (
        select *
        from [wh_core].[cc1].[int_xboss__workflow_node_current]
        where __is_deleted = 0
            and id <> 20
    ),
    purchase as (
        select id, group_name = 'Front Office', group_order = 1
        from wf_node
        where
            workflow_id in (
                select x_workflow_id
                from [wh_core].[cc1].[int_xboss__purchase_order_current]
                where __is_deleted = 0
                    and x_workflow_id is not null
                group by x_workflow_id
            )
    ),
    saleorder as (
        select id, group_name = 'Back Office', group_order = 2
        from wf_node
        where
            workflow_id in (
                select x_workflow_id
                from [wh_core].[cc1].[int_xboss__sale_order_current]
                where __is_deleted = 0
                    and x_workflow_id is not null
                group by x_workflow_id
            )
    ),
    pr as (
        select id, group_name = 'Front Office', group_order = 1
        from wf_node
        where
            workflow_id in (
                select x_workflow_id
                from [wh_core].[cc1].[int_xboss__material_purchase_requisition_current]
                where __is_deleted = 0
                    and x_workflow_id is not null
                    and company_id = 1
                group by x_workflow_id
            )
            and json_value(name, '$.en_US')
            not in ('Hoàn Thành Cung Ứng', 'CV Cung Ứng')
        union all
        select id, group_name = 'Back Office', group_order = 2
        from wf_node
        where
            workflow_id in (
                select x_workflow_id
                from [wh_core].[cc1].[int_xboss__material_purchase_requisition_current]
                where __is_deleted = 0
                    and x_workflow_id is not null
                    and company_id = 1
                group by x_workflow_id
            )
            and json_value(name, '$.en_US') in ('Hoàn Thành Cung Ứng', 'CV Cung Ứng')
    ),
    jc as (
        select id, group_name = 'Front Office', group_order = 1
        from wf_node
        where workflow_id = 40 and id < 387
        union all
        select id, group_name = 'Front Office', group_order = 1
        from wf_node
        where workflow_id = 40 and id >= 387
        union all
        select id, group_name = 'Front Office', group_order = 1
        from wf_node
        where workflow_id = 24 and id < 198
        union all
        select id, group_name = 'Front Office', group_order = 1
        from wf_node
        where workflow_id = 24 and id >= 198
    )
select id, group_name, group_order
from [wh_core].[cc1_seed_data].[seed_workflow_stages]
union all
select id, group_name, group_order
from purchase
union all
select id, group_name, group_order
from saleorder
union all
select id, group_name, group_order
from pr
union all
select id, group_name, group_order
from jc