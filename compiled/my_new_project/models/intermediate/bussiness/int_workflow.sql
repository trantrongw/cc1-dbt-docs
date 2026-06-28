with
    wf_node as (
        select *
        from [wh_core].[cc1].[int_xboss__workflow_node_current]
        where __is_deleted = 0
            and id <> 20
    ),
    wf_base as (
        select *
        from [wh_core].[cc1].[int_xboss__workflow_base_current]
        where __is_deleted = 0
            and id <> 20
    ),
    wf_config as (
        select *
        from [wh_core].[cc1].[int_xboss__workflow_config_current]
        where __is_deleted = 0
            and active = 1
    )
select
    [workflow_key] =
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(b.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(d.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    cast(
        coalesce(
            json_value(a.name, '$.vi_VN'), json_value(a.name, '$.en_US')
        ) as varchar(1000)
    ) as vn_workflow_stage,
    b.name as workflow_base,
    d.name as approval_workflow,
    approval_workflow_code = case
        when
            charindex('[', d.name) > 0
            and charindex(']', d.name) > charindex('[', d.name)
        then
            substring(
                d.name,
                charindex('[', d.name) + 1,
                charindex(']', d.name) - charindex('[', d.name) - 1
            )
        else 'Unknow'
    end,
    a.workflow_id * 100 + a.sequence as vn_workflow_stage_order,
    is_start = iif(a.is_start = 1, 'Mở', 'Không'),
    -- ,is_start_number = a.is_start
    is_end = iif(e.node_id is not null, 'Đóng', 'Chưa đóng'),
    -- ,is_end_number = a.is_close_workflow
    coalesce(c.group_name, 'Unknow') as group_name,
    coalesce(c.group_order, 0) as group_order,
    a.workflow_id,
    workflow_node_id = a.id,
    expense_workflow_id = d.id,
    a.sequence

from wf_node a
inner join wf_base b on a.workflow_id = b.id
inner join wf_config d on b.id = d.workflow_id
left join [wh_core].[cc1].[int_workflow_stages] c on a.id = c.id
left join [wh_core].[cc1].[int_workflow_node_close_workflow] e on a.id = e.node_id
union all
select
    [workflow_key] =
    lower(convert(varchar(50), hashbytes('md5', coalesce(convert(varchar(8000), concat(coalesce(cast(a.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(b.id as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'), '-', coalesce(cast(NULL as VARCHAR(8000)), '_dbt_utils_surrogate_key_null_'))), '')), 2))
,
    cast(
        coalesce(
            json_value(a.name, '$.vi_VN'), json_value(a.name, '$.en_US')
        ) as varchar(1000)
    ) as vn_workflow_stage,
    workflow_base = b.name,
    approval_workflow = 'Unknow',
    approval_workflow_code = 'Unknow',
    vn_workflow_stage_order
    = a.workflow_id * 100 + iif(d.id is null, a.sequence, d.sequence),
    is_start = iif(a.is_start = 1, 'Mở', 'Không'),
    -- ,is_start_number = a.is_start
    is_end = iif(e.node_id is not null, 'Đóng', 'Chưa đóng'),
    -- ,is_end_number = a.is_close_workflow
    group_name = coalesce(c.group_name, 'Unknow'),
    group_order = coalesce(c.group_order, 0),
    a.workflow_id,
    workflow_node_id = a.id,
    expense_workflow_id = null,
    a.sequence
from wf_node a
inner join wf_base b on a.workflow_id = b.id
left join [wh_core].[cc1].[int_workflow_stages] c on a.id = c.id
left join
    [wh_core].[cc1].[int_workflow_node_misss_sequence] d
    on a.workflow_id = a.workflow_id
    and a.id = d.id
left join [wh_core].[cc1].[int_workflow_node_close_workflow] e on a.id = e.node_id