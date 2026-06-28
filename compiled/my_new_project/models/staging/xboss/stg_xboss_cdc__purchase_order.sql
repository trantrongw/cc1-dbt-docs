


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'purchase_order'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__purchase_order])
    
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
        [partner_id] int            '$.partner_id',
        [dest_address_id] int            '$.dest_address_id',
        [currency_id] int            '$.currency_id',
        [invoice_count] int            '$.invoice_count',
        [fiscal_position_id] int            '$.fiscal_position_id',
        [payment_term_id] int            '$.payment_term_id',
        [incoterm_id] int            '$.incoterm_id',
        [user_id] int            '$.user_id',
        [company_id] int            '$.company_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [access_token] varchar(max)   '$.access_token',
        [name] varchar(max)   '$.name',
        [priority] varchar(max)   '$.priority',
        [origin] varchar(max)   '$.origin',
        [partner_ref] varchar(max)   '$.partner_ref',
        [state] varchar(max)   '$.state',
        [invoice_status] varchar(max)   '$.invoice_status',
        [notes] varchar(max)   '$.notes',
        [amount_untaxed] decimal(38,10) '$.amount_untaxed',
        [amount_tax] decimal(38,10) '$.amount_tax',
        [amount_total] decimal(38,10) '$.amount_total',
        [mail_reminder_confirmed] bit            '$.mail_reminder_confirmed',
        [mail_reception_confirmed] bit            '$.mail_reception_confirmed',
        [date_order] bigint         '$.date_order',
        [date_approve] bigint         '$.date_approve',
        [date_planned] bigint         '$.date_planned',
        [date_calendar_start] bigint         '$.date_calendar_start',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [currency_rate] float          '$.currency_rate',
        [request_id] int            '$.request_id',
        [picking_type_id] int            '$.picking_type_id',
        [group_id] int            '$.group_id',
        [incoterm_location] varchar(max)   '$.incoterm_location',
        [receipt_status] varchar(max)   '$.receipt_status',
        [effective_date] bigint         '$.effective_date',
        [custom_requisition_id] int            '$.custom_requisition_id',
        [picking_id] int            '$.picking_id',
        [sh_amount_resisual] float          '$.sh_amount_resisual',
        [subcontractor_id] int            '$.subcontractor_id',
        [inter_comp_sale_order_id] int            '$.inter_comp_sale_order_id',
        [auto_generated] bit            '$.auto_generated',
        [requisition_id] int            '$.requisition_id',
        [purchase_group_id] int            '$.purchase_group_id',
        [custom_construction_ipc_id] int            '$.custom_construction_ipc_id',
        [advance_payment_link] int            '$.advance_payment_link',
        [contract_project_id] int            '$.contract_project_id',
        [original_po_id] int            '$.original_po_id',
        [contract_ref_no] varchar(max)   '$.contract_ref_no',
        [deduct_terms] varchar(max)   '$.deduct_terms',
        [contract_start_date] int            '$.contract_start_date',
        [contract_end_date] int            '$.contract_end_date',
        [narration] varchar(max)   '$.narration',
        [is_sub_contract] bit            '$.is_sub_contract',
        [advance_payment_amount] float          '$.advance_payment_amount',
        [advance_pay_percentage] float          '$.advance_pay_percentage',
        [penalty_amount] float          '$.penalty_amount',
        [advance_deduct_percentage] float          '$.advance_deduct_percentage',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [contract_state] varchar(max)   '$.contract_state',
        [contract_date] int            '$.contract_date',
        [x_workflow_state] varchar(max)   '$.x_workflow_state',
        [x_workflow_approve_user] varchar(max)   '$.x_workflow_approve_user',
        [x_workflow_id] int            '$.x_workflow_id',
        [x_workflow_state_date] bigint         '$.x_workflow_state_date',
        [appendix_reference_number] varchar(max)   '$.appendix_reference_number',
        [appendix_status] varchar(max)   '$.appendix_status',
        [appendix_date] int            '$.appendix_date',
        [appendix_start_date] int            '$.appendix_start_date',
        [appendix_end_date] int            '$.appendix_end_date',
        [is_ready_apr] bit            '$.is_ready_apr',
        [contractor_rating_answer_id] int            '$.contractor_rating_answer_id',
        [requisition_analytic_id] int            '$.requisition_analytic_id',
        [analytic_account_id] int            '$.analytic_account_id',
        [requisition_analytic_group_id] int            '$.requisition_analytic_group_id',
        [is_tender] bit            '$.is_tender',
        [bid_selected] bit            '$.bid_selected',
        [has_negotiate_price] bit            '$.has_negotiate_price',
        [latest_bid_price_time] bigint         '$.latest_bid_price_time',
        [rating_capacity_experience] float          '$.rating_capacity_experience',
        [rating_technical] float          '$.rating_technical',
        [rating_contract_responsiveness] float          '$.rating_contract_responsiveness',
        [initial_bid_price] float          '$.initial_bid_price',
        [business_type] varchar(max)   '$.business_type',
        [has_service_product] bit            '$.has_service_product',
        [procurement_type] varchar(max)   '$.procurement_type',
        [journal_id] int            '$.journal_id',
        [is_linked_apr] bit            '$.is_linked_apr',
        [note_template_id] int            '$.note_template_id',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [construction_package] varchar(max)   '$.construction_package',
        [contract_type_id] int            '$.contract_type_id',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id',
        [x_workflow_config_id] int            '$.x_workflow_config_id',
        [foreign_trade] bit            '$.foreign_trade',
        [main_attachment_id] int            '$.main_attachment_id'
    ) as j
)

select * from cdc_keyed
