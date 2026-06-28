


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'sale_order_line'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__sale_order_line])
    
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
        [order_id] int            '$.order_id',
        [sequence] int            '$.sequence',
        [company_id] int            '$.company_id',
        [currency_id] int            '$.currency_id',
        [order_partner_id] int            '$.order_partner_id',
        [salesman_id] int            '$.salesman_id',
        [product_id] int            '$.product_id',
        [product_uom] int            '$.product_uom',
        [product_packaging_id] int            '$.product_packaging_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [state] varchar(max)   '$.state',
        [display_type] varchar(max)   '$.display_type',
        [qty_delivered_method] varchar(max)   '$.qty_delivered_method',
        [invoice_status] varchar(max)   '$.invoice_status',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [name] varchar(max)   '$.name',
        [product_uom_qty] decimal(38,10) '$.product_uom_qty',
        [price_unit] decimal(38,10) '$.price_unit',
        [discount] decimal(38,10) '$.discount',
        [price_subtotal] decimal(38,10) '$.price_subtotal',
        [price_total] decimal(38,10) '$.price_total',
        [price_reduce_taxexcl] decimal(38,10) '$.price_reduce_taxexcl',
        [price_reduce_taxinc] decimal(38,10) '$.price_reduce_taxinc',
        [qty_delivered] decimal(38,10) '$.qty_delivered',
        [qty_invoiced] decimal(38,10) '$.qty_invoiced',
        [qty_to_invoice] decimal(38,10) '$.qty_to_invoice',
        [untaxed_amount_invoiced] decimal(38,10) '$.untaxed_amount_invoiced',
        [untaxed_amount_to_invoice] decimal(38,10) '$.untaxed_amount_to_invoice',
        [is_downpayment] bit            '$.is_downpayment',
        [is_expense] bit            '$.is_expense',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [price_tax] float          '$.price_tax',
        [product_packaging_qty] float          '$.product_packaging_qty',
        [customer_lead] float          '$.customer_lead',
        [route_id] int            '$.route_id',
        [event_id] int            '$.event_id',
        [event_ticket_id] int            '$.event_ticket_id',
        [is_service] bit            '$.is_service',
        [project_id] int            '$.project_id',
        [task_id] int            '$.task_id',
        [has_displayed_warning_upsell] bit            '$.has_displayed_warning_upsell',
        [remaining_hours] float          '$.remaining_hours',
        [amount_paid] decimal(38,10) '$.amount_paid',
        [amount_unpaid] decimal(38,10) '$.amount_unpaid',
        [inter_comp_purchase_order_line_id] int            '$.inter_comp_purchase_order_line_id',
        [manufacturere_id] int            '$.manufacturere_id',
        [secondary_uom] int            '$.secondary_uom',
        [secondary_qty] decimal(38,10) '$.secondary_qty',
        [section_total] decimal(38,10) '$.section_total',
        [complete_qty] float          '$.complete_qty',
        [remaining_qty] float          '$.remaining_qty',
        [brand_manufacturer_id] int            '$.brand_manufacturer_id',
        [reward_id] int            '$.reward_id',
        [coupon_id] int            '$.coupon_id',
        [reward_identifier_code] varchar(max)   '$.reward_identifier_code',
        [points_cost] float          '$.points_cost',
        [level] varchar(max)   '$.level',
        [wbs_code] varchar(max)   '$.wbs_code',
        [wbs_sort_key] varchar(max)   '$.wbs_sort_key',
        [origin_uom_name] varchar(max)   '$.origin_uom_name',
        [note] varchar(max)   '$.note',
        [blanket_order_line] int            '$.blanket_order_line',
        [property_id] int            '$.property_id',
        [is_property] bit            '$.is_property',
        [lot_name] varchar(max)   '$.lot_name'
    ) as j
)

select * from cdc_keyed
