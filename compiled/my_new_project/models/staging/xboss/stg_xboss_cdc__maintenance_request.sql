


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'maintenance_request'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__maintenance_request])
    
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
        [company_id] int            '$.company_id',
        [owner_user_id] int            '$.owner_user_id',
        [category_id] int            '$.category_id',
        [equipment_id] int            '$.equipment_id',
        [user_id] int            '$.user_id',
        [stage_id] int            '$.stage_id',
        [color] int            '$.color',
        [maintenance_team_id] int            '$.maintenance_team_id',
        [repeat_interval] int            '$.repeat_interval',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [email_cc] varchar(max)   '$.email_cc',
        [name] varchar(max)   '$.name',
        [priority] varchar(max)   '$.priority',
        [kanban_state] varchar(max)   '$.kanban_state',
        [maintenance_type] varchar(max)   '$.maintenance_type',
        [instruction_type] varchar(max)   '$.instruction_type',
        [instruction_google_slide] varchar(max)   '$.instruction_google_slide',
        [repeat_unit] varchar(max)   '$.repeat_unit',
        [repeat_type] varchar(max)   '$.repeat_type',
        [request_date] int            '$.request_date',
        [close_date] int            '$.close_date',
        [repeat_until] int            '$.repeat_until',
        [description] varchar(max)   '$.description',
        [instruction_text] varchar(max)   '$.instruction_text',
        [archive] bit            '$.archive',
        [recurring_maintenance] bit            '$.recurring_maintenance',
        [schedule_date] bigint         '$.schedule_date',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [duration] float          '$.duration',
        [employee_id] int            '$.employee_id',
        [approval_id] int            '$.approval_id',
        [vehicle_id] int            '$.vehicle_id',
        [driver_id] int            '$.driver_id',
        [maintenance_vehicle_id] int            '$.maintenance_vehicle_id',
        [approval_user_id] int            '$.approval_user_id',
        [maintenance_schedule_type] varchar(max)   '$.maintenance_schedule_type',
        [recurring_type] varchar(max)   '$.recurring_type',
        [ref] varchar(max)   '$.ref',
        [request_status] varchar(max)   '$.request_status',
        [amount_budget] decimal(38,10) '$.amount_budget',
        [amount] decimal(38,10) '$.amount',
        [maintenance_km] float          '$.maintenance_km',
        [maintenance_time_operation] float          '$.maintenance_time_operation',
        [recurring_km] float          '$.recurring_km',
        [lot_id] int            '$.lot_id',
        [dest_location_id] int            '$.dest_location_id',
        [joborder_id] int            '$.joborder_id',
        [requisition_employee_id] int            '$.requisition_employee_id',
        [custom_project_id] int            '$.custom_project_id',
        [picking_type_id] int            '$.picking_type_id',
        [is_task] bit            '$.is_task',
        [is_requisition] bit            '$.is_requisition',
        [is_vehicle_maintenance] bit            '$.is_vehicle_maintenance',
        [approval_date] bigint         '$.approval_date',
        [schedule_line_id] int            '$.schedule_line_id',
        [maintenance_level_id] int            '$.maintenance_level_id',
        [cycle_number] int            '$.cycle_number',
        [current_value] varchar(max)   '$.current_value',
        [initial_value] varchar(max)   '$.initial_value',
        [maintenance_mode] varchar(max)   '$.maintenance_mode',
        [notes] varchar(max)   '$.notes',
        [alert_date] bigint         '$.alert_date',
        [completed_date] bigint         '$.completed_date',
        [property_id] int            '$.property_id',
        [invc_id] int            '$.invc_id',
        [account_id] int            '$.account_id',
        [tenant_id] int            '$.tenant_id',
        [date_invoice] int            '$.date_invoice',
        [renters_fault] bit            '$.renters_fault',
        [invc_check] bit            '$.invc_check',
        [is_in_progress] bit            '$.is_in_progress',
        [cost] float          '$.cost',
        [maintenance_classification] varchar(max)   '$.maintenance_classification'
    ) as j
)

select * from cdc_keyed
