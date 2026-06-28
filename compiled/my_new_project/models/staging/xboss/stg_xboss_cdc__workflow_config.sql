


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'workflow_config'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__workflow_config])
    
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
        [model_id] int            '$.model_id',
        [category_id] int            '$.category_id',
        [workflow_id] int            '$.workflow_id',
        [sequence] int            '$.sequence',
        [company_id] int            '$.company_id',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [code] varchar(max)   '$.code',
        [type] varchar(max)   '$.type',
        [description] varchar(max)   '$.description',
        [domain] varchar(max)   '$.domain',
        [active] bit            '$.active',
        [isActive] bit            '$.isActive',
        [allow_create] bit            '$.allow_create',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [paid_by] varchar(max)   '$.paid_by',
        [main_attachment_id] int            '$.main_attachment_id',
        [parent_id] int            '$.parent_id',
        [reimbursement_account_id] int            '$.reimbursement_account_id',
        [minimum_payment_cycle_days] int            '$.minimum_payment_cycle_days',
        [auto_post_entries] bit            '$.auto_post_entries',
        [allow_direct_payable_payment] bit            '$.allow_direct_payable_payment',
        [field_wf_id] int            '$.field_wf_id',
        [automatic] bit            '$.automatic',
        [filter_account_prefix] varchar(max)   '$.filter_account_prefix',
        [allow_multi_request] bit            '$.allow_multi_request',
        [allow_over_origin_amount] bit            '$.allow_over_origin_amount',
        [partner_id] int            '$.partner_id',
        [default_journal_id] int            '$.default_journal_id',
        [outstanding_same_reference] bit            '$.outstanding_same_reference',
        [user_manual_url] varchar(max)   '$.user_manual_url',
        [lock_ref_amount] bit            '$.lock_ref_amount',
        [number_of_signs_per_row] varchar(max)   '$.number_of_signs_per_row',
        [expense_has_invoice] bit            '$.expense_has_invoice',
        [position_page] int            '$.position_page',
        [allow_zero_price_unit] bit            '$.allow_zero_price_unit',
        [invalid_journal_id] int            '$.invalid_journal_id',
        [transfer_partner_mode] varchar(max)   '$.transfer_partner_mode',
        [allow_no_payment] bit            '$.allow_no_payment',
        [workflow_mode] varchar(max)   '$.workflow_mode',
        [allow_reimbursement_exceeding_advance] bit            '$.allow_reimbursement_exceeding_advance',
        [outstanding_same_beneficiary] bit            '$.outstanding_same_beneficiary',
        [purchase_journal_id] int            '$.purchase_journal_id',
        [is_joint_venture_agreement] bit            '$.is_joint_venture_agreement'
    ) as j
)

select * from cdc_keyed
