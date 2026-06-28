select
    id,
    code,
    name,
    account_type,
    internal_group,
    company_id,
    currency_id,
    reconcile,
    deprecated
from [wh_core].[cc1].[int_xboss__account_account_current]
where __is_deleted = 0
    and deprecated = 0