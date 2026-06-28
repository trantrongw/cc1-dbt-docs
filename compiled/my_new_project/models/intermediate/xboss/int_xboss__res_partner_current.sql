

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__res_partner]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__res_partner_current])
    
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
        [company_id],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        [name],
        [title],
        [parent_id],
        [user_id],
        [state_id],
        [country_id],
        [industry_id],
        [color],
        [commercial_partner_id],
        [create_uid],
        [write_uid],
        [complete_name],
        [ref],
        [lang],
        [tz],
        [vat],
        [company_registry],
        [website],
        [function],
        [type],
        [street],
        [street2],
        [zip],
        [city],
        [email],
        [phone],
        [mobile],
        [commercial_company_name],
        [company_name],
        
DATEADD(DAY, [date], cast('1970-01-01' as date))
 as [date],
        [comment],
        [partner_latitude],
        [partner_longitude],
        [active],
        [employee],
        [is_company],
        [partner_share],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [message_bounce],
        [email_normalized],
        [signup_type],
        
DATEADD(MICROSECOND, [signup_expiration] % 1000000,
    DATEADD(SECOND, [signup_expiration] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [signup_expiration],
        [signup_token],
        [phone_sanitized],
        [plan_to_change_car],
        [plan_to_change_bike],
        
DATEADD(MICROSECOND, [calendar_last_notif_ack] % 1000000,
    DATEADD(SECOND, [calendar_last_notif_ack] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [calendar_last_notif_ack],
        [website_id],
        [is_published],
        [website_meta_og_img],
        [website_meta_title],
        [website_meta_description],
        [website_meta_keywords],
        [seo_name],
        [website_description],
        [website_short_description],
        
DATEADD(DAY, [date_localization], cast('1970-01-01' as date))
 as [date_localization],
        [supplier_rank],
        [customer_rank],
        [invoice_warn],
        [invoice_warn_msg],
        [debit_limit],
        
DATEADD(MICROSECOND, [last_time_entries_checked] % 1000000,
    DATEADD(SECOND, [last_time_entries_checked] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [last_time_entries_checked],
        [ubl_cii_format],
        [peppol_endpoint],
        [peppol_eas],
        [billing_type],
        [picking_warn],
        [picking_warn_msg],
        [fuel_card],
        [dyob],
        [mob],
        [yob],
        
DATEADD(DAY, [dob], cast('1970-01-01' as date))
 as [dob],
        [street_id],
        [district_id],
        [ward_id],
        [company_type],
        [contact_address],
        [citizen_identification],
        [identification_place],
        [represent],
        [sanitized_phone],
        [sanitized_mobile],
        [fax],
        [default_image_path],
        
DATEADD(DAY, [citizen_expiry_date], cast('1970-01-01' as date))
 as [citizen_expiry_date],
        
DATEADD(DAY, [birthday], cast('1970-01-01' as date))
 as [birthday],
        [commercial_transactions_ok],
        [is_employee_relative],
        [partner_type_id],
        [short_code],
        [buyer_id],
        [purchase_warn],
        [purchase_warn_msg],
        [driver_license_type],
        [current_vehicle_id],
        [current_vehicle_project_id],
        [identification_id],
        [driver_license],
        
DATEADD(DAY, [driver_license_issue_date], cast('1970-01-01' as date))
 as [driver_license_issue_date],
        
DATEADD(DAY, [driver_license_expire_date], cast('1970-01-01' as date))
 as [driver_license_expire_date],
        
DATEADD(DAY, [driver_contract_sn], cast('1970-01-01' as date))
 as [driver_contract_sn],
        
DATEADD(DAY, [vehicle_assign_date], cast('1970-01-01' as date))
 as [vehicle_assign_date],
        [synced],
        [mysign_id],
        [phone_extension],
        [facebook_url],
        [facebook_name],
        [linkedin_url],
        [linkedin_name],
        [zalo_url],
        
DATEADD(DAY, [citizen_issue_date], cast('1970-01-01' as date))
 as [citizen_issue_date],
        [team_id],
        [sale_warn],
        [sale_warn_msg],
        [failed_coordinate_filling_times],
        [customer_get_einvoice],
        [partner_gid],
        [additional_info],
        [occupation],
        [tenant],
        [agent],
        [is_property_owner],
        [einvoice_replacement_email],
        [contractor_rating_answer_id],
        [is_contractor],
        [rating_capacity_experience],
        [sinvoice_budget_relationship_unit_code],
        [vies_valid]
from ranked
where rn = 1