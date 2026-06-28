

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__product_template]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__product_template_current])
    
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
        [categ_id],
        [uom_id],
        [uom_po_id],
        [company_id],
        [color],
        [create_uid],
        [write_uid],
        [detailed_type],
        [type],
        [default_code],
        [priority],
        [name],
        [description],
        [description_purchase],
        [description_sale],
        [product_properties],
        [list_price],
        [volume],
        [weight],
        [sale_ok],
        [purchase_ok],
        [active],
        [can_image_1024_be_zoomed],
        [has_configurable_attributes],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [can_be_expensed],
        [sale_delay],
        [tracking],
        [description_picking],
        [description_pickingout],
        [description_pickingin],
        [purchase_method],
        [purchase_line_warn],
        [purchase_line_warn_msg],
        [service_type],
        [sale_line_warn],
        [expense_policy],
        [invoice_policy],
        [sale_line_warn_msg],
        [service_tracking],
        [service_upsell_threshold],
        [name_sanitized],
        [technician_user_id],
        [equipment_assign_to],
        [split_method_landed_cost],
        [landed_cost_ok],
        [stowage_volume],
        [concat_dimension_in_name],
        [length],
        [width],
        [height],
        [stowage_factor],
        [secondary_uom],
        [is_secondary_unit],
        [uom_match],
        [factor],
        [allow_negative_stock],
        [is_fuel],
        [is_vehicle_part],
        [available_in_pos],
        [to_weight],
        [is_pos_bom],
        [lot_sequence_id],
        [lot_sequence_padding],
        [lot_sequence_prefix],
        [auto_create_lot]
from ranked
where rn = 1