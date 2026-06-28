with base_union as (


        (
            select
                cast('[wh_core].[cc1].[analytics_account]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast(null as int) as [company_key] ,
                    cast(null as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[analytics_account]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[approval_age_groups]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as varchar(400)) as [account_analytic_key] ,
                    cast([approval_age_group_key] as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast(null as int) as [company_key] ,
                    cast(null as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[approval_age_groups]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[approval_log]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast([approval_log_key] as int) as [approval_log_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[approval_log]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[approval]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast([approval_age_group_key] as int) as [approval_age_group_key] ,
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast([sale_order_key] as int) as [sale_order_key] ,
                    cast([purchase_order_key] as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[approval]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[company]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast(null as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[company]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[contract_type]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast(null as int) as [company_key] ,
                    cast(null as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[contract_type]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[customer]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast(null as int) as [company_key] ,
                    cast(null as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[customer]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[project]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast(null as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[project]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[workflow]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast(null as int) as [company_key] ,
                    cast(null as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast(null as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[workflow]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[bb]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast([purchase_order_key] as int) as [purchase_order_key] ,
                    cast([bb_key] as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[bb]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[ab]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast([approval_key] as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast([sale_order_key] as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast([ab_key] as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[ab]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[ipc_ab]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast([sale_order_key] as int) as [sale_order_key] ,
                    cast([purchase_order_key] as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast([ipc_ab_key] as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[ipc_ab]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[ipc_bb]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast([employee_key] as int) as [employee_key] ,
                    cast([workflow_key] as varchar(400)) as [workflow_key] ,
                    cast([create_date_key] as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast([contract_type_key] as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast([sale_order_key] as int) as [sale_order_key] ,
                    cast([purchase_order_key] as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast([ipc_bb_key] as int) as [ipc_bb_key] ,
                    cast(null as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[ipc_bb]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[account_payment]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([account_analytic_key] as varchar(400)) as [account_analytic_key] ,
                    cast(null as int) as [approval_age_group_key] ,
                    cast(null as varchar(400)) as [approval_key] ,
                    cast(null as int) as [approval_log_key] ,
                    cast(null as int) as [employee_key] ,
                    cast(null as varchar(400)) as [workflow_key] ,
                    cast(null as date) as [create_date_key] ,
                    cast([company_key] as int) as [company_key] ,
                    cast([project_key] as int) as [project_key] ,
                    cast(null as varchar(38)) as [contract_type_key] ,
                    cast([customer_key] as int) as [customer_key] ,
                    cast(null as int) as [sale_order_key] ,
                    cast(null as int) as [purchase_order_key] ,
                    cast(null as int) as [bb_key] ,
                    cast(null as int) as [ab_key] ,
                    cast(null as int) as [ipc_ab_key] ,
                    cast(null as int) as [ipc_bb_key] ,
                    cast([payment_key] as varchar(50)) as [payment_key] 

            from [wh_core].[cc1].[account_payment]

            
        )

        
)

select
    "create_date_key",
    "account_analytic_key",
    "approval_age_group_key",
    "approval_key",
    "approval_log_key",
    "company_key",
    "contract_type_key",
    "customer_key",
    "employee_key",
    "project_key",
    "workflow_key",
    "sale_order_key",
    "ab_key",
    "purchase_order_key",
    "bb_key",
    "ipc_ab_key",
    "ipc_bb_key",
    payment_key,
    _dbt_source_relation = cast(PARSENAME(_dbt_source_relation, 1) as varchar(255))
from base_union