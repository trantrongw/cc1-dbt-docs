

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__ir_model]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__ir_model_current])
    
),
ranked as (
    select *,
           ROW_NUMBER() OVER (PARTITION BY __id ORDER BY __dbz_timestamp DESC, __dbz_lsn DESC) as rn
    from staged
)
select
    __dbz_operation,
    __dbz_timestamp,
    __dbz_lsn,
    __id,
    case when __dbz_operation = 'd' then 1 else 0 end as __is_deleted,
    __dbz_timestamp                                    as __last_changed_at,
        [id],
        [create_uid],
        [write_uid],
        [model],
        [order],
        [state],
        [name],
        [info],
        [transient],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [allow_modify_master_data],
        [is_mail_thread],
        [is_mail_activity],
        [is_mail_blacklist],
        [website_form_default_field_id],
        [website_form_label],
        [website_form_key],
        [website_form_access],
        [automatic_custom_tracking_domain],
        [active_custom_tracking],
        [automatic_custom_tracking],
        [restrict_delete_attachment],
        [delete_attachment_domain]
from ranked
where rn = 1