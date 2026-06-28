


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'product_template'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__product_template])
    
),
cdc_keyed as (
    select
        __dbz_operation,
        __dbz_timestamp,
        __dbz_lsn,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(__dbz_timestamp as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(__dbz_lsn as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
 as __event_key,
        
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_')), '')), 2))
      as __id,
        j.*
    from cdc_src
    cross apply OPENJSON(record_data) with (
        [id] int            '$.id',
        [sequence] int            '$.sequence',
        [categ_id] int            '$.categ_id',
        [uom_id] int            '$.uom_id',
        [uom_po_id] int            '$.uom_po_id',
        [company_id] int            '$.company_id',
        [color] int            '$.color',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [detailed_type] varchar(max)   '$.detailed_type',
        [type] varchar(max)   '$.type',
        [default_code] varchar(max)   '$.default_code',
        [priority] varchar(max)   '$.priority',
        [name] varchar(max)   '$.name',
        [description] varchar(max)   '$.description',
        [description_purchase] varchar(max)   '$.description_purchase',
        [description_sale] varchar(max)   '$.description_sale',
        [product_properties] varchar(max)   '$.product_properties',
        [list_price] decimal(38,10) '$.list_price',
        [volume] decimal(38,10) '$.volume',
        [weight] decimal(38,10) '$.weight',
        [sale_ok] bit            '$.sale_ok',
        [purchase_ok] bit            '$.purchase_ok',
        [active] bit            '$.active',
        [can_image_1024_be_zoomed] bit            '$.can_image_1024_be_zoomed',
        [has_configurable_attributes] bit            '$.has_configurable_attributes',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [can_be_expensed] bit            '$.can_be_expensed',
        [sale_delay] int            '$.sale_delay',
        [tracking] varchar(max)   '$.tracking',
        [description_picking] varchar(max)   '$.description_picking',
        [description_pickingout] varchar(max)   '$.description_pickingout',
        [description_pickingin] varchar(max)   '$.description_pickingin',
        [purchase_method] varchar(max)   '$.purchase_method',
        [purchase_line_warn] varchar(max)   '$.purchase_line_warn',
        [purchase_line_warn_msg] varchar(max)   '$.purchase_line_warn_msg',
        [service_type] varchar(max)   '$.service_type',
        [sale_line_warn] varchar(max)   '$.sale_line_warn',
        [expense_policy] varchar(max)   '$.expense_policy',
        [invoice_policy] varchar(max)   '$.invoice_policy',
        [sale_line_warn_msg] varchar(max)   '$.sale_line_warn_msg',
        [service_tracking] varchar(max)   '$.service_tracking',
        [service_upsell_threshold] float          '$.service_upsell_threshold',
        [name_sanitized] varchar(max)   '$.name_sanitized',
        [technician_user_id] int            '$.technician_user_id',
        [equipment_assign_to] varchar(max)   '$.equipment_assign_to',
        [split_method_landed_cost] varchar(max)   '$.split_method_landed_cost',
        [landed_cost_ok] bit            '$.landed_cost_ok',
        [stowage_volume] decimal(38,10) '$.stowage_volume',
        [concat_dimension_in_name] bit            '$.concat_dimension_in_name',
        [length] float          '$.length',
        [width] float          '$.width',
        [height] float          '$.height',
        [stowage_factor] float          '$.stowage_factor',
        [secondary_uom] int            '$.secondary_uom',
        [is_secondary_unit] bit            '$.is_secondary_unit',
        [uom_match] bit            '$.uom_match',
        [factor] decimal(38,10) '$.factor',
        [allow_negative_stock] bit            '$.allow_negative_stock',
        [is_fuel] bit            '$.is_fuel',
        [is_vehicle_part] bit            '$.is_vehicle_part',
        [available_in_pos] bit            '$.available_in_pos',
        [to_weight] bit            '$.to_weight',
        [is_pos_bom] bit            '$.is_pos_bom',
        [lot_sequence_id] int            '$.lot_sequence_id',
        [lot_sequence_padding] int            '$.lot_sequence_padding',
        [lot_sequence_prefix] varchar(max)   '$.lot_sequence_prefix',
        [auto_create_lot] bit            '$.auto_create_lot'
    ) as j
)

select * from cdc_keyed
