with union_data
as
(


        (
            select
                cast('[wh_core].[cc1].[int_material_purchase_requisition_account_analytic_mapping]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([business_plan_id] as int) as [business_plan_id] ,
                    cast([business_unit_id] as int) as [business_unit_id] ,
                    cast([department_id] as int) as [department_id] ,
                    cast([revenue_item_id] as int) as [revenue_item_id] ,
                    cast([cost_item_id] as int) as [cost_item_id] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] 

            from [wh_core].[cc1].[int_material_purchase_requisition_account_analytic_mapping]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_purchase_order_account_analytic_mapping]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([business_plan_id] as int) as [business_plan_id] ,
                    cast([business_unit_id] as int) as [business_unit_id] ,
                    cast([department_id] as int) as [department_id] ,
                    cast([revenue_item_id] as int) as [revenue_item_id] ,
                    cast([cost_item_id] as int) as [cost_item_id] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] 

            from [wh_core].[cc1].[int_purchase_order_account_analytic_mapping]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_sale_order_account_analytic_mapping]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([business_plan_id] as int) as [business_plan_id] ,
                    cast([business_unit_id] as int) as [business_unit_id] ,
                    cast([department_id] as int) as [department_id] ,
                    cast([revenue_item_id] as int) as [revenue_item_id] ,
                    cast([cost_item_id] as int) as [cost_item_id] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] 

            from [wh_core].[cc1].[int_sale_order_account_analytic_mapping]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_job_costing_account_analytic_mapping]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([business_plan_id] as int) as [business_plan_id] ,
                    cast([business_unit_id] as int) as [business_unit_id] ,
                    cast([department_id] as int) as [department_id] ,
                    cast([revenue_item_id] as int) as [revenue_item_id] ,
                    cast([cost_item_id] as int) as [cost_item_id] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] 

            from [wh_core].[cc1].[int_job_costing_account_analytic_mapping]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_hr_expense_sheet_account_analytic_mapping]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([business_plan_id] as int) as [business_plan_id] ,
                    cast([business_unit_id] as int) as [business_unit_id] ,
                    cast([department_id] as int) as [department_id] ,
                    cast([revenue_item_id] as int) as [revenue_item_id] ,
                    cast([cost_item_id] as int) as [cost_item_id] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] 

            from [wh_core].[cc1].[int_hr_expense_sheet_account_analytic_mapping]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_employee_advance_account_analytic_mapping]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([business_plan_id] as int) as [business_plan_id] ,
                    cast([business_unit_id] as int) as [business_unit_id] ,
                    cast([department_id] as int) as [department_id] ,
                    cast([revenue_item_id] as int) as [revenue_item_id] ,
                    cast([cost_item_id] as int) as [cost_item_id] ,
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] 

            from [wh_core].[cc1].[int_employee_advance_account_analytic_mapping]

            
        )

        
)
select *
from  union_data