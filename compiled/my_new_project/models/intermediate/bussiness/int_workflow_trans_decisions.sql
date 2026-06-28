select concat(a.node_from, '$$', a.workflow_id) as _node
from [wh_core].[cc1].[int_xboss__workflow_trans_current] a
where a.__is_deleted = 0
    and a.sequence is not null and a.trans_type = 'auto'
group by concat(a.node_from, '$$', a.workflow_id)