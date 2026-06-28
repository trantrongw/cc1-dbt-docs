select id as node_id, is_end = 1
from [wh_core].[cc1].[int_xboss__workflow_node_current]
where __is_deleted = 0
    and id <> 20
    and is_close_workflow = 1
    and workflow_id not in (43, 46)
union all
select id as node_id, is_end = 1
from [wh_core].[cc1].[int_xboss__workflow_node_current]
where __is_deleted = 0
    and id <> 20
    and is_final_approval = 1
    and workflow_id in (43, 46)