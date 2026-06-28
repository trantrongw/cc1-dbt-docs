


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'project_project'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__project_project])
    
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
        [alias_id] int            '$.alias_id',
        [sequence] int            '$.sequence',
        [partner_id] int            '$.partner_id',
        [company_id] int            '$.company_id',
        [analytic_account_id] int            '$.analytic_account_id',
        [color] int            '$.color',
        [user_id] int            '$.user_id',
        [stage_id] int            '$.stage_id',
        [last_update_id] int            '$.last_update_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [access_token] varchar(max)   '$.access_token',
        [privacy_visibility] varchar(max)   '$.privacy_visibility',
        [rating_status] varchar(max)   '$.rating_status',
        [rating_status_period] varchar(max)   '$.rating_status_period',
        [last_update_status] varchar(max)   '$.last_update_status',
        [date_start] int            '$.date_start',
        [date] int            '$.date',
        [name] varchar(max)   '$.name',
        [label_tasks] varchar(max)   '$.label_tasks',
        [task_properties_definition] varchar(max)   '$.task_properties_definition',
        [description] varchar(max)   '$.description',
        [active] bit            '$.active',
        [allow_task_dependencies] bit            '$.allow_task_dependencies',
        [allow_milestones] bit            '$.allow_milestones',
        [rating_active] bit            '$.rating_active',
        [rating_request_deadline] bigint         '$.rating_request_deadline',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [allow_timesheets] bit            '$.allow_timesheets',
        [allocated_hours] float          '$.allocated_hours',
        [label_issues] varchar(max)   '$.label_issues',
        [use_issues] bit            '$.use_issues',
        [log_assignee] varchar(max)   '$.log_assignee',
        [stage_sequence_create] int            '$.stage_sequence_create',
        [due_warning] int            '$.due_warning',
        [project_type] varchar(max)   '$.project_type',
        [bryntum_auto_scheduling] bit            '$.bryntum_auto_scheduling',
        [bryntum_user_assignment] bit            '$.bryntum_user_assignment',
        [project_start_date] bigint         '$.project_start_date',
        [apply_default_task_analytic_from_project] bit            '$.apply_default_task_analytic_from_project',
        [issue_sequence_rule_id] int            '$.issue_sequence_rule_id',
        [location_id] int            '$.location_id',
        [type_of_construction] varchar(max)   '$.type_of_construction',
        [sale_line_id] int            '$.sale_line_id',
        [allow_billable] bit            '$.allow_billable',
        [timesheet_product_id] int            '$.timesheet_product_id',
        [billing_type] varchar(max)   '$.billing_type',
        [project_category_id] int            '$.project_category_id',
        [department_id] int            '$.department_id',
        [custom_retention_percent] float          '$.custom_retention_percent',
        [business_unit_id] int            '$.business_unit_id',
        [x_workspace_id] int            '$.x_workspace_id',
        [project_code] varchar(max)   '$.project_code',
        [is_manage_with_gantt] bit            '$.is_manage_with_gantt',
        [is_action_plan] bit            '$.is_action_plan',
        [resource_calendar_id] int            '$.resource_calendar_id',
        [project_department] varchar(max)   '$.project_department'
    ) as j
)

select * from cdc_keyed
