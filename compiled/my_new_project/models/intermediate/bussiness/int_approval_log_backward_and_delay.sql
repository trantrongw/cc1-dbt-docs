select
    approval_key,
    iif(sum(is_backward) > 0, 'yes', 'no') as is_backward,
    iif(sum(is_delay) > 0, 'yes', 'no') as is_delay,
    sum(estimated_processing_time) as estimated_processing_time_overall
from [wh_core].[cc1].[int_approval_log]
group by approval_key