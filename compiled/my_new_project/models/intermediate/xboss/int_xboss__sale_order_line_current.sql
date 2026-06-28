

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__sale_order_line]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__sale_order_line_current])
    
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
        [order_id],
        [sequence],
        [company_id],
        [currency_id],
        [order_partner_id],
        [salesman_id],
        [product_id],
        [product_uom],
        [product_packaging_id],
        [create_uid],
        [write_uid],
        [state],
        [display_type],
        [qty_delivered_method],
        [invoice_status],
        [analytic_distribution],
        [name],
        [product_uom_qty],
        [price_unit],
        [discount],
        [price_subtotal],
        [price_total],
        [price_reduce_taxexcl],
        [price_reduce_taxinc],
        [qty_delivered],
        [qty_invoiced],
        [qty_to_invoice],
        [untaxed_amount_invoiced],
        [untaxed_amount_to_invoice],
        [is_downpayment],
        [is_expense],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [price_tax],
        [product_packaging_qty],
        [customer_lead],
        [route_id],
        [event_id],
        [event_ticket_id],
        [is_service],
        [project_id],
        [task_id],
        [has_displayed_warning_upsell],
        [remaining_hours],
        [amount_paid],
        [amount_unpaid],
        [inter_comp_purchase_order_line_id],
        [manufacturere_id],
        [secondary_uom],
        [secondary_qty],
        [section_total],
        [complete_qty],
        [remaining_qty],
        [brand_manufacturer_id],
        [reward_id],
        [coupon_id],
        [reward_identifier_code],
        [points_cost],
        [level],
        [wbs_code],
        [wbs_sort_key],
        [origin_uom_name],
        [note],
        [blanket_order_line],
        [property_id],
        [is_property],
        [lot_name]
from ranked
where rn = 1