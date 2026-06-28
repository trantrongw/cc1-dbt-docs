


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'account_payment'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__account_payment])
    
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
        [message_main_attachment_id] int            '$.message_main_attachment_id',
        [move_id] int            '$.move_id',
        [partner_bank_id] int            '$.partner_bank_id',
        [paired_internal_transfer_payment_id] int            '$.paired_internal_transfer_payment_id',
        [payment_method_line_id] int            '$.payment_method_line_id',
        [payment_method_id] int            '$.payment_method_id',
        [currency_id] int            '$.currency_id',
        [partner_id] int            '$.partner_id',
        [outstanding_account_id] int            '$.outstanding_account_id',
        [destination_account_id] int            '$.destination_account_id',
        [destination_journal_id] int            '$.destination_journal_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [payment_type] varchar(max)   '$.payment_type',
        [partner_type] varchar(max)   '$.partner_type',
        [payment_reference] varchar(max)   '$.payment_reference',
        [amount] decimal(38,10) '$.amount',
        [amount_company_currency_signed] decimal(38,10) '$.amount_company_currency_signed',
        [is_reconciled] bit            '$.is_reconciled',
        [is_matched] bit            '$.is_matched',
        [is_internal_transfer] bit            '$.is_internal_transfer',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [payment_transaction_id] int            '$.payment_transaction_id',
        [payment_token_id] int            '$.payment_token_id',
        [source_payment_id] int            '$.source_payment_id',
        [employee_id] int            '$.employee_id',
        [no_of_origin] varchar(max)   '$.no_of_origin',
        [recipient_payer] varchar(max)   '$.recipient_payer',
        [employee_advance_id] int            '$.employee_advance_id',
        [employee_advance_reconcile_id] int            '$.employee_advance_reconcile_id',
        [payment_type_line_id] int            '$.payment_type_line_id',
        [payment_type_id] int            '$.payment_type_id',
        [ref] varchar(max)   '$.ref',
        [comment] varchar(max)   '$.comment',
        [sale_id] int            '$.sale_id',
        [purchase_id] int            '$.purchase_id',
        [approval_ref] varchar(max)   '$.approval_ref',
        [is_request_ready] bit            '$.is_request_ready',
        [suggest_lines] bit            '$.suggest_lines',
        [loan_borrow_order_id] int            '$.loan_borrow_order_id',
        [loan_lend_order_id] int            '$.loan_lend_order_id',
        [analytic_distribution] varchar(max)   '$.analytic_distribution',
        [requisition_id] int            '$.requisition_id',
        [pos_payment_method_id] int            '$.pos_payment_method_id',
        [force_outstanding_account_id] int            '$.force_outstanding_account_id',
        [pos_session_id] int            '$.pos_session_id',
        [pos_order_id] int            '$.pos_order_id',
        [force_pass_unique_ref] bit            '$.force_pass_unique_ref',
        [tenancy_id] int            '$.tenancy_id',
        [property_id] int            '$.property_id',
        [is_linked_apr] bit            '$.is_linked_apr',
        [beneficiary_id] int            '$.beneficiary_id',
        [beneficiary_bank_id] int            '$.beneficiary_bank_id',
        [is_alternative_beneficiary] bit            '$.is_alternative_beneficiary',
        [is_internal_direct] bit            '$.is_internal_direct',
        [beneficiary_address] varchar(max)   '$.beneficiary_address',
        [disbursement_code] varchar(max)   '$.disbursement_code',
        [manual_currency_rate] decimal(38,10) '$.manual_currency_rate',
        [manual_currency_rate_active] bit            '$.manual_currency_rate_active'
    ) as j
)

select * from cdc_keyed
