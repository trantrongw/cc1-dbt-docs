


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'construction_ipc_line'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__construction_ipc_line])
    
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
        [ipc_id] int            '$.ipc_id',
        [product_id] int            '$.product_id',
        [uom_id] int            '$.uom_id',
        [custom_task_id] int            '$.custom_task_id',
        [project_id] int            '$.project_id',
        [currency_id] int            '$.currency_id',
        [sequence] int            '$.sequence',
        [company_id] int            '$.company_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [description] varchar(max)   '$.description',
        [name] varchar(max)   '$.name',
        [display_type] varchar(max)   '$.display_type',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [quantity] decimal(38,10) '$.quantity',
        [unit_price] decimal(38,10) '$.unit_price',
        [total_amount] decimal(38,10) '$.total_amount',
        [invoice_line_id] int            '$.invoice_line_id',
        [sale_order_line_id] int            '$.sale_order_line_id',
        [purchase_order_line_id] int            '$.purchase_order_line_id',
        [completed_qty] float          '$.completed_qty',
        [remaining_qty] float          '$.remaining_qty',
        [delivered_qty] float          '$.delivered_qty',
        [invoice_qty] float          '$.invoice_qty',
        [planned_qty] float          '$.planned_qty',
        [billed_qty] float          '$.billed_qty',
        [purchase_qty] float          '$.purchase_qty',
        [received_qty] float          '$.received_qty',
        [pending_qty] float          '$.pending_qty',
        [approved_to_date_qty] float          '$.approved_to_date_qty',
        [level] varchar(max)   '$.level',
        [wbs_code] varchar(max)   '$.wbs_code',
        [wbs_sort_key] varchar(max)   '$.wbs_sort_key',
        [origin_uom_name] varchar(max)   '$.origin_uom_name',
        [note] varchar(max)   '$.note',
        [section_total] decimal(38,10) '$.section_total',
        [total_amount_untaxed] decimal(38,10) '$.total_amount_untaxed',
        [total_amount_tax] decimal(38,10) '$.total_amount_tax',
        [analytic_distribution] varchar(max)   '$.analytic_distribution'
    ) as j
)

select * from cdc_keyed
