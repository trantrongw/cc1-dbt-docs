


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'account_journal'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__account_journal])
    
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
        [default_account_id] int            '$.default_account_id',
        [suspense_account_id] int            '$.suspense_account_id',
        [sequence] int            '$.sequence',
        [currency_id] int            '$.currency_id',
        [company_id] int            '$.company_id',
        [profit_account_id] int            '$.profit_account_id',
        [loss_account_id] int            '$.loss_account_id',
        [bank_account_id] int            '$.bank_account_id',
        [sale_activity_type_id] int            '$.sale_activity_type_id',
        [sale_activity_user_id] int            '$.sale_activity_user_id',
        [secure_sequence_id] int            '$.secure_sequence_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [color] int            '$.color',
        [access_token] varchar(max)   '$.access_token',
        [code] varchar(max)   '$.code',
        [type] varchar(max)   '$.type',
        [invoice_reference_type] varchar(max)   '$.invoice_reference_type',
        [invoice_reference_model] varchar(max)   '$.invoice_reference_model',
        [bank_statements_source] varchar(max)   '$.bank_statements_source',
        [name] varchar(max)   '$.name',
        [sequence_override_regex] varchar(max)   '$.sequence_override_regex',
        [sale_activity_note] varchar(max)   '$.sale_activity_note',
        [active] bit            '$.active',
        [restrict_mode_hash_table] bit            '$.restrict_mode_hash_table',
        [refund_sequence] bit            '$.refund_sequence',
        [payment_sequence] bit            '$.payment_sequence',
        [show_on_dashboard] bit            '$.show_on_dashboard',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [is_advance_journal] bit            '$.is_advance_journal',
        [swift_bic_bank_code] varchar(max)   '$.swift_bic_bank_code',
        [is_opening] bit            '$.is_opening',
        [sequence_id] int            '$.sequence_id',
        [refund_sequence_id] int            '$.refund_sequence_id',
        [has_sequence_holes] bit            '$.has_sequence_holes',
        [account_einvoice_serial_id] int            '$.account_einvoice_serial_id',
        [account_einvoice_template_id] int            '$.account_einvoice_template_id',
        [account_einvoice_type_id] int            '$.account_einvoice_type_id',
        [einvoice_item_name] varchar(max)   '$.einvoice_item_name',
        [einvoice_item_name_new_line_replacement] varchar(max)   '$.einvoice_item_name_new_line_replacement',
        [einvoice_send_mail_option] varchar(max)   '$.einvoice_send_mail_option',
        [einvoice_credit_note_option] varchar(max)   '$.einvoice_credit_note_option',
        [einvoice_price_unit_discount_computation] varchar(max)   '$.einvoice_price_unit_discount_computation',
        [send_mail_einvoice_disabled] bit            '$.send_mail_einvoice_disabled',
        [einvoice_display_bank_account] bit            '$.einvoice_display_bank_account',
        [einvoice_required_date_invoice] bit            '$.einvoice_required_date_invoice',
        [sinvoice_sellerinfo] bit            '$.sinvoice_sellerinfo',
        [einvoice_pos_issue_now] bit            '$.einvoice_pos_issue_now',
        [sinvoice_exclude_qty_unit_price] bit            '$.sinvoice_exclude_qty_unit_price',
        [sinvoice_discount_only_display_total] bit            '$.sinvoice_discount_only_display_total',
        [bank_account_partner_id] int            '$.bank_account_partner_id',
        [custom_bank_id] int            '$.custom_bank_id',
        [is_loan_journal] bit            '$.is_loan_journal',
        [allow_enforce_analytic] bit            '$.allow_enforce_analytic'
    ) as j
)

select * from cdc_keyed
