with base_union as
(


        (
            select
                cast('[wh_core].[cc1].[int_error__contract_and_log_node]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast(null as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__contract_and_log_node]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_error__eap_no_project]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast(null as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast(null as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__eap_no_project]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_error__hes_no_project]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast(null as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__hes_no_project]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_error__jc_wrong_business_type]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast(null as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__jc_wrong_business_type]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_error__po_no_analytic_distribution]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast(null as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__po_no_analytic_distribution]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_error__workflow]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast(null as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__workflow]

            
        )

        union all
        

        (
            select
                cast('[wh_core].[cc1].[int_error__ap_duplicate_payment]' as VARCHAR(8000)) as _dbt_source_relation,

                /* No columns from any of the relations.
                   This star is only output during dbt compile, and exists to keep SQLFluff happy. */
                

                
                    cast([id] as int) as [id] ,
                    cast([model] as varchar(29)) as [model] ,
                    cast([link] as varchar(8000)) as [link] ,
                    cast([error_code] as varchar(6)) as [error_code] ,
                    cast([duplicate_group] as varchar(400)) as [duplicate_group] 

            from [wh_core].[cc1].[int_error__ap_duplicate_payment]

            
        )

        
)
select
    
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(error_code as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(model as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
  as error_key,
    error_code,
    id,
    model,
    link,
    duplicate_group,
    CAST(GETDATE() AS DATE) as report_date
from base_union