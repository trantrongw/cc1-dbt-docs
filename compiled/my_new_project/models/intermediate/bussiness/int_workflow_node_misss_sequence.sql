select
    id,
    workflow_id,
    [sequence] = row_number() over (partition by workflow_id order by id)
from [wh_core].[cc1].[int_xboss__workflow_node_current]
where __is_deleted = 0
    and id <> 20
    and workflow_id in (
        select workflow_id
        from [wh_core].[cc1].[int_xboss__workflow_node_current]
        where __is_deleted = 0
            and id <> 20
        group by workflow_id
        having sum([sequence]) = 0
    )