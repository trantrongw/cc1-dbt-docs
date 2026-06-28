
    
    

with all_values as (

    select
        error_status as value_field,
        count(*) as n_records

    from [wh_core].[cc1].[error_history]
    group by error_status

)

select *
from all_values
where value_field not in (
    'new','persisting','resolved'
)


