

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc_line]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__construction_ipc_line_current])
    
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
        [ipc_id],
        [product_id],
        [uom_id],
        [custom_task_id],
        [project_id],
        [currency_id],
        [sequence],
        [company_id],
        [create_uid],
        [write_uid],
        [description],
        [name],
        [display_type],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [quantity],
        [unit_price],
        [total_amount],
        [invoice_line_id],
        [sale_order_line_id],
        [purchase_order_line_id],
        [completed_qty],
        [remaining_qty],
        [delivered_qty],
        [invoice_qty],
        [planned_qty],
        [billed_qty],
        [purchase_qty],
        [received_qty],
        [pending_qty],
        [approved_to_date_qty],
        [level],
        [wbs_code],
        [wbs_sort_key],
        [origin_uom_name],
        [note],
        [section_total],
        [total_amount_untaxed],
        [total_amount_tax],
        [analytic_distribution]
from ranked
where rn = 1