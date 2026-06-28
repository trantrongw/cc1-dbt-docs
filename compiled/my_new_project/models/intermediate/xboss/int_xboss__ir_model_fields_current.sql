

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__ir_model_fields]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__ir_model_fields_current])
    
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
        [relation_field_id],
        [model_id],
        [related_field_id],
        [size],
        [create_uid],
        [write_uid],
        [name],
        [complete_name],
        [model],
        [relation],
        [relation_field],
        [ttype],
        [related],
        [state],
        [on_delete],
        [domain],
        [relation_table],
        [column1],
        [column2],
        [depends],
        [currency_field],
        [field_description],
        [help],
        [compute],
        [copied],
        [required],
        [readonly],
        [index],
        [translate],
        [group_expand],
        [selectable],
        [store],
        [sanitize],
        [sanitize_overridable],
        [sanitize_tags],
        [sanitize_attributes],
        [sanitize_style],
        [sanitize_form],
        [strip_style],
        [strip_classes],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [tracking],
        [website_form_blacklisted],
        [serialization_field_id],
        [custom_tracking],
        [native_tracking],
        [trackable],
        [ai_domain],
        [system_prompt],
        [ai]
from ranked
where rn = 1