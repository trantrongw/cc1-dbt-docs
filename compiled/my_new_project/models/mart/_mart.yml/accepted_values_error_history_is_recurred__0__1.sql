
    
    

with all_values as (

    select
        is_recurred as value_field,
        count(*) as n_records

    from [wh_core].[cc1].[error_history]
    group by is_recurred

)

select *
from all_values
where value_field not in (
    '0','1'
)


