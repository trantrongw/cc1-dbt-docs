with
    company_levels as (
        select
            c.id,
            c.parent_id,
            c.name,
            c.parent_path,
            max(case when s.ordinal = 1 then try_cast(s.value as int) end) as level1_id,
            max(case when s.ordinal = 2 then try_cast(s.value as int) end) as level2_id,
            max(case when s.ordinal = 3 then try_cast(s.value as int) end) as level3_id
        from [wh_core].[cc1].[int_xboss__res_company_current] c
        cross apply string_split(trim('/' from c.parent_path), '/', 1) s
        where c.__is_deleted = 0
            and c.active = 1
        group by c.id, c.parent_id, c.name, c.parent_path
    ),
    add_level as (
        select
            cl.id,
            cl.parent_id,
            cl.name,
            cl.parent_path,
            cl.level1_id,
            l1.name as level1_name,
            cl.level2_id,
            l2.name as level2_name,
            cl.level3_id,
            l3.name as level3_name
        from company_levels cl
        left join [wh_core].[cc1].[int_xboss__res_company_current] l1 on cl.level1_id = l1.id
        left join [wh_core].[cc1].[int_xboss__res_company_current] l2 on cl.level2_id = l2.id
        left join [wh_core].[cc1].[int_xboss__res_company_current] l3 on cl.level3_id = l3.id
    )
select
    id             as company_key,
    name           as company_name,
    level1_name    as company_level1,
    coalesce(level2_name, level1_name) as company_level2
from add_level