select
    id             as customer_key,
    name           as customer_name,
    company_type   as customer_type,
    street         as customer_location,
    email          as customer_email
from [wh_core].[cc1].[int_xboss__res_partner_current]
where __is_deleted = 0
    and active = 1