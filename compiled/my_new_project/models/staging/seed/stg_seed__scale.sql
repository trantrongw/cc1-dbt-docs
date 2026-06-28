select 
    scale_id=cast(scale_id as int)
    ,money_scale_order=cast(money_scale_order as int)
    ,money_scale_description=cast(money_scale_description as varchar(50))
    ,money_scale_number=cast(money_scale_number as int)
    ,money_scale_unit=cast(money_scale_unit as varchar(50))
from [wh_core].[cc1_seed_data].[seed_scale]