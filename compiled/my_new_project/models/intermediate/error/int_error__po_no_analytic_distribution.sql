select
    id,
    model = 'purchase.order',
    link  = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1156&action=1924&model=purchase.order&view_type=form', '{id}', cast(id as varchar)),
    error_code = 'PO001'
from [wh_core].[cc1].[int_xboss__purchase_order_current]
where __is_deleted = 0
    and company_id = 1
    and analytic_distribution is null