


with cdc_src as (

    select __dbz_operation, __dbz_timestamp, __dbz_lsn, record_data
    from [eh_xboss].[dbo].[cdc_events]
    where __dbz_table  = 'res_bank'
      and __dbz_schema = 'public'
    
      and __dbz_timestamp > (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[stg_xboss_cdc__res_bank])
    
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
        [state] int            '$.state',
        [country] int            '$.country',
        [create_uid] int            '$.create_uid',
        [write_uid] int            '$.write_uid',
        [name] varchar(max)   '$.name',
        [street] varchar(max)   '$.street',
        [street2] varchar(max)   '$.street2',
        [zip] varchar(max)   '$.zip',
        [city] varchar(max)   '$.city',
        [email] varchar(max)   '$.email',
        [phone] varchar(max)   '$.phone',
        [bic] varchar(max)   '$.bic',
        [active] bit            '$.active',
        [create_date] bigint         '$.create_date',
        [write_date] bigint         '$.write_date',
        [partner_id] int            '$.partner_id',
        [branch_name] varchar(max)   '$.branch_name',
        [swift_code] varchar(max)   '$.swift_code'
    ) as j
)

select * from cdc_keyed
