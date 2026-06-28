


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'material_purchase_requisition'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__material_purchase_requisition])
    
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
        [department_id] int            '$.department_id',
        [employee_id] int            '$.employee_id',
        [approve_manager_id] int            '$.approve_manager_id',
        [reject_manager_id] int            '$.reject_manager_id',
        [approve_employee_id] int            '$.approve_employee_id',
        [reject_employee_id] int            '$.reject_employee_id',
        [company_id] int            '$.company_id',
        [location_id] int            '$.location_id',
        [analytic_account_id] int            '$.analytic_account_id',
        [dest_location_id] int            '$.dest_location_id',
        [delivery_picking_id] int            '$.delivery_picking_id',
        [requisiton_responsible_id] int            '$.requisiton_responsible_id',
        [employee_confirm_id] int            '$.employee_confirm_id',
        [custom_picking_type_id] int            '$.custom_picking_type_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [access_token] varchar(max)   '$.access_token',
        [name] varchar(max)   '$.name',
        [state] varchar(max)   '$.state',
        [request_date] int            '$.request_date',
        [date_end] int            '$.date_end',
        [date_done] int            '$.date_done',
        [managerapp_date] int            '$.managerapp_date',
        [manareject_date] int            '$.manareject_date',
        [userreject_date] int            '$.userreject_date',
        [userrapp_date] int            '$.userrapp_date',
        [receive_date] int            '$.receive_date',
        [confirm_date] int            '$.confirm_date',
        [reason] varchar(max)   '$.reason',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [task_id] int            '$.task_id',
        [task_user_id] int            '$.task_user_id',
        [project_id] int            '$.project_id',
        [purchase_order_id] int            '$.purchase_order_id',
        [equipment_machine_total] decimal(38,10) '$.equipment_machine_total',
        [worker_resource_total] decimal(38,10) '$.worker_resource_total',
        [work_cost_package_total] decimal(38,10) '$.work_cost_package_total',
        [subcontract_total] decimal(38,10) '$.subcontract_total',
        [request_classification] varchar(max)   '$.request_classification',
        [note] varchar(max)   '$.note',
        [maintenance_request_id] int            '$.maintenance_request_id',
        [currency_id] int            '$.currency_id',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [x_workflow_state] varchar(max)   '$.x_workflow_state',
        [x_workflow_approve_user] varchar(max)   '$.x_workflow_approve_user',
        [x_workflow_id] int            '$.x_workflow_id',
        [x_workflow_state_date] bigint         '$.x_workflow_state_date',
        [source_document] varchar(max)   '$.source_document',
        [create_from_jcs] bit            '$.create_from_jcs',
        [employee_advance_count] int            '$.employee_advance_count',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [partner_id] int            '$.partner_id',
        [business_type] varchar(max)   '$.business_type',
        [already_purchase_requested] bit            '$.already_purchase_requested',
        [already_stock_requested] bit            '$.already_stock_requested',
        [submission_date] bigint         '$.submission_date',
        [job_cost_sheet] int            '$.job_cost_sheet',
        [procurement_type] varchar(max)   '$.procurement_type',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id'
    ) as j
)

select * from cdc_keyed
