with wf_close_count as
(
    -- đếm node kết thúc theo từng workflow (xử lý riêng PO id 43/46 dùng is_final_approval)
    select a.id, count(b.id) as cnt
    from [wh_core].[cc1].[int_xboss__workflow_base_current] a
        left join [wh_core].[cc1].[int_xboss__workflow_node_current] b
            on a.id = b.workflow_id
            and b.__is_deleted = 0
            and b.id <> 20
            and (
                (a.id not in (43, 46) and b.is_close_workflow = 1)
                or (a.id in (43, 46) and b.is_final_approval = 1)
            )
    where a.__is_deleted = 0
        and a.id <> 20
    group by a.id
),

wf_mapped as
(
    -- workflow đã có ít nhất 1 stage trong seed_workflow_stages
    select b.workflow_id
    from [wh_core].[cc1].[int_workflow_stages] a
        inner join [wh_core].[cc1].[int_xboss__workflow_node_current] b
            on a.id = b.id
            and b.__is_deleted = 0
            and b.id <> 20
    group by b.workflow_id
),

WF001 as (select id from wf_close_count where cnt = 0),

WF002 as (select id from wf_close_count where cnt > 1),

WF003 as
(
    -- node thuộc workflow đã mapping nhưng bản thân node chưa có trong seed_workflow_stages
    select a.id, a.workflow_id
    from [wh_core].[cc1].[int_xboss__workflow_node_current] a
        inner join wf_mapped b on a.workflow_id = b.workflow_id
    where a.__is_deleted = 0
        and a.id <> 20
        and a.id not in (select id from [wh_core].[cc1].[int_workflow_stages])
)

select b.id,
    model = 'workflow.base',
    link = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&model=workflow.base&view_type=form&menu_id=193', '{id}', cast(b.id as varchar)),
    a.error_code
from (
    select id, error_code = 'WF001' from WF001
    union all
    select id, error_code = 'WF002' from WF002
    union all
    select id, error_code = 'WF003' from WF003
) a
inner join [wh_core].[cc1].[int_xboss__workflow_base_current] b
    on a.id = b.id
    and b.__is_deleted = 0
    and b.id <> 20