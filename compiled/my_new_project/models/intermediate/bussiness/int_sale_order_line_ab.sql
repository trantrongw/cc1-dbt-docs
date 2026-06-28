select
    -- keys từ int_sale_order
    a.sale_order_key
    ,sale_order_line_key  = b.id
    ,ab_key = b.id
    ,a.approval_key
    ,a.employee_key
    ,a.company_key
    ,a.workflow_key
    ,a.project_key
    ,a.create_date_key
    ,a.account_analytic_key
    ,a.customer_key
    ,product_key = b.product_id
    ,contract_type_key = a.contract_type
    -- line attributes
    ,b.wbs_code
    ,b.level
    ,b.name
    ,b.analytic_distribution
    ,b.product_uom_qty
    ,b.remaining_qty
    ,b.complete_qty
    ,b.qty_delivered
    ,b.qty_invoiced
    ,b.product_uom
    ,b.price_unit
    ,b.price_subtotal
    ,b.section_total

from [wh_core].[cc1].[int_sale_order] a
inner join [wh_core].[cc1].[int_xboss__sale_order_line_current] b
    on a.id = b.order_id
    and b.__is_deleted = 0
left join [wh_core].[cc1].[int_xboss__workflow_node_current] c
    on a.x_workflow_stage_id = c.id
    and c.__is_deleted = 0
    and c.id <> 20
where a.is_customer_contract  = 1 and json_value(c.name, '$.en_US') in ('Đã Ký')