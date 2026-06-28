select
    *,ipc_bb_key = ipc_key 
from [wh_core].[cc1].[int_construction_ipc]
where is_customer_ipc <> 1