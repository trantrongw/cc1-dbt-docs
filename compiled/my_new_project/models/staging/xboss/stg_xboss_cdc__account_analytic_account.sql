


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'account_analytic_account'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__account_analytic_account])
    
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
        [plan_id] int            '$.plan_id',
        [root_plan_id] int            '$.root_plan_id',
        [company_id] int            '$.company_id',
        [partner_id] int            '$.partner_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [code] varchar(max)   '$.code',
        [name] varchar(max)   '$.name',
        [active] bit            '$.active',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [issue_transfer_limit_employee_level] int            '$.issue_transfer_limit_employee_level',
        [department_id] int            '$.department_id',
        [total_progress_account] float          '$.total_progress_account',
        [amount_fee_paid] int            '$.amount_fee_paid',
        [manager_id] int            '$.manager_id',
        [property_id] int            '$.property_id',
        [tenant_id] int            '$.tenant_id',
        [contact_id] int            '$.contact_id',
        [acc_pay_dep_rec_id] int            '$.acc_pay_dep_rec_id',
        [acc_pay_dep_ret_id] int            '$.acc_pay_dep_ret_id',
        [rent_type_id] int            '$.rent_type_id',
        [invc_id] int            '$.invc_id',
        [doc_name] varchar(max)   '$.doc_name',
        [deposit_scheme_type] varchar(max)   '$.deposit_scheme_type',
        [state] varchar(max)   '$.state',
        [date] int            '$.date',
        [date_start] int            '$.date_start',
        [ten_date] int            '$.ten_date',
        [description] varchar(max)   '$.description',
        [duration_cover] varchar(max)   '$.duration_cover',
        [rent] decimal(38,10) '$.rent',
        [deposit] decimal(38,10) '$.deposit',
        [total_rent] decimal(38,10) '$.total_rent',
        [amount_return] decimal(38,10) '$.amount_return',
        [is_property] bit            '$.is_property',
        [rent_entry_chck] bit            '$.rent_entry_chck',
        [multi_prop] bit            '$.multi_prop',
        [penalty_a] bit            '$.penalty_a',
        [recurring] bit            '$.recurring',
        [tenancy_cancelled] bit            '$.tenancy_cancelled',
        [main_cost] float          '$.main_cost',
        [agent] int            '$.agent',
        [commission_type] varchar(max)   '$.commission_type',
        [commission] bit            '$.commission',
        [commission_create] bit            '$.commission_create',
        [fix_qty] float          '$.fix_qty',
        [fix_cost] float          '$.fix_cost',
        [property_owner_id] int            '$.property_owner_id',
        [is_landlord_rent] bit            '$.is_landlord_rent',
        [landlord_rent] float          '$.landlord_rent',
        [penalty_day] int            '$.penalty_day',
        [penalty] float          '$.penalty',
        [property_parent_id] int            '$.property_parent_id',
        [fee_type_id] int            '$.fee_type_id',
        [start_date_calculate_rent] int            '$.start_date_calculate_rent',
        [start_date_calculate_utility] int            '$.start_date_calculate_utility',
        [rent_payer_id] int            '$.rent_payer_id',
        [service_payer_id] int            '$.service_payer_id',
        [tenancy_parent_id] int            '$.tenancy_parent_id',
        [termination_date] int            '$.termination_date',
        [number_day_deadline_reminder] int            '$.number_day_deadline_reminder',
        [parent_id] int            '$.parent_id',
        [requisition_tender_id] int            '$.requisition_tender_id',
        [tender_stage_id] int            '$.tender_stage_id',
        [tender_plan_responsible_id] int            '$.tender_plan_responsible_id',
        [partner_address_id] int            '$.partner_address_id',
        [commercial_partner_id] int            '$.commercial_partner_id',
        [scheduled_bid_request_date] int            '$.scheduled_bid_request_date',
        [date_end] int            '$.date_end',
        [is_bid_selection_project] bit            '$.is_bid_selection_project',
        [scheduled_bid_selection_date] bigint         '$.scheduled_bid_selection_date',
        [number_duration] float          '$.number_duration',
        [job_cost_group_id] int            '$.job_cost_group_id',
        [spread_template_id] int            '$.spread_template_id'
    ) as j
)

select * from cdc_keyed
