


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'purchase_order_line'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__purchase_order_line])
    
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
        [product_uom] int            '$.product_uom',
        [product_id] int            '$.product_id',
        [order_id] int            '$.order_id',
        [company_id] int            '$.company_id',
        [partner_id] int            '$.partner_id',
        [currency_id] int            '$.currency_id',
        [product_packaging_id] int            '$.product_packaging_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [state] varchar(max)   '$.state',
        [qty_received_method] varchar(max)   '$.qty_received_method',
        [display_type] varchar(max)   '$.display_type',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [name] varchar(max)   '$.name',
        [product_qty] decimal(38,10) '$.product_qty',
        [discount] decimal(38,10) '$.discount',
        [price_unit] decimal(38,10) '$.price_unit',
        [price_subtotal] decimal(38,10) '$.price_subtotal',
        [price_total] decimal(38,10) '$.price_total',
        [qty_invoiced] decimal(38,10) '$.qty_invoiced',
        [qty_received] decimal(38,10) '$.qty_received',
        [qty_received_manual] decimal(38,10) '$.qty_received_manual',
        [qty_to_invoice] decimal(38,10) '$.qty_to_invoice',
        [date_planned] bigint         '$.date_planned',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [product_uom_qty] float          '$.product_uom_qty',
        [price_tax] decimal(38,10) '$.price_tax',
        [product_packaging_qty] float          '$.product_packaging_qty',
        [orderpoint_id] int            '$.orderpoint_id',
        [product_description_variants] varchar(max)   '$.product_description_variants',
        [propagate_cancel] bit            '$.propagate_cancel',
        [custom_requisition_line_id] int            '$.custom_requisition_line_id',
        [job_cost_id] int            '$.job_cost_id',
        [job_cost_line_id] int            '$.job_cost_line_id',
        [sale_order_id] int            '$.sale_order_id',
        [sale_line_id] int            '$.sale_line_id',
        [analytic_json] varchar(max)   '$.analytic_json',
        [sequence_edit] int            '$.sequence_edit',
        [inter_comp_sale_order_line_id] int            '$.inter_comp_sale_order_line_id',
        [manufacturere_id] int            '$.manufacturere_id',
        [secondary_uom] int            '$.secondary_uom',
        [secondary_qty] decimal(38,10) '$.secondary_qty',
        [section_total] decimal(38,10) '$.section_total',
        [complete_qty] decimal(38,10) '$.complete_qty',
        [remaining_qty] decimal(38,10) '$.remaining_qty',
        [highlight_color] varchar(max)   '$.highlight_color',
        [brand_manufacturer_id] int            '$.brand_manufacturer_id',
        [level] varchar(max)   '$.level',
        [wbs_code] varchar(max)   '$.wbs_code',
        [wbs_sort_key] varchar(max)   '$.wbs_sort_key',
        [origin_uom_name] varchar(max)   '$.origin_uom_name',
        [note] varchar(max)   '$.note',
        [barem_diff_line_id] int            '$.barem_diff_line_id',
        [requisition_line_id] int            '$.requisition_line_id',
        [procurement_type] varchar(max)   '$.procurement_type',
        [lot_name] varchar(max)   '$.lot_name'
    ) as j
)

select * from cdc_keyed
