


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'sale_order'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__sale_order])
    
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
        [campaign_id] int            '$.campaign_id',
        [source_id] int            '$.source_id',
        [medium_id] int            '$.medium_id',
        [company_id] int            '$.company_id',
        [partner_id] int            '$.partner_id',
        [journal_id] int            '$.journal_id',
        [partner_invoice_id] int            '$.partner_invoice_id',
        [partner_shipping_id] int            '$.partner_shipping_id',
        [fiscal_position_id] int            '$.fiscal_position_id',
        [payment_term_id] int            '$.payment_term_id',
        [pricelist_id] int            '$.pricelist_id',
        [currency_id] int            '$.currency_id',
        [user_id] int            '$.user_id',
        [team_id] int            '$.team_id',
        [analytic_account_id] int            '$.analytic_account_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [access_token] varchar(max)   '$.access_token',
        [name] varchar(max)   '$.name',
        [state] varchar(max)   '$.state',
        [client_order_ref] varchar(max)   '$.client_order_ref',
        [origin] varchar(max)   '$.origin',
        [reference] varchar(max)   '$.reference',
        [signed_by] varchar(max)   '$.signed_by',
        [invoice_status] varchar(max)   '$.invoice_status',
        [validity_date] int            '$.validity_date',
        [note] varchar(max)   '$.note',
        [currency_rate] decimal(38,10) '$.currency_rate',
        [amount_untaxed] decimal(38,10) '$.amount_untaxed',
        [amount_tax] decimal(38,10) '$.amount_tax',
        [amount_total] decimal(38,10) '$.amount_total',
        [amount_to_invoice] decimal(38,10) '$.amount_to_invoice',
        [locked] bit            '$.locked',
        [require_signature] bit            '$.require_signature',
        [require_payment] bit            '$.require_payment',
        [create_date] bigint         '$.create_date',
        [commitment_date] bigint         '$.commitment_date',
        [date_order] bigint         '$.date_order',
        [signed_on] bigint         '$.signed_on',
        [write_date] bigint         '$.write_date',
        [prepayment_percent] float          '$.prepayment_percent',
        [pending_email_template_id] int            '$.pending_email_template_id',
        [sale_order_template_id] int            '$.sale_order_template_id',
        [incoterm] int            '$.incoterm',
        [warehouse_id] int            '$.warehouse_id',
        [procurement_group_id] int            '$.procurement_group_id',
        [incoterm_location] varchar(max)   '$.incoterm_location',
        [picking_policy] varchar(max)   '$.picking_policy',
        [delivery_status] varchar(max)   '$.delivery_status',
        [effective_date] bigint         '$.effective_date',
        [project_id] int            '$.project_id',
        [opportunity_id] int            '$.opportunity_id',
        [task_id] int            '$.task_id',
        [amount_invoice_paid] float          '$.amount_invoice_paid',
        [amount_residual] float          '$.amount_residual',
        [days_to_confirm] float          '$.days_to_confirm',
        [inter_comp_purchase_order_id] int            '$.inter_comp_purchase_order_id',
        [auto_generated] bit            '$.auto_generated',
        [advance_payment_link] int            '$.advance_payment_link',
        [contract_project_id] int            '$.contract_project_id',
        [contract_ref_no] varchar(max)   '$.contract_ref_no',
        [deduct_terms] varchar(max)   '$.deduct_terms',
        [contract_start_date] int            '$.contract_start_date',
        [contract_end_date] int            '$.contract_end_date',
        [narration] varchar(max)   '$.narration',
        [warn_msg] varchar(max)   '$.warn_msg',
        [is_customer_contract] bit            '$.is_customer_contract',
        [custom_product_type_check] bit            '$.custom_product_type_check',
        [advance_payment_amount] float          '$.advance_payment_amount',
        [advance_pay_percentage] float          '$.advance_pay_percentage',
        [penalty_amount] float          '$.penalty_amount',
        [advance_deduct_percentage] float          '$.advance_deduct_percentage',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [x_workflow_state] varchar(max)   '$.x_workflow_state',
        [x_workflow_approve_user] varchar(max)   '$.x_workflow_approve_user',
        [x_workflow_id] int            '$.x_workflow_id',
        [x_workflow_state_date] bigint         '$.x_workflow_state_date',
        [inspection_job_card_id] int            '$.inspection_job_card_id',
        [repair_job_card_id] int            '$.repair_job_card_id',
        [amount_unpaid] decimal(38,10) '$.amount_unpaid',
        [is_property] bit            '$.is_property',
        [contract_type_id] int            '$.contract_type_id',
        [construction_item] varchar(max)   '$.construction_item',
        [construction_package] varchar(max)   '$.construction_package',
        [x_workflow_stage_id] int            '$.x_workflow_stage_id',
        [x_workflow_update_user_id] int            '$.x_workflow_update_user_id',
        [x_workflow_responsible_user_id] int            '$.x_workflow_responsible_user_id',
        [x_workflow_config_id] int            '$.x_workflow_config_id',
        [is_joint_venture_agreement] bit            '$.is_joint_venture_agreement'
    ) as j
)

select * from cdc_keyed
