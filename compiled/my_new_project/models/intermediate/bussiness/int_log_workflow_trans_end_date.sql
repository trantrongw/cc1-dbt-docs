select
    a.res_id as id,
    model,
    lead(a.create_uid) over (
        partition by a.model, a.res_id order by a.create_date
    ) as create_uid,
    a.node_to as node_to,
    cast(
        coalesce(
            json_value(c.name, '$.vi_VN'), json_value(c.name, '$.en_US')
        ) as varchar(1000)
    ) as node,
    a.create_date as start_date,
    lead(a.create_date) over (
        partition by a.model, a.res_id order by a.create_date
    ) as end_date,
    c.estimated_processing_time,
    a.is_backward,
    a.create_date,
    id_log=a.id
from [wh_core].[cc1].[int_log_workflow_trans_deduplication] a
inner join [wh_core].[cc1].[int_xboss__workflow_node_current] c on a.node_to = c.id
    and c.__is_deleted = 0
    and c.id <> 20