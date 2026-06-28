with
    account_analytic as (
        select
            a.id,
            model = 'sale.order',
            business_plan_id = max(d.id),
            business_unit_id = max(e.id),
            department_id = max(f.id),
            revenue_item_id = max(g.id),
            cost_item_id = max(h.id)
        from
            [wh_core].[cc1].[int_xboss__sale_order_current] a
            cross apply openjson(a.analytic_distribution) b
            cross apply string_split(b. [key], ',') c
        left join
            [wh_core].[cc1].[int_xboss__account_analytic_account_current] d
            on c. [value] = d.id
            and d.plan_id = 1
            and d.__is_deleted = 0
            and d.active = 1
        left join
            [wh_core].[cc1].[int_xboss__account_analytic_account_current] e
            on c. [value] = e.id
            and e.plan_id = 6
            and e.__is_deleted = 0
            and e.active = 1
        left join
            [wh_core].[cc1].[int_xboss__account_analytic_account_current] f
            on c. [value] = f.id
            and f.plan_id = 3
            and f.__is_deleted = 0
            and f.active = 1
        left join
            [wh_core].[cc1].[int_xboss__account_analytic_account_current] g
            on c. [value] = g.id
            and g.plan_id = 4
            and g.__is_deleted = 0
            and g.active = 1
        left join
            [wh_core].[cc1].[int_xboss__account_analytic_account_current] h
            on c. [value] = h.id
            and h.plan_id = 5
            and h.__is_deleted = 0
            and h.active = 1
        where a.__is_deleted = 0
            and a.company_id = 1
            and a.id not in (7138)
        group by a.id
    )
select
    *,
    account_analytic_key
    = 
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(business_plan_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(business_unit_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(department_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(revenue_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(cost_item_id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))


from account_analytic