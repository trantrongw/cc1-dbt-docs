

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__purchase_order_line]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__purchase_order_line_current])
    
),
ranked as (
    select *,
           ROW_NUMBER() OVER (PARTITION BY __id ORDER BY __dbz_timestamp DESC, __dbz_lsn DESC) as rn
    from staged
)
select
    __dbz_operation,
    __dbz_timestamp,
    __dbz_lsn,
    __id,
    case when __dbz_operation = 'd' then 1 else 0 end as __is_deleted,
    __dbz_timestamp                                    as __last_changed_at,
        [id],
        [sequence],
        [product_uom],
        [product_id],
        [order_id],
        [company_id],
        [partner_id],
        [currency_id],
        [product_packaging_id],
        [create_uid],
        [write_uid],
        [state],
        [qty_received_method],
        [display_type],
        [analytic_distribution],
        [name],
        [product_qty],
        [discount],
        [price_unit],
        [price_subtotal],
        [price_total],
        [qty_invoiced],
        [qty_received],
        [qty_received_manual],
        [qty_to_invoice],
        
DATEADD(MICROSECOND, [date_planned] % 1000000,
    DATEADD(SECOND, [date_planned] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [date_planned],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [product_uom_qty],
        [price_tax],
        [product_packaging_qty],
        [orderpoint_id],
        [product_description_variants],
        [propagate_cancel],
        [custom_requisition_line_id],
        [job_cost_id],
        [job_cost_line_id],
        [sale_order_id],
        [sale_line_id],
        [analytic_json],
        [sequence_edit],
        [inter_comp_sale_order_line_id],
        [manufacturere_id],
        [secondary_uom],
        [secondary_qty],
        [section_total],
        [complete_qty],
        [remaining_qty],
        [highlight_color],
        [brand_manufacturer_id],
        [level],
        [wbs_code],
        [wbs_sort_key],
        [origin_uom_name],
        [note],
        [barem_diff_line_id],
        [requisition_line_id],
        [procurement_type],
        [lot_name]
from ranked
where rn = 1