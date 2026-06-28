select
    [_dbt_source_relation],
  [approval_key],
  [employee_key],
  [company_key],
  [workflow_key],
  [project_key],
  [create_date_key],
  [create_date_vn],
  [x_workflow_state_date_vn],
  [start_date],
  [end_date],
  [days],
  [approval_code],
  [approval_name],
  [id],
  [model],
  [link],
  [state],
  [priority],
  [payment_state],
  [account_analytic_key],
  [customer_key],
  [sale_order_key],
  [x_workflow_stage_id],
  [is_customer_contract],
  [active],
  [purchase_order_key],
  [is_sub_contract],
  [business_type],
  [is_backward],
  [is_delay],
  [is_error],
  [is_delay_overall],
    contract_type_key = coalesce(contract_type, model),
    case
        when days < 2
        then 1
        when days >= 2 and days < 4
        then 2
        when days >= 4 and days < 8
        then 3
        else 4
    end as approval_age_group_key
from [wh_core].[cc1].[int_approval]