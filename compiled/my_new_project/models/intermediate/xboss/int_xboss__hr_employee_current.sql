

with staged as (
    select *
    from [wh_core].[cc1].[stg_xboss_cdc__hr_employee]
    
      where __dbz_timestamp >= (select COALESCE(MAX(__dbz_timestamp), cast('1970-01-01' as datetime2(6))) from [wh_core].[cc1].[int_xboss__hr_employee_current])
    
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
        [resource_id],
        [company_id],
        [resource_calendar_id],
        [message_main_attachment_id],
        [color],
        [department_id],
        [job_id],
        [address_id],
        [work_contact_id],
        [work_location_id],
        [user_id],
        [parent_id],
        [coach_id],
        [private_state_id],
        [private_country_id],
        [country_id],
        [children],
        [country_of_birth],
        [bank_account_id],
        [km_home_work],
        [departure_reason_id],
        [create_uid],
        [write_uid],
        [name],
        [job_title],
        [work_phone],
        [mobile_phone],
        [work_email],
        [private_street],
        [private_street2],
        [private_city],
        [private_zip],
        [private_phone],
        [private_email],
        [lang],
        [gender],
        [marital],
        [spouse_complete_name],
        [place_of_birth],
        [ssnid],
        [sinid],
        [identification_id],
        [passport_id],
        [permit_no],
        [visa_no],
        [certificate],
        [study_field],
        [study_school],
        [emergency_contact],
        [emergency_phone],
        [employee_type],
        [barcode],
        [pin],
        [private_car_plate],
        
DATEADD(DAY, [spouse_birthdate], cast('1970-01-01' as date))
 as [spouse_birthdate],
        
DATEADD(DAY, [birthday], cast('1970-01-01' as date))
 as [birthday],
        
DATEADD(DAY, [visa_expire], cast('1970-01-01' as date))
 as [visa_expire],
        
DATEADD(DAY, [work_permit_expiration_date], cast('1970-01-01' as date))
 as [work_permit_expiration_date],
        
DATEADD(DAY, [departure_date], cast('1970-01-01' as date))
 as [departure_date],
        [employee_properties],
        [additional_note],
        [notes],
        [departure_description],
        [active],
        [work_permit_scheduled_activity],
        
DATEADD(MICROSECOND, [create_date] % 1000000,
    DATEADD(SECOND, [create_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [create_date],
        
DATEADD(MICROSECOND, [write_date] % 1000000,
    DATEADD(SECOND, [write_date] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [write_date],
        [vat],
        [place_of_origin],
        [mobility_card],
        [hourly_cost],
        [x_code],
        [expense_manager_id],
        
DATEADD(DAY, [start_working_date], cast('1970-01-01' as date))
 as [start_working_date],
        [grade_id],
        [role_id],
        [rank_id],
        [next_rank_id],
        [job_position_skills_required],
        [code],
        [annual_leave_days],
        [attendance_manager_id],
        [last_attendance_id],
        
DATEADD(MICROSECOND, [last_check_in] % 1000000,
    DATEADD(SECOND, [last_check_in] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [last_check_in],
        
DATEADD(MICROSECOND, [last_check_out] % 1000000,
    DATEADD(SECOND, [last_check_out] / 1000000,
        cast('1970-01-01' as datetime2(6))))
 as [last_check_out],
        [contract_id],
        [vehicle],
        
DATEADD(DAY, [first_contract_date], cast('1970-01-01' as date))
 as [first_contract_date],
        [contract_warning],
        [leave_manager_id],
        [other_dependant],
        [total_dependant],
        [emergency_relation_type],
        [religion_id],
        [ethnic_id],
        [permanent_country_id],
        [permanent_state_id],
        [permanent_district_id],
        [permanent_ward_id],
        [temporary_country_id],
        [temporary_state_id],
        [temporary_district_id],
        [temporary_ward_id],
        [permanent_street],
        [temporary_street],
        [insurance_health_code],
        [identification_place],
        [passport_place],
        
DATEADD(DAY, [social_insurance_date], cast('1970-01-01' as date))
 as [social_insurance_date],
        
DATEADD(DAY, [health_insurance_date], cast('1970-01-01' as date))
 as [health_insurance_date],
        
DATEADD(DAY, [join_union_date], cast('1970-01-01' as date))
 as [join_union_date],
        
DATEADD(DAY, [deduction_itself_date], cast('1970-01-01' as date))
 as [deduction_itself_date],
        
DATEADD(DAY, [maternity_leave_start_date], cast('1970-01-01' as date))
 as [maternity_leave_start_date],
        
DATEADD(DAY, [maternity_leave_end_date], cast('1970-01-01' as date))
 as [maternity_leave_end_date],
        
DATEADD(DAY, [identification_date], cast('1970-01-01' as date))
 as [identification_date],
        
DATEADD(DAY, [identification_expire_date], cast('1970-01-01' as date))
 as [identification_expire_date],
        
DATEADD(DAY, [passport_date], cast('1970-01-01' as date))
 as [passport_date],
        
DATEADD(DAY, [passport_expire_date], cast('1970-01-01' as date))
 as [passport_expire_date],
        [has_maternity_leave],
        [employee_token],
        [created_from_attendance_device],
        [manual_attendance_manager_id],
        
DATEADD(DAY, [first_non_trial_contract_date], cast('1970-01-01' as date))
 as [first_non_trial_contract_date],
        
DATEADD(DAY, [termination_date], cast('1970-01-01' as date))
 as [termination_date],
        [advance_account_id],
        [overtime_manager_id],
        [administrative_region_id],
        [salary_to_bank],
        [department_manager_id],
        [department_parent_manager_id],
        [home_town],
        [spouse_mobile],
        [identity_card_id],
        [identity_card_place],
        [employee_option],
        
DATEADD(DAY, [identity_card_date], cast('1970-01-01' as date))
 as [identity_card_date],
        
DATEADD(DAY, [identity_card_expire_date], cast('1970-01-01' as date))
 as [identity_card_expire_date],
        [has_accident_insruance],
        [request_id],
        [hospital_id],
        [recommender],
        [deformity],
        [has_deformity],
        [weight],
        [height],
        [dyob],
        [mob],
        [yob],
        [hr_employee_resignations_count],
        [resigned],
        [last_appraisal_id],
        [ongoing_appraisal_count],
        [appraisal_count],
        
DATEADD(DAY, [next_appraisal_date], cast('1970-01-01' as date))
 as [next_appraisal_date],
        
DATEADD(DAY, [last_appraisal_date], cast('1970-01-01' as date))
 as [last_appraisal_date],
        [is_manual_input_first_contract_date],
        [dest_location_id]
from ranked
where rn = 1