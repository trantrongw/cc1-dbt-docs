


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'material_purchase_requisition_line'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__material_purchase_requisition_line])
    
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
        [requisition_id] int            '$.requisition_id',
        [product_id] int            '$.product_id',
        [uom] int            '$.uom',
        [company_id] int            '$.company_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [description] varchar(max)   '$.description',
        [requisition_type] varchar(max)   '$.requisition_type',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [qty] decimal(38,10) '$.qty',
        [custom_job_costing_id] int            '$.custom_job_costing_id',
        [custom_job_costing_line_id] int            '$.custom_job_costing_line_id',
        [highlight_color] varchar(max)   '$.highlight_color',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [brand_id] int            '$.brand_id',
        [manufacturere_id] int            '$.manufacturere_id',
        [price_unit] decimal(38,10) '$.price_unit',
        [price_total] decimal(38,10) '$.price_total',
        [secondary_uom_id] int            '$.secondary_uom_id',
        [product_secondary_qty] decimal(38,10) '$.product_secondary_qty',
        [barem_diff_qty] decimal(38,10) '$.barem_diff_qty',
        [already_purchase_requested] bit            '$.already_purchase_requested',
        [already_stock_requested] bit            '$.already_stock_requested',
        [cumulative_qty] float          '$.cumulative_qty',
        [product_categ_id] int            '$.product_categ_id',
        [state_purchase_order_not_draft] bit            '$.state_purchase_order_not_draft',
        [ordered_qty] decimal(38,10) '$.ordered_qty',
        [order_remaining_qty] decimal(38,10) '$.order_remaining_qty'
    ) as j
)

select * from cdc_keyed
