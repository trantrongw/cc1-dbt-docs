with account_analytic
as
(
select
    a.id
    ,model = 'job.costing'
    ,business_plan_id = c.analytic_account_id
    ,business_unit_id = null
    ,department_id = b.analytic_account_id
    ,revenue_item_id = null
    ,cost_item_id = null
    FROM [wh_core].[cc1].[int_xboss__job_costing_current] a
    left join [wh_core].[cc1].[int_xboss__hr_department_current] b
        on a.department_id = b.id
        and b.__is_deleted = 0
    left join [wh_core].[cc1].[int_xboss__project_project_current] c
        on a.project_id = c.id
        and c.__is_deleted = 0
        and c.active = 1
    where a.__is_deleted = 0
        and a.company_id = 1
)
select
    *
    , account_analytic_key = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(business_plan_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(business_unit_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(department_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(revenue_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(cost_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))


from account_analytic