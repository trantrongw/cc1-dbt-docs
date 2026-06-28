

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__material_purchase_requisition_line]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__material_purchase_requisition_line_current])
    
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
        [requisition_id],
        [product_id],
        [uom],
        [company_id],
        [create_uid],
        [write_uid],
        [description],
        [requisition_type],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [qty],
        [custom_job_costing_id],
        [custom_job_costing_line_id],
        [highlight_color],
        [analytic_distribution],
        [brand_id],
        [manufacturere_id],
        [price_unit],
        [price_total],
        [secondary_uom_id],
        [product_secondary_qty],
        [barem_diff_qty],
        [already_purchase_requested],
        [already_stock_requested],
        [cumulative_qty],
        [product_categ_id],
        [state_purchase_order_not_draft],
        [ordered_qty],
        [order_remaining_qty]
from ranked
where rn = 1