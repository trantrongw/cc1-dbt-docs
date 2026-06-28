with
    next_node as (
        select
            a.id,
            a.model,
            a.username,
            a.create_uid,
            a.res_id,
            a.create_date,
            a.node_id,
            a.trans_id,
            b.node_to,
            lead(node_id) over (
                partition by a.model, a.res_id order by a.create_date
            ) as next_node,
            is_backward = iif(a.active = 0, 1, 0)
        from [wh_core].[cc1].[int_xboss__log_workflow_trans_current] a
        left join [wh_core].[cc1].[int_xboss__workflow_trans_current] b on a.trans_id = b.id
        where a.__is_deleted = 0
            and concat(b.node_to, '$$', b.workflow_id)
            not in (select _node from [wh_core].[cc1].[int_workflow_trans_decisions])
            and a.id not in (
                296794,
                306410,
                306411,
                306413,
                306415,
                306417,
                306418,
                306421,
                306424,
                306441,
                306440
            )
    -- and model = 'employee.advance'
    ),
    dedup as (select * from next_node where node_id <> isnull(next_node, '-1'))
select *
from dedup a