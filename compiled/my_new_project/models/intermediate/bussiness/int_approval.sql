with
    union_data as (
        

        (
            select
                cast('[wh_core].[cc1].[int_hr_expense_sheet_approval]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([create_date_vn] as datetime2(6)) as [create_date_vn] ,
                    cast([x_workflow_state_date_vn] as datetime2(6)) as [x_workflow_state_date_vn] ,
                    cast([start_date] as datetime2(6)) as [start_date] ,
                    cast([end_date] as datetime2(6)) as [end_date] ,
                    cast([days] as int) as [days] ,
                    cast([approval_code] as varchar(8000)) as [approval_code] ,
                    cast([approval_name] as varchar(8000)) as [approval_name] ,
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([state] as varchar(8000)) as [state] ,
                    cast([priority] as varchar(6)) as [priority] ,
                    cast([payment_state] as varchar(6)) as [payment_state] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [x_workflow_stage_id] ,
                    cast(null as bit) as [is_customer_contract] ,
                    cast(null as int) as [active] ,
                    cast(null as varchar(23)) as [contract_type] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as bit) as [is_sub_contract] ,
                    cast(null as varchar(8000)) as [business_type] 

            from [wh_core].[cc1].[int_hr_expense_sheet_approval]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_employee_advance_approval]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([create_date_vn] as datetime2(6)) as [create_date_vn] ,
                    cast([x_workflow_state_date_vn] as datetime2(6)) as [x_workflow_state_date_vn] ,
                    cast([start_date] as datetime2(6)) as [start_date] ,
                    cast([end_date] as datetime2(6)) as [end_date] ,
                    cast([days] as int) as [days] ,
                    cast([approval_code] as varchar(8000)) as [approval_code] ,
                    cast([approval_name] as varchar(8000)) as [approval_name] ,
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([state] as varchar(8000)) as [state] ,
                    cast([priority] as varchar(6)) as [priority] ,
                    cast([payment_state] as varchar(6)) as [payment_state] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [x_workflow_stage_id] ,
                    cast(null as bit) as [is_customer_contract] ,
                    cast(null as int) as [active] ,
                    cast(null as varchar(23)) as [contract_type] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as bit) as [is_sub_contract] ,
                    cast(null as varchar(8000)) as [business_type] 

            from [wh_core].[cc1].[int_employee_advance_approval]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_sale_order]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([create_date_vn] as datetime2(6)) as [create_date_vn] ,
                    cast([x_workflow_state_date_vn] as datetime2(6)) as [x_workflow_state_date_vn] ,
                    cast([start_date] as datetime2(6)) as [start_date] ,
                    cast([end_date] as datetime2(6)) as [end_date] ,
                    cast([days] as int) as [days] ,
                    cast([approval_code] as varchar(8000)) as [approval_code] ,
                    cast([approval_name] as varchar(8000)) as [approval_name] ,
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([state] as varchar(8000)) as [state] ,
                    cast([priority] as varchar(6)) as [priority] ,
                    cast([payment_state] as varchar(6)) as [payment_state] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast([sale_order_key] as int) as [sale_order_key] ,
                    cast([x_workflow_stage_id] as int) as [x_workflow_stage_id] ,
                    cast([is_customer_contract] as bit) as [is_customer_contract] ,
                    cast([active] as int) as [active] ,
                    cast([contract_type] as varchar(23)) as [contract_type] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as bit) as [is_sub_contract] ,
                    cast(null as varchar(8000)) as [business_type] 

            from [wh_core].[cc1].[int_sale_order]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_purchase_order]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([create_date_vn] as datetime2(6)) as [create_date_vn] ,
                    cast([x_workflow_state_date_vn] as datetime2(6)) as [x_workflow_state_date_vn] ,
                    cast([start_date] as datetime2(6)) as [start_date] ,
                    cast([end_date] as datetime2(6)) as [end_date] ,
                    cast([days] as int) as [days] ,
                    cast([approval_code] as varchar(8000)) as [approval_code] ,
                    cast([approval_name] as varchar(8000)) as [approval_name] ,
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([state] as varchar(8000)) as [state] ,
                    cast([priority] as varchar(6)) as [priority] ,
                    cast([payment_state] as varchar(6)) as [payment_state] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast([x_workflow_stage_id] as int) as [x_workflow_stage_id] ,
                    cast(null as bit) as [is_customer_contract] ,
                    cast([active] as int) as [active] ,
                    cast([contract_type] as varchar(23)) as [contract_type] ,
                    cast([purchase_order_key] as int) as [purchase_order_key] ,
                    cast([is_sub_contract] as bit) as [is_sub_contract] ,
                    cast(null as varchar(8000)) as [business_type] 

            from [wh_core].[cc1].[int_purchase_order]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_material_purchase_requisition]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([create_date_vn] as datetime2(6)) as [create_date_vn] ,
                    cast([x_workflow_state_date_vn] as datetime2(6)) as [x_workflow_state_date_vn] ,
                    cast([start_date] as datetime2(6)) as [start_date] ,
                    cast([end_date] as datetime2(6)) as [end_date] ,
                    cast([days] as int) as [days] ,
                    cast([approval_code] as varchar(8000)) as [approval_code] ,
                    cast([approval_name] as varchar(8000)) as [approval_name] ,
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([state] as varchar(8000)) as [state] ,
                    cast([priority] as varchar(6)) as [priority] ,
                    cast([payment_state] as varchar(6)) as [payment_state] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [x_workflow_stage_id] ,
                    cast(null as bit) as [is_customer_contract] ,
                    cast([active] as int) as [active] ,
                    cast(null as varchar(23)) as [contract_type] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as bit) as [is_sub_contract] ,
                    cast(null as varchar(8000)) as [business_type] 

            from [wh_core].[cc1].[int_material_purchase_requisition]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_job_costing]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([create_date_vn] as datetime2(6)) as [create_date_vn] ,
                    cast([x_workflow_state_date_vn] as datetime2(6)) as [x_workflow_state_date_vn] ,
                    cast([start_date] as datetime2(6)) as [start_date] ,
                    cast([end_date] as datetime2(6)) as [end_date] ,
                    cast([days] as int) as [days] ,
                    cast([approval_code] as varchar(8000)) as [approval_code] ,
                    cast([approval_name] as varchar(8000)) as [approval_name] ,
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([state] as varchar(8000)) as [state] ,
                    cast([priority] as varchar(6)) as [priority] ,
                    cast([payment_state] as varchar(6)) as [payment_state] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [x_workflow_stage_id] ,
                    cast(null as bit) as [is_customer_contract] ,
                    cast([active] as int) as [active] ,
                    cast(null as varchar(23)) as [contract_type] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as bit) as [is_sub_contract] ,
                    cast([business_type] as varchar(8000)) as [business_type] 

            from [wh_core].[cc1].[int_job_costing]

            
        )

        
    )
select
    a.*,
    is_backward = iif(b.is_backward = 'yes', 'Có', 'Không'),
    is_delay = iif(b.is_delay = 'yes', 'Có', 'Không'),
    is_error = iif(c.approval_key is null, 'Không', 'Có'),
    is_delay_overall = iif(b.estimated_processing_time_overall > a.days,'Có', 'Không')
from union_data a
left join
    [wh_core].[cc1].[int_approval_log_backward_and_delay] b
    on a.approval_key = b.approval_key
left join
    [wh_core].[cc1].[int_error__contract_and_log_node] c
    on a.approval_key = c.approval_key